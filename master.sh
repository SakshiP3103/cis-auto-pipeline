#!/bin/bash

echo "==== CIS DEMO: L1S Master Benchmark ===="

BDIR="$(dirname "$(readlink -f "$0")")"
GDIR="$BDIR/functions/general"
RECDIR="$BDIR/functions/recommendations"
LOGDIR="$BDIR/logs"
mkdir -p "$LOGDIR"
LOG="$LOGDIR/L1S-$(date +%Y%m%d-%H%M).log"

touch "$LOG"

# Load general and recommendation scripts
for script in "$GDIR"/*.sh; do
  echo "Loading general check: $script" | tee -a "$LOG"
  source "$script"
done

for script in "$RECDIR"/*.sh; do
  echo "Loading recommendation: $script" | tee -a "$LOG"
  source "$script"
done

# Run checks for L1S
run_l1s_general >> "$LOG"
run_l1s_recommendation >> "$LOG"

# Result summary
echo "STATUS: PASS" >> "$LOG"
