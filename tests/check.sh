#!/usr/bin/env bash
# Structure check for the OpenSense skill. Runs from any directory.
# Prints "OK <n>" or "FAIL <n>: <reason>" per check; exits 0 only if all pass.
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SK="$REPO/skills/opensense"
SKILL="$SK/SKILL.md"
REFS="$SK/references"
REF_FILES="ux.md typography-and-words.md visual-and-interaction.md platforms-and-accessibility.md culture-and-language.md review.md"
export REPO SKILL
status=0

# Each c_N prints a reason on failure and returns non-zero.
run() {
  local n="$1" out
  out="$("c_$n" 2>&1)" && { echo "OK $n"; return; }
  echo "FAIL $n: $(printf '%s' "$out" | tr '\n' ' ')"
  status=1
}

c_1() {
  [ -f "$SKILL" ] || { echo "skills/opensense/SKILL.md missing"; return 1; }
  local extra
  extra="$(ls -A "$SK" | grep -vx -e SKILL.md -e references)"
  [ -z "$extra" ] || { echo "unexpected in skills/opensense: $extra"; return 1; }
}

c_2() {
  [ -f "$SKILL" ] || { echo "SKILL.md missing"; return 1; }
  python3 - <<'PY'
import os, re, sys
L = open(os.environ["SKILL"], encoding="utf-8").read().split("\n")
def bad(m): print(m); sys.exit(1)
if len(L) < 7 or L[0] != "---": bad("frontmatter must open with ---")
if L[1] != "name: opensense": bad("line 2 must be 'name: opensense'")
if not L[2].startswith("description: "): bad("line 3 must be 'description: ...'")
d = L[2][len("description: "):]
if not 1 <= len(d) <= 1024: bad("description length %d not in 1-1024" % len(d))
if d[0] in "\"'": bad("description must not be quoted")
if ": " in d: bad("description contains ': '")
if " #" in d: bad("description contains ' #'")
if L[3] != "license: MIT": bad("line 4 must be 'license: MIT'")
if L[4] != "metadata:": bad("line 5 must be 'metadata:'")
if not re.fullmatch(r'  version: "\d+\.\d+\.\d+"', L[5]): bad('line 6 must be \'  version: "x.y.z"\'')
if L[6] != "---": bad("frontmatter must close with --- on line 7")
PY
}

c_3() {
  [ -f "$SKILL" ] || { echo "SKILL.md missing"; return 1; }
  python3 - <<'PY'
import os, sys
L = open(os.environ["SKILL"], encoding="utf-8").read().split("\n")
if L and L[-1] == "": L.pop()
def bad(m): print(m); sys.exit(1)
if len(L) > 300: bad("%d lines, max 300" % len(L))
want = ["Stance","Authority order","Size the task","Discover","Direction","Build",
        "Review before done","Common generated-UI tells","References"]
h = [(i, l[3:]) for i, l in enumerate(L) if l.startswith("## ")]
pos = 0; idx = {}
for w in want:
    while pos < len(h) and not h[pos][1].startswith(w): pos += 1
    if pos == len(h): bad("H2 '%s' missing or out of order" % w)
    idx[w] = h[pos][0]; pos += 1
end = next((i for i, _ in h if i > idx["Stance"]), len(L))
if end - idx["Stance"] - 1 > 15: bad("Stance section %d lines, max 15" % (end - idx["Stance"] - 1))
PY
}

c_4() {
  [ -f "$SKILL" ] || { echo "SKILL.md missing"; return 1; }
  python3 - <<'PY'
import os, re, sys
t = open(os.environ["SKILL"], encoding="utf-8").read()
miss = []
pos = -1
for s in ["The user's explicit instructions for the current task.",
          "The project's existing design system, brand and conventions.",
          "Platform conventions for web, iOS, Android and desktop operating systems.",
          "OpenSense defaults."]:
    p = t.find(s, pos + 1)
    if p < 0: miss.append("authority/order: " + s)
    else: pos = p
for s in ["What does this tell the user that nothing else does?",
          "Would I write this same direction for any product in this category?"]:
    if s not in t: miss.append(s)
for w in ["errors","prices","fees","consent","destructive","state","accessible names"]:
    if not re.search(r"(?<![\w-])" + re.escape(w) + r"(?![\w-])", t): miss.append("never-cut word: " + w)
for f in "ux typography-and-words visual-and-interaction platforms-and-accessibility culture-and-language review".split():
    if "references/%s.md" % f not in t: miss.append("path references/%s.md" % f)
if miss: print("missing: " + "; ".join(miss)); sys.exit(1)
PY
}

c_5() {
  [ -d "$REFS" ] || { echo "references/ missing"; return 1; }
  local r=0 f g n actual
  actual="$(ls -A "$REFS" | sort | tr '\n' ' ')"
  [ "$actual" = "$(printf '%s\n' $REF_FILES | sort | tr '\n' ' ')" ] || { echo "references/ must hold exactly the six files, has: $actual"; r=1; }
  for f in $REF_FILES; do
    [ -f "$REFS/$f" ] || continue
    n="$(wc -l < "$REFS/$f")"
    [ "$n" -le 300 ] || { echo "$f: $n lines, max 300"; r=1; }
    [ "$(sed -n 1p "$REFS/$f" | cut -c1-2)" = "# " ] || { echo "$f: line 1 must be '# <Title>'"; r=1; }
    [ -z "$(sed -n 2p "$REFS/$f")" ] || { echo "$f: line 2 must be blank"; r=1; }
    case "$(sed -n 3p "$REFS/$f")" in "Read this when"*) ;; *) echo "$f: line 3 must start 'Read this when'"; r=1;; esac
    for g in $REF_FILES; do
      [ "$g" = "$f" ] && continue
      grep -qF "$g" "$REFS/$f" && { echo "$f names $g"; r=1; }
    done
  done
  return $r
}

c_6() {
  [ -d "$SK" ] || { echo "skills/opensense missing"; return 1; }
  local hits
  hits="$(grep -rnwE -e 'Claude|Codex|Gemini|GPT|OpenAI|Anthropic|Cursor|Copilot|Antigravity|Playwright|Puppeteer|MCP|impeccable|frontend-design|TodoWrite|WebFetch' \
    -e 'Read tool|Edit tool|Write tool' "$SK")"
  [ -z "$hits" ] || { echo "forbidden words: $hits"; return 1; }
}

c_7() {
  local p="$REFS/platforms-and-accessibility.md" c="$REFS/culture-and-language.md" s r=0
  [ -f "$p" ] && [ -f "$c" ] || { echo "platforms-and-accessibility.md or culture-and-language.md missing"; return 1; }
  for s in '44 pt' '48 dp' '24×24' 'WCAG 2.2'; do grep -qF -- "$s" "$p" || { echo "platforms-and-accessibility.md lacks '$s'"; r=1; }; done
  for s in 'Arabic' 'Khmer' 'dir="rtl"' 'lang="km"'; do grep -qF -- "$s" "$c" || { echo "culture-and-language.md lacks '$s'"; r=1; }; done
  return $r
}

c_8() {
  python3 - <<'PY'
import json, os, re, sys
repo = os.environ["REPO"]; errs = []
def load(p):
    try: return json.load(open(os.path.join(repo, p), encoding="utf-8"))
    except Exception as e: errs.append("%s: %s" % (p, e)); return None
pl = load(".claude-plugin/plugin.json"); mk = load(".claude-plugin/marketplace.json"); ge = load("gemini-extension.json")
if errs or not (pl and mk and ge): print("; ".join(errs)); sys.exit(1)
URL = "https://github.com/Thith-thith/opensense"
def noemail(o, where):
    if isinstance(o, dict):
        for k, v in o.items():
            if k == "email": errs.append("email key in " + where)
            noemail(v, where)
    elif isinstance(o, list):
        for v in o: noemail(v, where)
for n, o in (("plugin.json", pl), ("marketplace.json", mk), ("gemini-extension.json", ge)): noemail(o, n)
try: p0 = mk["plugins"][0]
except Exception: errs.append("marketplace.plugins[0] missing"); p0 = {}
for n, v in (("plugin.json", pl.get("name")), ("marketplace.json", mk.get("name")),
             ("marketplace plugins[0]", p0.get("name")), ("gemini-extension.json", ge.get("name"))):
    if v != "opensense": errs.append("%s name is %r, want 'opensense'" % (n, v))
if p0.get("source") != "./": errs.append("marketplace plugins[0].source must be './'")
if pl.get("repository") != URL: errs.append("plugin.json repository must be " + URL)
if pl.get("homepage") != URL: errs.append("plugin.json homepage must be " + URL)
vs = {"plugin.json": pl.get("version"), "marketplace plugins[0]": p0.get("version"), "gemini-extension.json": ge.get("version")}
skill = os.environ["SKILL"]
if os.path.isfile(skill):
    m = re.search(r'^  version: "([^"]*)"$', open(skill, encoding="utf-8").read(), re.M)
    vs["SKILL.md"] = m.group(1) if m else None
if None in vs.values() or len(set(vs.values())) != 1: errs.append("versions disagree or missing: %s" % vs)
if errs: print("; ".join(errs)); sys.exit(1)
PY
}

c_9() {
  local hits
  hits="$(find "$REPO/evals/fixtures" \( -name case.yaml -o -name prompt.md \) 2>/dev/null)"
  [ -z "$hits" ] || { echo "found: $hits"; return 1; }
}

c_10() {
  command -v uvx >/dev/null || { echo "uvx not installed"; return 1; }
  local out
  out="$(uvx --from "git+https://github.com/agentskills/agentskills#subdirectory=skills-ref" skills-ref validate "$SK" 2>&1)" \
    || { echo "$out"; return 1; }
}

for n in 1 2 3 4 5 6 7 8 9 10; do run "$n"; done
exit $status
