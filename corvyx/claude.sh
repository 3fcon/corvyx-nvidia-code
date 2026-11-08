#!/bin/sh
# Runs Claude Code through the proxy with its own config folder, so your normal Claude Code login and settings stay untouched.
set -eu
CNC_HOME=${CNC_HOME:-$HOME/.corvyx-nvidia}
ENV="$CNC_HOME/home/.fcc/.env"
command -v claude >/dev/null || { echo "error: install Claude Code first (https://claude.ai/install.sh)" >&2; exit 1; }
PORT=$(sed -n 's/^PORT=//p' "$ENV"); TOKEN=$(sed -n 's/^ANTHROPIC_AUTH_TOKEN=//p' "$ENV")
unset ANTHROPIC_API_KEY
CLAUDE_CONFIG_DIR="$CNC_HOME/claude" ANTHROPIC_BASE_URL="http://127.0.0.1:$PORT" ANTHROPIC_AUTH_TOKEN="$TOKEN" exec claude "$@"
