#!/usr/bin/env bash
# validate-registry-paths.sh
#
# Validates that all 'path' and 'config' values registered in registry.json
# exist as files or directories in the repository.
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

if [ ! -f "$REGISTRY" ]; then
    echo "ERROR: $REGISTRY not found. Run this script from the repository root." >&2
    exit 1
fi

# F1: capture Python output to a temp file so failures are detectable.
# F4: extract only 'path' and 'config' keys — skip '$schema' (URL or local ref,
#     not a conventional repo path) and 'templates' array items (filenames, not paths).
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
            # Only treat 'path' and 'config' as filesystem paths.
            # '$schema' can be a remote URI; 'templates' items are bare filenames.
            if k in ("path", "config") and isinstance(v, str):
                acc.append(v)
            else:
                extract_paths(v, acc)
    elif isinstance(obj, list):
        for item in obj:
            extract_paths(item, acc)
    return acc

with open(sys.argv[1]) as fh:
    data = json.load(fh)

for p in extract_paths(data):
    print(p)
PYEOF
then
  echo "ERROR: Path extractor (python3) failed. Check that Python 3 is available and registry.json is valid JSON." >&2
  exit 1
fi

mapfile -t PATHS <"$TMPFILE"

# F2: guard against empty PATHS to prevent silent false pass.
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
