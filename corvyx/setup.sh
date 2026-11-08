#!/bin/sh
# Corvyx NVIDIA Code: one-time setup. Installs the proxy inside this folder only (no global tools, no other agents),
# and writes its settings to ~/.corvyx-nvidia (key file is readable by you only).
set -eu
ROOT=$(cd "$(dirname "$0")/.." && pwd)
CNC_HOME=${CNC_HOME:-$HOME/.corvyx-nvidia}
command -v python3 >/dev/null || { echo "error: python3 is needed" >&2; exit 1; }
cd "$ROOT"
[ -x .uvenv/bin/uv ] || { python3 -m venv .uvenv && .uvenv/bin/pip -q install uv; }
UV_PYTHON_INSTALL_DIR="$ROOT/.uvpy" .uvenv/bin/uv sync -q
mkdir -p "$CNC_HOME/home/.fcc" "$CNC_HOME/claude"
ENV="$CNC_HOME/home/.fcc/.env"
if [ ! -f "$ENV" ]; then
    KEY=${NVIDIA_API_KEY:-}
    if [ -z "$KEY" ]; then
        printf 'NVIDIA API key (from build.nvidia.com/settings/api-keys, input hidden): '
        stty -echo 2>/dev/null || true; read -r KEY; stty echo 2>/dev/null || true; echo
    fi
    [ -n "$KEY" ] || { echo "error: no key given" >&2; exit 1; }
    TOKEN=$(python3 -c 'import secrets; print(secrets.token_hex(16))')
    (umask 077; printf 'HOST=127.0.0.1\nPORT=%s\nANTHROPIC_AUTH_TOKEN=%s\nMODEL=%s\nNVIDIA_NIM_API_KEY=%s\n' \
        "${CNC_PORT:-8082}" "$TOKEN" "${CNC_MODEL:-nvidia_nim/nvidia/nemotron-3-ultra-550b-a55b}" "$KEY" > "$ENV")
fi
echo "Ready. Start: corvyx/start.sh   Use: corvyx/claude.sh   Stop: corvyx/stop.sh"
