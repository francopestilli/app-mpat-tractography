#!/bin/bash
# Local CLI launcher -- run the MPAT app without brainlife.io orchestration.
# Writes config.json from named flags, then calls ./main.
SCRIPT=$(realpath -s "$0"); SCRIPT_DIR=$(dirname "$SCRIPT")

usage() {
    echo "Usage: $(basename $0) --dwi <dwi.nii.gz> --bvecs <dwi.bvecs> --bvals <dwi.bvals> --t1 <T1w.nii.gz> [--n_proc N] [--max_mem GB] [--bundles NAMES]"
    exit 1
}

dwi=""; bvecs=""; bvals=""; t1=""; n_proc=4; max_mem=16; bundles=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dwi)      dwi=$(realpath "$2");   shift 2 ;;
        --bvecs)    bvecs=$(realpath "$2"); shift 2 ;;
        --bvals)    bvals=$(realpath "$2"); shift 2 ;;
        --t1)       t1=$(realpath "$2");    shift 2 ;;
        --n_proc)   n_proc="$2";            shift 2 ;;
        --max_mem)  max_mem="$2";           shift 2 ;;
        --bundles)  bundles="$2";           shift 2 ;;
        -h|--help) usage ;;
        *) echo "Unknown argument: $1"; usage ;;
    esac
done

errors=0
[ -z "$dwi" ]   && { echo "Error: --dwi required" >&2;   errors=1; } || [ ! -f "$dwi" ]   && { echo "Error: not found: $dwi" >&2;   errors=1; }
[ -z "$bvecs" ] && { echo "Error: --bvecs required" >&2; errors=1; } || [ ! -f "$bvecs" ] && { echo "Error: not found: $bvecs" >&2; errors=1; }
[ -z "$bvals" ] && { echo "Error: --bvals required" >&2; errors=1; } || [ ! -f "$bvals" ] && { echo "Error: not found: $bvals" >&2; errors=1; }
[ -z "$t1" ]    && { echo "Error: --t1 required" >&2;    errors=1; } || [ ! -f "$t1" ]    && { echo "Error: not found: $t1" >&2;    errors=1; }
[ $errors -ne 0 ] && exit 1

cat > config.json <<EOF
{
  "dwi":     $(jq -n --arg v "$dwi"     '$v'),
  "bvecs":   $(jq -n --arg v "$bvecs"   '$v'),
  "bvals":   $(jq -n --arg v "$bvals"   '$v'),
  "t1":      $(jq -n --arg v "$t1"      '$v'),
  "n_proc":  $n_proc,
  "max_mem": $max_mem,
  "bundles": $(jq -n --arg v "$bundles" '$v')
}
EOF

echo "config.json written:"; cat config.json; echo ""
bash "${SCRIPT_DIR}/main"
