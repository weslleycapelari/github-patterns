#!/usr/bin/env bash
# validate-mission-protocol.sh
#
# Validates Mission Protocol compliance for pull requests.
#
# Rules:
# - Non-trivial changes require at least one changed mission file in .github/MISSIONS/*.md
#   (excluding README.md and _template.md)
# - Changed mission files must include all mandatory mission fields with non-empty values.
#
# Non-trivial scope:
#   agents/**, prompts/**, docs/**, library/**, standards/**, instructions/**,
#   stacks/**, .github/**, README*, registry.json, ROADMAP.md, structure.md
# Exception:
#   If changes are only inside .github/MISSIONS/**, PR is treated as trivial.

set -euo pipefail

if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "MISSION_PROTOCOL|FAIL|bash-4-required|found=${BASH_VERSION}" >&2
    exit 1
fi

resolve_range() {
    if [ -n "${BASE_SHA:-}" ] && [ -n "${HEAD_SHA:-}" ]; then
        echo "${BASE_SHA}...${HEAD_SHA}"
        return
    fi
    
    if [ "${GITHUB_EVENT_NAME:-}" = "pull_request" ] && [ -n "${GITHUB_BASE_REF:-}" ]; then
        git fetch --no-tags --depth=200 origin "${GITHUB_BASE_REF}" >/dev/null 2>&1 || true
        echo "origin/${GITHUB_BASE_REF}...${GITHUB_SHA:-HEAD}"
        return
    fi
    
    if git rev-parse --verify HEAD~1 >/dev/null 2>&1; then
        echo "HEAD~1...HEAD"
        return
    fi
    
    echo ""
}

RANGE="$(resolve_range)"

if [ -z "$RANGE" ]; then
    echo "MISSION_PROTOCOL|PASS|no-range-detected|treated-as-trivial"
    exit 0
fi

mapfile -t CHANGED_FILES < <(git diff --name-only --diff-filter=ACMRT "$RANGE" | sed '/^\s*$/d')

if [ "${#CHANGED_FILES[@]}" -eq 0 ]; then
    echo "MISSION_PROTOCOL|PASS|no-changes-detected|range=${RANGE}"
    exit 0
fi

NON_TRIVIAL=false
TRIGGER_FILES=()
MISSION_FILES=()

for file in "${CHANGED_FILES[@]}"; do
    # Any file inside .github/MISSIONS/** does not make PR non-trivial by itself.
    if [[ "$file" =~ ^\.github/MISSIONS/ ]]; then
        if [[ "$file" =~ ^\.github/MISSIONS/.*\.md$ ]]; then
            base_name="$(basename "$file")"
            if [ "$base_name" != "README.md" ] && [ "$base_name" != "_template.md" ]; then
                MISSION_FILES+=("$file")
            fi
        fi
        continue
    fi
    
    # Mission files (for evidence), excluding helper files.
    if [[ "$file" =~ ^agents/ ]] || \
    [[ "$file" =~ ^prompts/ ]] || \
    [[ "$file" =~ ^docs/ ]] || \
    [[ "$file" =~ ^library/ ]] || \
    [[ "$file" =~ ^standards/ ]] || \
    [[ "$file" =~ ^instructions/ ]] || \
    [[ "$file" =~ ^stacks/ ]] || \
    [[ "$file" =~ ^\.github/ ]] || \
    [[ "$file" =~ ^README ]] || \
    [[ "$file" =~ ^registry\.json$ ]] || \
    [[ "$file" =~ ^ROADMAP\.md$ ]] || \
    [[ "$file" =~ ^structure\.md$ ]]; then
        NON_TRIVIAL=true
        TRIGGER_FILES+=("$file")
    fi
    
done

echo "MISSION_PROTOCOL|INFO|range|${RANGE}"
echo "MISSION_PROTOCOL|INFO|changed_files|${#CHANGED_FILES[@]}"
echo "MISSION_PROTOCOL|INFO|non_trivial|${NON_TRIVIAL}"
echo "MISSION_PROTOCOL|INFO|mission_files_changed|${#MISSION_FILES[@]}"

if [ "$NON_TRIVIAL" != "true" ]; then
    echo "MISSION_PROTOCOL|PASS|trivial-pr|no-gate-required"
    exit 0
fi

if [ "${#MISSION_FILES[@]}" -eq 0 ]; then
    echo "MISSION_PROTOCOL|FAIL|missing-mission-file|non-trivial-pr-without-mission"
    printf 'MISSION_PROTOCOL|EVIDENCE|trigger_file|%s\n' "${TRIGGER_FILES[@]}"
    exit 1
fi

INVALID_COUNT=0

resolve_python_cmd() {
    if command -v python3 >/dev/null 2>&1; then
        echo "python3"
        return
    fi
    
    if command -v python >/dev/null 2>&1; then
        echo "python"
        return
    fi
    
    if command -v py >/dev/null 2>&1; then
        echo "py -3"
        return
    fi
    
    echo ""
}

PYTHON_CMD="$(resolve_python_cmd)"

if [ -z "$PYTHON_CMD" ]; then
    echo "MISSION_PROTOCOL|FAIL|python-runtime-not-found|checked=python3,python,py -3"
    exit 1
fi

validate_file() {
    local file_path="$1"
    
    # shellcheck disable=SC2086
    $PYTHON_CMD - "$file_path" <<'PYEOF'
import re
import sys

path = sys.argv[1]
mandatory = [
    "Parent_Agent",
    "Child_Agent",
    "Mission_Objective",
    "Context_Links",
    "Success_Criteria",
    "Result_Payload",
]
list_like = {"Context_Links", "Success_Criteria", "Result_Payload"}

with open(path, encoding="utf-8") as f:
    lines = f.readlines()

seen = set()
valid = {k: False for k in mandatory}
current = None
placeholder = re.compile(r"^<[^>]+>$")
child_agent_pattern = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]*$")

for raw in lines:
    line = raw.rstrip("\n")
    m = re.match(r"^([A-Za-z_]+):\s*(.*)$", line)
    if m:
        key, value = m.group(1), m.group(2)
        if key in valid:
            seen.add(key)
            current = key
            normalized = value.strip()

            if normalized and not normalized.startswith("#") and not placeholder.match(normalized):
                if key == "Child_Agent":
                    # One hop per mission file: reject multi-child separators and require a single token.
                    if child_agent_pattern.match(normalized) and not re.search(r"(?:\band\b|[,&;/])", normalized):
                        valid[key] = True
                else:
                    valid[key] = True
            continue

        current = None
        continue

    if current and not valid[current]:
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or re.match(r"^#+\s", stripped):
            continue

        if current in list_like:
            # Accept list payload only with meaningful content.
            if stripped.startswith("-"):
                payload = stripped[1:].strip()
                if payload and not placeholder.match(payload):
                    valid[current] = True
            elif not placeholder.match(stripped):
                valid[current] = True

missing = [k for k in mandatory if k not in seen]
empty = [k for k in mandatory if k in seen and not valid[k]]

if missing or empty:
    print(f"MISSION_PROTOCOL|FAIL|invalid-mission-fields|file={path}")
    for item in missing:
        print(f"MISSION_PROTOCOL|DETAIL|missing_field|{item}|file={path}")
    for item in empty:
        print(f"MISSION_PROTOCOL|DETAIL|empty_field|{item}|file={path}")
    sys.exit(1)

print(f"MISSION_PROTOCOL|PASS|valid-mission-file|file={path}")
PYEOF
}

for mission_file in "${MISSION_FILES[@]}"; do
    if [ ! -f "$mission_file" ]; then
        echo "MISSION_PROTOCOL|FAIL|mission-file-not-found|file=${mission_file}"
        INVALID_COUNT=$((INVALID_COUNT + 1))
        continue
    fi
    
    if ! validate_file "$mission_file"; then
        INVALID_COUNT=$((INVALID_COUNT + 1))
    fi
done

if [ "$INVALID_COUNT" -gt 0 ]; then
    echo "MISSION_PROTOCOL|FAIL|validation-errors|count=${INVALID_COUNT}"
    exit 1
fi

echo "MISSION_PROTOCOL|PASS|gate-satisfied|mission_files=${#MISSION_FILES[@]}"
exit 0
