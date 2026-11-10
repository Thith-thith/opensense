#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$here/../fixtures/seed-dashboard"
[ -d "$src" ] || { echo "run evals/fixtures/fetch.sh first" >&2; exit 1; }
cp -cR "$src/." . 2>/dev/null || cp -R "$src/." .
rm -rf .git dist
