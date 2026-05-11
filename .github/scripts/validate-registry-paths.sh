#!/usr/bin/env bash
# validate-registry-paths.sh
#
# Validates that all 'path' and 'config' values registered in registry.json
# exist as files or directories in the repository.
#
# Sync mode (--sync): reports files under agents/ and library/ that are not
# represented in registry.json path/config/template references.
#
# Requirements: bash 4+, python3
# Run from the repository root.

set -euo pipefail

# F8: bash version guard (mapfile requires bash 4+)
if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "ERROR: bash 4+ required (found ${BASH_VERSION})." >&2
    exit 1
fi

REGISTRY="registry.json"
MODE="validate"

usage() {
    cat <<'EOF'
Usage:
  .github/scripts/validate-registry-paths.sh         # strict path validation
  .github/scripts/validate-registry-paths.sh --sync  # report unregistered assets

Exit codes:
  0 = success
  1 = strict validation failed (missing registered paths)
  2 = invalid usage
  3 = operational error in --sync mode
EOF
}

if [ "$#" -gt 1 ]; then
    usage >&2
    exit 2
fi

if [ "$#" -eq 1 ]; then
    case "$1" in
        --sync)
            MODE="sync"
        ;;
        -h | --help)
            usage
            exit 0
        ;;
        *)
            echo "ERROR: Unknown argument '$1'." >&2
            usage >&2
            exit 2
        ;;
    esac
fi

if [ ! -f "$REGISTRY" ]; then
    echo "ERROR: $REGISTRY not found. Run this script from the repository root." >&2
    if [ "$MODE" = "sync" ]; then
        exit 3
    fi
    exit 1
fi

if [ "$MODE" = "sync" ]; then
    TMP_SYNC=$(mktemp)
    trap 'rm -f "$TMP_SYNC"' EXIT
    
    if ! python3 - "$REGISTRY" >"$TMP_SYNC" <<'PYEOF'
import json
import os
import re
import sys

REGISTRY_PATH = sys.argv[1]

def norm(path: str) -> str:
    return path.replace("\\", "/").strip("./")

def slug(path: str) -> str:
    base = os.path.basename(path)
    base = re.sub(r"\.(agent\.md|instructions\.md|prompt\.md|ya?ml|md|txt|json)$", "", base)
    base = re.sub(r"[^a-zA-Z0-9]+", "-", base).strip("-").lower()
    return base or "asset-id"

def classify(path: str):
    p = path
    if p.endswith(".agent.md"):
        return "agents", slug(p), "agent-md"
    if p.endswith(".instructions.md"):
        return "instructions", slug(p), "instructions-md"
    if p.endswith(".prompt.md"):
        return "intelligence", slug(p), "prompt-md"
    if "/workflows/" in p and (p.endswith(".yml") or p.endswith(".yaml")):
        return "workflows", slug(p), "workflow-yml"
    if p.startswith("library/standards/") and p.endswith(".md"):
        return "standards", slug(p), "standard-md"
    if p.endswith("llms.txt"):
        return "intelligence", slug(p), "llms-index"
    return "unknown", slug(p), "manual-review"

def extract_registered_paths(data):
    registered = set()

    def visit(obj):
        if isinstance(obj, dict):
            for k, v in obj.items():
                if k in ("path", "config") and isinstance(v, str):
                    registered.add(norm(v))
                else:
                    visit(v)
        elif isinstance(obj, list):
            for item in obj:
                visit(item)

    visit(data)

    # Expand issue strategy template filenames into concrete file paths
    # (templates are stored as bare filenames in registry).
    issue_strategies = (
        data.get("assets", {})
        .get("issue_strategies", {})
    )
    if isinstance(issue_strategies, dict):
        for item in issue_strategies.values():
            if not isinstance(item, dict):
                continue
            base = item.get("path")
            templates = item.get("templates")
            if isinstance(base, str) and isinstance(templates, list):
                base_norm = norm(base).rstrip("/")
                for t in templates:
                    if isinstance(t, str):
                        registered.add(f"{base_norm}/{norm(t)}")

    return registered

def scan_files(root):
    scanned = []
    for top in ("agents", "library"):
        abs_top = os.path.join(root, top)
        if not os.path.isdir(abs_top):
            continue
        for dirpath, _, filenames in os.walk(abs_top):
            for name in filenames:
                rel = os.path.relpath(os.path.join(dirpath, name), root)
                scanned.append(norm(rel))
    return sorted(set(scanned))

with open(REGISTRY_PATH, encoding="utf-8") as fh:
    data = json.load(fh)

registered = extract_registered_paths(data)
scanned = scan_files(".")

unregistered = [p for p in scanned if p not in registered]

print("SYNC_MODE|enabled")
print("SYNC_SCAN_ROOTS|agents,library")
print(f"SYNC_REGISTRY|{REGISTRY_PATH}")
print(f"SYNC_REGISTERED_PATHS|{len(registered)}")
print(f"SYNC_SCANNED_FILES|{len(scanned)}")
print(f"SYNC_UNREGISTERED_COUNT|{len(unregistered)}")

for p in unregistered:
    section, suggested_id, kind = classify(p)
    print(f"UNREGISTERED|{p}|{section}|{suggested_id}|{kind}")

print("SYNC_STATUS|ok")
PYEOF
    then
        echo "ERROR: Sync scanner (python3) failed. Check Python 3 availability and registry.json syntax." >&2
        exit 3
    fi
    
    cat "$TMP_SYNC"
    exit 0
fi

# Strict validation mode (legacy behavior).
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT

if ! python3 - "$REGISTRY" >"$TMPFILE" <<'PYEOF'
import json
import sys

def extract_paths(obj, acc=None):
    if acc is None:
        acc = []
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k in ("path", "config") and isinstance(v, str):
                acc.append(v)
            else:
                extract_paths(v, acc)
    elif isinstance(obj, list):
        for item in obj:
            extract_paths(item, acc)
    return acc

with open(sys.argv[1], encoding="utf-8") as fh:
    data = json.load(fh)

for p in extract_paths(data):
    print(p)
PYEOF
then
    echo "ERROR: Path extractor (python3) failed. Check that Python 3 is available and registry.json is valid JSON." >&2
    exit 1
fi

mapfile -t PATHS <"$TMPFILE"

if [ "${#PATHS[@]}" -eq 0 ]; then
    echo "ERROR: No paths extracted from registry. The registry structure may have changed. Aborting to avoid silent pass." >&2
    exit 1
fi

errors=0

for path in "${PATHS[@]}"; do
    if [ -e "$path" ]; then
        echo "OK:      $path"
    else
        echo "MISSING: $path"
        errors=$((errors + 1))
    fi
done

echo ""

if [ "$errors" -gt 0 ]; then
    echo "ERROR: $errors path(s) not found in the repository." >&2
    exit 1
fi

echo "All ${#PATHS[@]} registered path(s) verified successfully."
