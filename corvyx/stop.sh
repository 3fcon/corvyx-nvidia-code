#!/bin/sh
CNC_HOME=${CNC_HOME:-$HOME/.corvyx-nvidia}
PID="$CNC_HOME/server.pid"
if [ -f "$PID" ] && kill "$(cat "$PID")" 2>/dev/null; then
    i=0; while kill -0 "$(cat "$PID")" 2>/dev/null && [ $i -lt 10 ]; do i=$((i + 1)); sleep 1; done
    echo "stopped"
else
    echo "not running"
fi
rm -f "$PID"
