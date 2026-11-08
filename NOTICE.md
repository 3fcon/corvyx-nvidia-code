# Notice

Corvyx NVIDIA Code is a modified version of **Free Claude Code** by Ali Khokhar
(https://github.com/Alishahryar1/free-claude-code), commit `4cfc35e` (2026-11-08), licensed under the
GNU Affero General Public License v3.0 (see `LICENSE`).

Changes by Corvyx (2026-11-08):
- Added `corvyx/` scripts: local-only setup, start, stop, and a Claude Code launcher with its own config folder.
- The proxy is bound to `127.0.0.1` by default, and a random access token replaces the shared default token.
- `pyproject.toml`: version falls back to 6.19.3 (the upstream release) when no git tag is present.
- Removed the upstream `.github` folder (CI, release and issue workflows that point to the upstream project).
- Added this notice and the Corvyx section at the top of `README.md`.

The upstream code under `src/`, `tests/`, `scripts/`, `smoke/`, `e2e/` and `assets/` is unchanged.
