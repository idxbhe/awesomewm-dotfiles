#!/bin/bash
# Test AwesomeWM config with Xephyr - exits immediately on error or success

set -euo pipefail

CONFIG_DIR="/home/bhe/dotfiles/config/awesome"
XEPHYR_DISPLAY=":1"
XEPHYR_RES="1280x720"

# Cleanup function
cleanup() {
    pkill -f "Xephyr.*$XEPHYR_DISPLAY" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

# Start Xephyr
Xephyr -ac -br -noreset -screen "$XEPHYR_RES" "$XEPHYR_DISPLAY" &
XEPHYR_PID=$!

# Wait for Xephyr to be ready
sleep 1

# Run awesome with config, capture stderr
OUTPUT_FILE=$(mktemp)
DISPLAY="$XEPHYR_DISPLAY" awesome -c "$CONFIG_DIR/rc.lua" 2>"$OUTPUT_FILE" &
AWESOME_PID=$!

# Wait a bit for awesome to start and potentially error
sleep 2

# Check if awesome is still running
if kill -0 "$AWESOME_PID" 2>/dev/null; then
    # Awesome started successfully, kill it and report success
    kill "$AWESOME_PID" 2>/dev/null
    wait "$AWESOME_PID" 2>/dev/null || true
    echo "no error"
    exit 0
else
    # Awesome exited, check for errors
    wait "$AWESOME_PID" 2>/dev/null || true
    if [[ -s "$OUTPUT_FILE" ]]; then
        cat "$OUTPUT_FILE"
        rm -f "$OUTPUT_FILE"
        exit 1
    else
        echo "no error"
        exit 0
    fi
fi