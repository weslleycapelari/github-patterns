#!/bin/bash

# ==============================================================================
# GitHub Patterns Bootstrap Script (Bash/Linux/Mac)
# ==============================================================================
#
# SYNOPSIS
#   Initializes governance, agents, and standards based on stack + phases
#
# USAGE
#   ./bootstrap.sh --stack laravel --phases A,B,C --visibility public
#   ./bootstrap.sh --stack nodejs --phases A,B,C,D,E --output-path ./my-repo
#
# VERSION
#   1.0.0
#

set -euo pipefail

# ==============================================================================
# CONFIGURATION
# ==============================================================================

STACK=""
PHASES=""
VISIBILITY="public"
REGISTRY_URL="https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/registry.json"
OUTPUT_PATH="."
LOG_FILE="${OUTPUT_PATH}/bootstrap.log"
ENDPOINT_BASE="https://raw.githubusercontent.com/weslleycapelari/github-patterns/main/"
MAX_RETRIES=3
RETRY_DELAY=1

# ==============================================================================
# UTILITY FUNCTIONS
# ==============================================================================

get_bootstrap_version() {
    echo "1.0.0"
}

check_dependencies() {
    local missing=0
    
    if ! command -v curl &> /dev/null; then
        log_error "curl is required but not installed"
        missing=1
    fi
    
    # jq is optional (we have fallback), but warn if missing
    if ! command -v jq &> /dev/null; then
        log_warn "jq not found; using fallback grep/sed for JSON parsing (less reliable)"
    fi
    
    if [ $missing -eq 1 ]; then
        exit 1
    fi
}

validate_phase_sequence() {
    local phases_str=$1
    local phases_array=(${phases_str//,/ })
    local phase_order=("A" "B" "C" "D" "E")
    
    # Convert phases to indices
    local indices=()
    for phase in "${phases_array[@]}"; do
        local found=0
        for i in "${!phase_order[@]}"; do
            if [[ "${phase_order[$i]}" == "$phase" ]]; then
                indices+=($i)
                found=1
                break
            fi
        done
        if [ $found -eq 0 ]; then
            log_error "Invalid phase: $phase. Must be A, B, C, D, or E."
            return 1
        fi
    done
    
    # Check for gaps in sequence
    if [ ${#indices[@]} -gt 1 ]; then
        for ((i=0; i<${#indices[@]}-1; i++)); do
            if [ $((indices[i+1] - indices[i])) -ne 1 ]; then
                log_error "Phase gap detected. Phases must be sequential (A→B→C→D→E). Requested: $phases_str"
                return 1
            fi
        done
    fi
    
    return 0
}

validate_stack() {
    local stack=$1
    case "$stack" in
        nodejs|python|laravel|vuejs)
            return 0
            ;;
        *)
            log_error "Invalid stack: $stack. Must be nodejs, python, laravel, or vuejs."
            return 1
            ;;
    esac
}

validate_visibility() {
    local visibility=$1
    case "$visibility" in
        public|private)
            return 0
            ;;
        *)
            log_error "Invalid visibility: $visibility. Must be public or private."
            return 1
            ;;
    esac
}

check_write_permission() {
    local path=$1
    if [ ! -d "$path" ]; then
        mkdir -p "$path" 2>/dev/null || {
            log_error "Cannot create output directory: $path"
            return 1
        }
    fi
    
    # Test write permission
    local test_file="${path}/.bootstrap-write-test-$$"
    if ! echo "test" > "$test_file" 2>/dev/null; then
        log_error "No write permission for output path: $path"
        return 1
    fi
    rm -f "$test_file"
    return 0
}

log_msg() {
    local level="${2:-INFO}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local msg="[$timestamp] [$level] $1"
    echo "$msg" | tee -a "$LOG_FILE"
}

log_error() {
    log_msg "$1" "ERROR"
}

log_warn() {
    log_msg "$1" "WARN"
}

download_with_retry() {
    local uri=$1
    local outfile=$2
    local attempt=1
    
    while [ $attempt -le $MAX_RETRIES ]; do
        log_msg "Downloading: $uri (attempt $attempt/$MAX_RETRIES)"
        if [ -z "$outfile" ]; then
            # Return content
            if curl -fsSL "$uri" 2>/dev/null; then
                log_msg "Success: $uri"
                return 0
            fi
        else
            # Save to file
            if curl -fsSL "$uri" -o "$outfile" 2>/dev/null; then
                log_msg "Success: $uri -> $outfile"
                return 0
            fi
        fi
        
        log_warn "Failed attempt $attempt for $uri"
        if [ $attempt -lt $MAX_RETRIES ]; then
            delay=$((RETRY_DELAY * (2 ** (attempt - 1))))
            sleep "$delay"
        fi
        attempt=$((attempt + 1))
    done
    
    log_error "Failed to download $uri after $MAX_RETRIES attempts"
    return 1
}

create_dir_if_not_exists() {
    local path=$1
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
        log_msg "Created directory: $path"
    fi
}

file_exists() {
    [ -f "$1" ]
}

backup_file() {
    local filepath=$1
    if file_exists "$filepath"; then
        local timestamp=$(date '+%Y%m%d-%H%M%S')
        local backup="${filepath}.backup.${timestamp}"
        cp "$filepath" "$backup"
        log_msg "Backed up: $filepath -> $backup"
    fi
}

parse_json() {
    local json=$1
    local key=$2
    # Fallback: use grep/sed if jq is not available
    if command -v jq &> /dev/null; then
        echo "$json" | jq -r "$key"
    else
        # Simple grep/sed fallback for basic extraction
        echo "$json" | grep -o "\"$key\"[^,}]*" | cut -d'"' -f4
    fi
}

# ==============================================================================
# MAIN WORKFLOW
# ==============================================================================

main() {
    log_msg "Starting bootstrap v$(get_bootstrap_version) for stack=$STACK phases=$PHASES visibility=$VISIBILITY"
    
    # Check dependencies
    check_dependencies
    
    # Validate input
    if [ -z "$STACK" ]; then
        log_error "ERROR: --stack parameter required (nodejs|python|laravel|vuejs)"
        exit 1
    fi
    
    if ! validate_stack "$STACK"; then
        exit 1
    fi
    
    if [ -z "$PHASES" ]; then
        log_error "ERROR: --phases parameter required (e.g., A,B,C)"
        exit 1
    fi
    
    if ! validate_phase_sequence "$PHASES"; then
        exit 1
    fi
    
    if ! validate_visibility "$VISIBILITY"; then
        exit 1
    fi
    
    # Validate output path is writable
    if ! check_write_permission "$OUTPUT_PATH"; then
        exit 1
    fi
    
    # Download and parse registry
    log_msg "Fetching registry from $REGISTRY_URL"
    registry_json=$(download_with_retry "$REGISTRY_URL" "" || echo "")
    
    if [ -z "$registry_json" ]; then
        log_error "CRITICAL: Failed to download registry"
        exit 1
    fi
    
    # Validate JSON
    if ! echo "$registry_json" | jq empty 2>/dev/null; then
        log_error "CRITICAL: Invalid JSON in registry"
        exit 1
    fi
    
    registry_version=$(echo "$registry_json" | jq -r '.version')
    log_msg "Registry loaded successfully (version $registry_version)"
    
    # Create directory structure
    log_msg "Creating directory structure..."
    create_dir_if_not_exists "$OUTPUT_PATH/.github"
    create_dir_if_not_exists "$OUTPUT_PATH/.github/agents"
    create_dir_if_not_exists "$OUTPUT_PATH/.github/workflows"
    create_dir_if_not_exists "$OUTPUT_PATH/.github/standards"
    create_dir_if_not_exists "$OUTPUT_PATH/docs"
    create_dir_if_not_exists "$OUTPUT_PATH/docs/standards"
    create_dir_if_not_exists "$OUTPUT_PATH/scripts"
    
    # Collect assets from phases
    local collected_assets=()
    local phases_array=(${PHASES//,/ })
    
    log_msg "Processing phases: ${PHASES}"
    
    # Get phase assets using jq
    for phase in "${phases_array[@]}"; do
        phase_assets=$(echo "$registry_json" | jq -r ".core.github_100_percent.phases.\"$phase\".assets[]?" 2>/dev/null || echo "")
        for asset_id in $phase_assets; do
            if [[ ! " ${collected_assets[@]} " =~ " ${asset_id} " ]]; then
                collected_assets+=("$asset_id")
            fi
        done
    done
    
    # Add stack-specific assets
    stack_assets=$(echo "$registry_json" | jq -r ".stacks.\"$STACK\".recommended_assets[]?" 2>/dev/null || echo "")
    for asset_id in $stack_assets; do
        if [[ ! " ${collected_assets[@]} " =~ " ${asset_id} " ]]; then
            collected_assets+=("$asset_id")
        fi
    done
    
    log_msg "Assets to download: ${collected_assets[*]}"
    
    # Download assets
    local success_count=0
    local failure_count=0
    local failed_assets=()
    
    for asset_id in "${collected_assets[@]}"; do
        # Find asset in registry (try all categories)
        local asset_data=""
        local source_path=""
        local target_path=""
        
        # Try agents
        asset_data=$(echo "$registry_json" | jq ".assets.agents.\"$asset_id\"" 2>/dev/null)
        if [ "$asset_data" != "null" ] && [ -n "$asset_data" ]; then
            source_path=$(echo "$asset_data" | jq -r '.path')
            target_path=$(echo "$asset_data" | jq -r '.target // .path')
        else
            # Try instructions
            asset_data=$(echo "$registry_json" | jq ".assets.instructions.\"$asset_id\"" 2>/dev/null)
            if [ "$asset_data" != "null" ] && [ -n "$asset_data" ]; then
                source_path=$(echo "$asset_data" | jq -r '.path')
                target_path=$(echo "$asset_data" | jq -r '.target // .path')
            else
                # Try workflows
                asset_data=$(echo "$registry_json" | jq ".assets.workflows.\"$asset_id\"" 2>/dev/null)
                if [ "$asset_data" != "null" ] && [ -n "$asset_data" ]; then
                    source_path=$(echo "$asset_data" | jq -r '.path')
                    target_path=$(echo "$asset_data" | jq -r '.target // .path')
                else
                    # Try standards
                    asset_data=$(echo "$registry_json" | jq ".assets.standards.\"$asset_id\"" 2>/dev/null)
                    if [ "$asset_data" != "null" ] && [ -n "$asset_data" ]; then
                        source_path=$(echo "$asset_data" | jq -r '.path')
                        target_path=$(echo "$asset_data" | jq -r '.target // .path')
                    else
                        # Try intelligence
                        asset_data=$(echo "$registry_json" | jq ".assets.intelligence.\"$asset_id\"" 2>/dev/null)
                        if [ "$asset_data" != "null" ] && [ -n "$asset_data" ]; then
                            source_path=$(echo "$asset_data" | jq -r '.path')
                            target_path=$(echo "$asset_data" | jq -r '.target // .path')
                        fi
                    fi
                fi
            fi
        fi
        
        if [ -z "$source_path" ]; then
            log_warn "Asset '$asset_id' not found in registry"
            failure_count=$((failure_count + 1))
            failed_assets+=("$asset_id")
            continue
        fi
        
        source_url="${ENDPOINT_BASE}${source_path}"
        full_target_path="${OUTPUT_PATH}/${target_path}"
        target_dir=$(dirname "$full_target_path")
        
        create_dir_if_not_exists "$target_dir"
        
        if file_exists "$full_target_path"; then
            log_msg "Asset already exists, skipping: $asset_id"
            success_count=$((success_count + 1))
        else
            if download_with_retry "$source_url" "$full_target_path"; then
                log_msg "Downloaded: $asset_id -> $full_target_path"
                success_count=$((success_count + 1))
            else
                log_warn "Failed to download: $asset_id"
                failure_count=$((failure_count + 1))
                failed_assets+=("$asset_id")
            fi
        fi
    done
    
    # Generate llms.txt
    log_msg "Generating llms.txt..."
    llms_path="${OUTPUT_PATH}/llms.txt"
    
    if file_exists "$llms_path"; then
        backup_file "$llms_path"
    fi
    
    {
        echo "# LLM Intelligence Index"
        echo ""
        echo "## Stack & Phase"
        echo "Stack: $STACK | Phases: $PHASES | Visibility: $VISIBILITY"
        echo ""
        echo "## Agents"
        find "$OUTPUT_PATH/.github/agents" -name "*.agent.md" 2>/dev/null | while read -r agent; do
            echo "- $(basename "$agent")"
        done
        echo ""
        echo "## Standards"
        find "$OUTPUT_PATH/docs/standards" -name "*.md" 2>/dev/null | while read -r std; do
            echo "- $(basename "$std")"
        done
        echo ""
        echo "## Workflows"
        find "$OUTPUT_PATH/.github/workflows" -name "*.yml" 2>/dev/null | while read -r wf; do
            echo "- $(basename "$wf")"
        done
    } > "$llms_path"
    
    log_msg "Generated: $llms_path"
    
    # Summary
    local total_assets=$((success_count + failure_count))
    local success_rate=0
    if [ $total_assets -gt 0 ]; then
        success_rate=$((success_count * 100 / total_assets))
    fi
    
    echo ""
    log_msg "========== BOOTSTRAP COMPLETE =========="
    log_msg "Downloaded: $success_count/$total_assets assets ($success_rate%)"
    
    if [ $failure_count -gt 0 ]; then
        log_error "Failed assets: $(IFS=', '; echo "${failed_assets[*]}")"
        critical_threshold=$((${#collected_assets[@]} / 5 + 1))
        if [ $failure_count -gt $critical_threshold ]; then
            log_error "CRITICAL: Too many failures ($failure_count > threshold $critical_threshold)"
            exit 1
        fi
    fi
    
    log_msg "Bootstrap location: $OUTPUT_PATH"
    log_msg "Log file: $LOG_FILE"
    log_msg "=========================================="
    exit 0
}

# ==============================================================================
# ARGUMENT PARSING
# ==============================================================================

while [[ $# -gt 0 ]]; do
    case $1 in
        --stack)
            STACK="$2"
            shift 2
            ;;
        --phases)
            PHASES="$2"
            shift 2
            ;;
        --visibility)
            VISIBILITY="$2"
            shift 2
            ;;
        --registry-url)
            REGISTRY_URL="$2"
            shift 2
            ;;
        --output-path)
            OUTPUT_PATH="$2"
            shift 2
            ;;
        *)
            log_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# ==============================================================================
# ENTRY POINT
# ==============================================================================

main
