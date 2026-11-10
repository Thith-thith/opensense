#!/usr/bin/env bash
# Usage: shoot.sh <url> <outdir> <light|dark>
# Writes phone.png, desktop.png and lighthouse.json (accessibility) into <outdir>.
set -euo pipefail
[ $# -eq 3 ] || { echo "usage: shoot.sh <url> <outdir> <light|dark>" >&2; exit 2; }
url=$1; out=$2; scheme=$3
case "$scheme" in light|dark) ;; *) echo "scheme must be light or dark, got: $scheme" >&2; exit 2;; esac
mkdir -p "$out"
for v in "phone:390, 844" "desktop:1440, 900"; do
  npx -y playwright@1.65.0 screenshot --channel chrome --full-page \
    --viewport-size "${v#*:}" --color-scheme "$scheme" --wait-for-timeout 1500 \
    "$url" "$out/${v%%:*}.png"
done
npx -y lighthouse@13.6.0 "$url" --only-categories=accessibility --output=json \
  --output-path="$out/lighthouse.json" --quiet --chrome-flags="--headless=new"
