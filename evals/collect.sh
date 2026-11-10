#!/usr/bin/env bash
# Usage: collect.sh <result.json> <dest-dir> <arm> <label>
# Copies each kept run's workspace and trace into <dest>/<case>/<label>/, appends
# "case,label,costUsd,turns" to <dest>/costs.csv, then deletes the kept root.
# Layout assumes one run per case and arm; everything is validated before anything is copied or deleted.
set -euo pipefail
[ $# -eq 4 ] || { echo "usage: collect.sh <result.json> <dest-dir> <arm> <label>" >&2; exit 2; }
json=$1; dest=$2; arm=$3; label=$4
[ -f "$json" ] || { echo "no such result file: $json" >&2; exit 2; }

runs=$(python3 -I -c '
import json, sys
d = json.load(open(sys.argv[1])); arm = sys.argv[2]; seen = set()
for c in d.get("cases", []):
    rs = (c.get("arms") or {}).get(arm) or []
    if len(rs) > 1:
        sys.exit("refusing: case %s arm %s has %d runs; collect.sh supports one run per case and arm" % (c["name"], arm, len(rs)))
    if rs and c["name"] in seen:
        sys.exit("refusing: case %s appears twice in the result" % c["name"])
    for r in rs:
        seen.add(c["name"])
        print("|".join([c["name"], r.get("tracePath") or "", str(r.get("costUsd", "")), str(r.get("turns", ""))]))
' "$json" "$arm")

# Validation pass: refuse the whole batch before touching anything.
while IFS="|" read -r name trace cost turns; do
  [ -n "$name" ] || continue
  case "$name" in */*|.*) echo "refusing odd case name: $name" >&2; exit 1;; esac
  [ -n "$trace" ] || continue
  root=$(dirname "$(dirname "$trace")")
  [[ $root =~ ^(/private)?/tmp/e-[^/]+$ ]] || { echo "refusing root that is not a direct /private/tmp/e-* or /tmp/e-* folder: $root" >&2; exit 1; }
  [ "$trace" = "$root/out/trace.jsonl" ] || { echo "refusing tracePath not ending in /out/trace.jsonl: $trace" >&2; exit 1; }
  [ ! -L "$root" ] || { echo "refusing symlinked root: $root" >&2; exit 1; }
  [ ! -e "$dest/$name/$label" ] || { echo "refusing: destination already exists: $dest/$name/$label" >&2; exit 1; }
done <<< "$runs"

mkdir -p "$dest"
while IFS="|" read -r name trace cost turns; do
  [ -n "$name" ] || continue
  if [ -z "$trace" ]; then echo "skip $name: run has no tracePath (errored before launch)" >&2; continue; fi
  root=$(dirname "$(dirname "$trace")")
  [ -d "$root" ] || { echo "skip $name: kept root is gone: $root" >&2; continue; }
  chmod 700 "$root" "$root/sealed"
  out="$dest/$name/$label"
  mkdir -p "$out/workspace"
  rsync -a --exclude node_modules --exclude .claude "$root/sealed/home/cwd/" "$out/workspace/"
  cp "$root/out/trace.jsonl" "$out/trace.jsonl"
  echo "$name,$label,$cost,$turns" >> "$dest/costs.csv"
  chmod -R u+rwx "$root"
  rm -rf "$root"
  echo "collected $name/$label"
done <<< "$runs"
