#!/bin/sh
# Starts the proxy on 127.0.0.1 only (never on the network).
set -eu
ROOT=$(cd "$(dirname "$0")/.." && pwd)
CNC_HOME=${CNC_HOME:-$HOME/.corvyx-nvidia}
[ -f "$CNC_HOME/home/.fcc/.env" ] || { echo "error: run corvyx/setup.sh first" >&2; exit 1; }
PID="$CNC_HOME/server.pid"
if [ -f "$PID" ] && kill -0 "$(cat "$PID")" 2>/dev/null; then echo "already running"; exit 0; fi
HOME="$CNC_HOME/home" nohup "$ROOT/.venv/bin/fcc-server" > "$CNC_HOME/server.log" 2>&1 &
echo $! > "$PID"
PORT=$(sed -n 's/^PORT=//p' "$CNC_HOME/home/.fcc/.env")
i=0; until python3 -c "import socket; socket.create_connection(('127.0.0.1', $PORT), 1)" 2>/dev/null; do
    i=$((i + 1)); [ $i -lt 30 ] || { echo "error: proxy did not start, see $CNC_HOME/server.log" >&2; exit 1; }; sleep 1
done
echo "proxy running on 127.0.0.1:$PORT"
