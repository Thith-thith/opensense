# OpenSense v0.1.0 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build, measure and release OpenSense v0.1.0. It is a cross-agent Agent Skill that gives coding agents a designer's judgment, and blind human judging must show it beats the same agent without it.

**Architecture:**
- **The skill.** One markdown-only folder, `skills/opensense/`, holding SKILL.md and six reference files.
- **Packaging.** Thin manifests cover Claude Code (plugin + marketplace) and Gemini CLI (extension). Every other agent installs through `npx skills add`.
- **Evaluation.** Runs use Claude Code's built-in `claude plugin eval`, which gives each run isolated config and home folders and keeps its workspace. Playwright takes the screenshots and Lighthouse gives the accessibility numbers. Humans judge blind.
- **Structure check.** `tests/check.sh` guards the skill's shape.

**Tech Stack:**
- Markdown with YAML frontmatter; JSON manifests.
- bash plus python3 (standard library only).
- Claude Code 2.1.322 (`claude plugin eval`, `claude plugin validate`).
- skills CLI (`npx skills`); skills-ref (via `uvx`).
- Playwright 1.65.0 CLI driving the installed Google Chrome; Lighthouse 13.6.0.
- pnpm 10.24.0 for the fixture app; create-expo-app 5.0.0 for the native task.

**Spec:** `docs/design.md`, which builds on `docs/brief.md`. Read both before any task. The plan argues from the design. Where they disagree, the design wins, except for the changes listed below.

> **Execution note (2026-11-10).** After Task 4 the owner chose a lean finish:
> - the skill was written directly from the design and two baseline runs, without per-task subagent review;
> - one test round compares 8 cases with and without OpenSense, plus the trigger tests;
> - v0.1.0 ships labeled "preview".
>
> Tasks 5–14 below remain the path to a 1.0: a full baseline study, two judged rounds and independent judges.

`$REPO` means the absolute path of the repository root. Use absolute paths, because shell working directories can drift between commands.

## Changes from the design (made during planning, 2026-11-10; already patched into design.md)

1. **Runner:** evals run on `claude plugin eval` instead of a fully manual procedure (§3, §9.5).
   - Probes confirmed that runs see none of the owner's hooks or skills.
   - A `scaffold_script` can stage a fixture.
   - The workspace of each run is kept on disk.
2. **Layout:** each case gets its own folder in `evals/`, replacing `prompts.md`. This adds `tests/check.sh`, `evals/fixtures/fetch.sh`, `evals/collect.sh`, `evals/shoot.sh`, and a gitignored `.cache/` at the repo root (§7).
3. **Fixture app:** `satnaing/shadcn-admin` (MIT) at `e16c87f213a5ba5e45964e9b67c792105ec74d26` (§9.3).
4. **Native task:** React Native with Expo, viewed through Expo's web export, because it needs no Xcode, Flutter or Android SDK (§9.2).
5. **Description:** the draft no longer contains `: ` (§8.2).
6. **Cost:** round 0's baseline outputs are the without-OpenSense side in rounds 1 and 2, so later rounds run only the with-OpenSense arm (§9.5).

## Owner gates: stop and ask, and never continue past one without an answer

| Gate | Before | Question |
|---|---|---|
| G0 | Task 1 | Settled 2026-11-10: machine-specific mentions were scrubbed from `docs/` before the first commit. |
| G1 | Task 3 | Are Arabic and Khmer readers available? If not, which right-to-left language and which non-Latin script should replace them? |
| G2 | Task 4 | Which model to pin as `$MODEL`, plus approval of the measured cost and a total ceiling `$BUDGET_USD`. |
| G3 | Tasks 10 and 12 | Who are the judges, including at least one independent judge? Without one, the release is labeled "preview". |
| G4 | Task 9 | Codex and Gemini CLI: owner-installed, or OK for us to install them while the owner signs in. |
| G5 | Task 14 | OK to push to the public repo? |

Record every answer in `evals/README.md` under "Owner decisions".

### Owner decisions so far (2026-11-10)

- **Execution:** subagent-driven.
- **G0:** scrubbed before the first commit.
- **G1:** Arabic and Khmer (the owner chose Khmer). Readers are still to be found. If none turn up before judging, swap the language at that point and re-run the t05/t08 baselines, which costs two extra runs.
- **G2:** `$MODEL` is `claude-sonnet-5-5`. The budget waits for Task 4's measured runs.
- **G3–G5:** open.

## Global Constraints

**The skill and its references**
- **Frontmatter of `skills/opensense/SKILL.md`, block style only** (skills-ref parses with strictyaml):
  ```yaml
  ---
  name: opensense
  description: <one line>
  license: MIT
  metadata:
    version: "0.1.0"
  ---
  ```
- **`description` rules:**
  - one line, 1–1024 characters;
  - no `: ` and no ` #`, and not quoted;
  - starts from the draft in design §8.2.
- **SKILL.md shape:**
  - at most 300 lines;
  - H2 headings in this order, matched by prefix: `Stance`, `Authority order`, `Size the task`, `Discover`, `Direction`, `Build`, `Review before done`, `Common generated-UI tells`, `References`;
  - the Stance section is at most 15 lines.
- **Exact text** that must appear in SKILL.md:
  - Authority order, in this order:
    1. `The user's explicit instructions for the current task.`
    2. `The project's existing design system, brand and conventions.`
    3. `Platform conventions for web, iOS, Android and desktop operating systems.`
    4. `OpenSense defaults.`
  - Clutter test: `What does this tell the user that nothing else does?`
  - Direction self-check: `Would I write this same direction for any product in this category?`
  - Never-cut items, each word present: `errors`, `prices`, `fees`, `consent`, `destructive`, `state`, `accessible names`.
- **Reference files:** exactly six in `skills/opensense/references/`: `ux.md`, `typography-and-words.md`, `visual-and-interaction.md`, `platforms-and-accessibility.md`, `culture-and-language.md`, `review.md`.
- **Reference-file contract:**
  - The file starts with `# <Title>`, a blank line, then one line beginning `Read this when`.
  - At most 300 lines.
  - Rules use the shape `**Default:** … **Why:** … **Deviate when:** …`.
  - Each H2 section has at least one `Before:` / `After:` example.
  - Wherever the topic differs on native platforms, the file includes an iOS or Android note.
  - It never links to or names another reference file. SKILL.md alone routes between them.
- **Agent-neutral.** No file under `skills/opensense/` may contain these words (case-sensitive, whole words): `Claude Codex Gemini GPT OpenAI Anthropic Cursor Copilot Antigravity Playwright Puppeteer MCP impeccable frontend-design TodoWrite WebFetch`, nor the phrases `Read tool`, `Edit tool`, `Write tool`. If a legitimate sentence trips the check (for example "Cursor" at the start of a sentence about pointers), rephrase it ("The pointer…"). Never weaken the check.
- **Pinned numbers:**
  - touch targets of 44 pt on iOS and 48 dp on Android;
  - a 24×24 CSS px minimum on web (WCAG 2.2, 2.5.8);
  - contrast to WCAG 2.2 AA: 4.5:1 for body text, 3:1 for large text and UI components;
  - text usable at 200% zoom.
- **Example languages:** Arabic for right-to-left and Khmer for a non-Latin script, unless G1 swaps them.
- **Original guidance only.** Cite WCAG 2.2, Apple's Human Interface Guidelines, Material Design 3 and Unicode CLDR by name. Copy no text from them or from any other skill.

**Manifests and git**
- **Manifests:**
  - `name` is `opensense` everywhere, and every `version` equals SKILL.md's `metadata.version`.
  - In the marketplace, `plugins[0].source` is `"./"`.
  - No `email` keys.
  - The repo is `https://github.com/Thith-thith/opensense`.
- **Commits.** Commit at the end of every task. Each commit message ends with a blank line and then `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`. Never push before G5.

**Eval runner (learned from probes on 2026-11-10)**
- **Base flags.** Every paid `claude plugin eval` call passes `--no-publish --trust-plugin --model "$MODEL" --keep-temp --max-cost-usd <remaining budget>`. Heavy runs (judged, seed and focus cases) also pass `--scaffold --allow-tools Write Edit Bash`. Without that grant the agent cannot create files and the run is wasted, as the first probe showed. The free lint in Task 3 needs only `--no-publish --trust-plugin --max-cost-usd 0`. Without `--no-publish`, a report that includes the prompts is published to claude.ai.
- **Write access.** Writing needs both the tools listed in the case's `execution.allowed_tools` and `--allow-tools Write Edit Bash` on the command line. Cases with a scaffold also need `--scaffold`.
- **Case files.** Each case is `evals/<id>/case.yaml`, with these fields only:
  - `schema_version: "1.1"`, `name`, `tags`;
  - `context.scaffold_script`;
  - `execution.{prompt, max_turns, timeout_seconds, allowed_tools}`;
  - `runs`, `graders`.

  `execution` silently ignores unknown keys, so copy those names exactly.
- **Graders** are strict objects:
  - `llm`: `{type, name, criteria, focus}`;
  - `tool_used`: `{type, name, tool, input_match, min, max}`;
  - `regex`: `{type, name, pattern, match, target}`.
- **Scaffolds.** `scaffold_script` is a path relative to the case folder. The script runs inside the workspace with `HOME` replaced, so it finds repo files only through `$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)`, never through `$HOME`.
- **Kept runs:**
  - The kept root is `dirname(dirname(tracePath))` from the result JSON, and the workspace is `<root>/sealed/home/cwd`.
  - Copy only that workspace, without `node_modules`. Never run git inside a kept folder.
  - Delete kept folders after copying, because they hold copied home config.
- **Paths.** Raw runs go to `evals/runs/` (gitignored). Curated results go to `evals/results/`. The fixture cache lives in `.cache/`, which is gitignored and outside `evals/`.
- **Release bar.** Human blind judging decides the release. Grader scores are supporting evidence only (brief §9).

## Review Focus

1. **Cutting clutter must not remove information people need:** prices, fees, errors, consent, destructive-action warnings or state. The `keeps-critical-info` grader on t02, t03 and t06 (Task 3) tests this.
2. **Cutting labels must not leave icon-only controls without accessible names.** In every web run, the OpenSense side may add no `button-name` or `link-name` Lighthouse failures that the baseline lacks (Tasks 10 and 12).
3. **An explicit user request for a discouraged pattern gets done** (authority order), with at most one short note. Case `r01-explicit-request` tests this (Tasks 3, 10 and 12).
4. **In an app with light and dark themes, changed UI uses theme tokens and looks right in both.** The `uses-system` grader on t01–t05 and the dark screenshots in the viewing procedure (Task 2) test this.
5. **An agent that can't see its result says so and never claims to have looked.** The `honest-report` grader on all ten judged cases (Task 3) tests this.

---

### Task 1: Repository, manifests and structure check

**Files:**
- Create: `.gitignore`, `LICENSE`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `gemini-extension.json`, `tests/check.sh`
- Commit existing: `docs/brief.md`, `docs/design.md`, `docs/plan.md`

**Interfaces:**
- Produces: `bash $REPO/tests/check.sh`. It runs from any directory, prints `OK <check>` or `FAIL <check>: <reason>` per check, and exits 0 only if all pass. Later tasks use it as their test.

- [ ] **Step 1: Initialize git.** Run `git -C $REPO init -b main && git -C $REPO remote add origin https://github.com/Thith-thith/opensense.git`. Expected: `git -C $REPO remote -v` shows `origin` for fetch and push.
- [ ] **Step 2: Write `tests/check.sh`** with these numbered checks, implementing the Global Constraints:
  1. SKILL.md exists, and `skills/opensense/` contains only `SKILL.md` and `references/`.
  2. The frontmatter has the exact keys, and the description follows its rules.
  3. SKILL.md is at most 300 lines, and its H2s appear in order.
  4. The exact text required in SKILL.md is present, including all six `references/<file>` paths.
  5. The six reference files exist and nothing else is in that folder. Each meets the length limit, starts with the `Read this when` line, and has no cross-references.
  6. No forbidden words appear under `skills/opensense/`.
  7. `platforms-and-accessibility.md` contains `44 pt`, `48 dp`, `24×24` and `WCAG 2.2`. `culture-and-language.md` contains `Arabic`, `Khmer`, `dir="rtl"` and `lang="km"`.
  8. The manifest rules hold. Versions are compared with SKILL.md once it exists; before that, the manifests must agree with each other.
  9. There is no `case.yaml` or `prompt.md` under `evals/fixtures/`.
  10. `uvx --from "git+https://github.com/agentskills/agentskills#subdirectory=skills-ref" skills-ref validate $REPO/skills/opensense` exits 0.
- [ ] **Step 3: Run it.** Run `bash $REPO/tests/check.sh`. Expected: exit 1, with `FAIL` on checks 1–8 and 10, and `OK 9`.
- [ ] **Step 4: Create the files.**
  - `.gitignore`: `.DS_Store`, `.cache/`, `evals/runs/`, `evals/results/20*/`, `node_modules/`.
  - `LICENSE`: the MIT text, `Copyright (c) 2026 Thith-thith`.
  - Shared one-sentence description: `Design judgment for AI coding agents: interfaces that fit the product and its people, with less clutter.`
  - `plugin.json`: `name`, `version "0.1.0"`, `description`, `author {name "Thith-thith", url "https://github.com/Thith-thith"}`, `homepage` and `repository` set to the repo URL, `license "MIT"`, `keywords ["design","ui","ux","accessibility","typography","localization","rtl"]`.
  - `marketplace.json`: `name "opensense"`, `owner {name, url}` as above, and `plugins [{name "opensense", description, version "0.1.0", source "./", author {name "Thith-thith"}}]`.
  - `gemini-extension.json`: `name`, `version`, `description` only. No context file, because Gemini finds `skills/` itself.
- [ ] **Step 5: Verify the manifests.**
  - Run `bash $REPO/tests/check.sh`. Expected: `OK 8` and `OK 9`, and still `FAIL` on the skill checks.
  - Run `claude plugin validate $REPO`. Expected: the manifest is valid. Record any warnings about a missing skill in the commit message.
- [ ] **Step 6: Commit** with the message `chore: repo foundation, manifests, structure check`.

### Task 2: Fixture cache, run collection, screenshots

**Files:**
- Create: `evals/fixtures/fetch.sh`, `evals/collect.sh`, `evals/shoot.sh`
- Create: `evals/README.md`, with sections Fixture, Collecting runs, Viewing and Owner decisions

**Interfaces:**
- Produces `bash $REPO/evals/fixtures/fetch.sh`. It is idempotent.
  - It creates `$REPO/.cache/app/` from shadcn-admin at the pinned SHA and runs `pnpm install --frozen-lockfile`.
  - It creates `$REPO/.cache/expo/` with create-expo-app@5.0.0 and the blank TypeScript template, with web support installed so that `npx expo export --platform web` works.
- Produces `bash $REPO/evals/collect.sh <result.json> <dest-dir> <arm> <label>`. Use `<label>` `baseline` in round 0 and `opensense` in rounds 1–2. With `--ablation none` the single arm is always called `with`, so the label is what tells the sides apart. For every run in `cases[].arms[<arm>]`, it:
  - copies `<root>/sealed/home/cwd` (excluding `node_modules` and `.claude`) to `<dest>/<case>/<label>/workspace/`;
  - copies `<root>/out/trace.jsonl` to `<dest>/<case>/<label>/trace.jsonl`;
  - appends `case,label,costUsd,turns` to `<dest>/costs.csv`;
  - then runs `chmod -R u+rwx <root>` and `rm -rf <root>`. It refuses any root that doesn't match `/private/tmp/e-*`.
- Produces `bash $REPO/evals/shoot.sh <url> <outdir> <light|dark>`. It writes:
  - `phone.png`: `npx -y playwright@1.65.0 screenshot --channel chrome --full-page --viewport-size "390, 844" --color-scheme <scheme> --wait-for-timeout 1500`;
  - `desktop.png`: the same at `"1440, 900"`;
  - `lighthouse.json`: `npx -y lighthouse@13.6.0 <url> --only-categories=accessibility --output=json --output-path=<file> --quiet --chrome-flags="--headless=new"`.

- [ ] **Step 1: Fetch the fixture.** Write and run `fetch.sh`. Expected:
  - `git -C $REPO/.cache/app rev-parse HEAD` prints `e16c87f213a5ba5e45964e9b67c792105ec74d26`;
  - `cd $REPO/.cache/expo && npx expo export --platform web` creates `dist/index.html`.
- [ ] **Step 2: Learn the fixture app.** Run `pnpm build && pnpm preview --port 4173 --strictPort` in `.cache/app`, then confirm `/`, `/tasks`, `/users`, `/settings` and `/settings/account` render without signing in. Record in the README's Fixture section:
  - which route shows which screen;
  - how dark mode is chosen (whether `--color-scheme dark` is enough);
  - how the direction provider switches to right-to-left.
- [ ] **Step 3: Test the screenshot helper.** Write `shoot.sh` and run it against `http://localhost:4173/`. Expected: three files, PNGs over 10 KB, and `lighthouse.json` with `.categories.accessibility.score` set.
- [ ] **Step 4: Write the README's Viewing procedure.**
  - **Static cases:** run `python3 -m http.server` in the workspace and shoot `index.html`.
  - **Fixture cases:** use the identical procedure for both sides.
    - Overlay the workspace onto a clonefile copy of `.cache/app` (`cp -cR`).
    - Run `pnpm install`, in case the agent added a dependency.
    - Run `pnpm build`. Count the build as failed only if it still fails after the install. A failed build is a recorded result, not a reason to retry.
    - start `pnpm preview`;
    - shoot the case's route in light and dark.
  - **t05:** also shoot the right-to-left state, the way the agent's final message describes.
  - **t10:** run `npx expo export --platform web` and shoot the phone size only.
- [ ] **Step 5: Test the collector.** Write `collect.sh` and test it on a hand-made fake result JSON whose `tracePath` points at a directory you created under `/private/tmp/e-test*`. Expected: the files are copied, the root is deleted, and a `tracePath` outside `/private/tmp/e-*` is refused.
- [ ] **Step 6: Commit** with the message `feat(evals): fixture fetch, run collection, screenshot helper`.

### Task 3: Eval cases and rubric (after G1)

**Files:** Create `evals/rubric.md`, plus `evals/<id>/case.yaml` (and `scaffold.sh` where noted) for every case below. Add the sections Cases and Running to `evals/README.md`.

**Interfaces:**
- Produces case ids and tags: `judged` (10), `seed` (2), `focus` (1), `trigger` (11). Later tasks select cases with `--tag`.
- Produces grader names: `honest-report`, `uses-system`, `keeps-critical-info`, `stays-light`, `no-invented-facts`, `fired`, `not-fired`, `complied`, `gradient-done`, `badges-done`, `ran`.

**Case conventions:**
- **Prompts** read like a real user wrote them, and never mention OpenSense or design skills.
- **Static-page prompts** end with: `Use plain HTML, CSS and JavaScript in this folder. You may load fonts from Google Fonts but nothing else external.`
- **Heavy cases** (judged, seed, focus): `runs: 1`, `max_turns: 60`, `timeout_seconds: 1800`, `allowed_tools: [Read, Glob, Grep, Write, Edit, Bash, Skill]`. The exception is t07, which gets read-only tools plus `Skill`.
- **Trigger cases:** `runs: 3`, `max_turns: 3`, `allowed_tools: [Read, Glob, Grep, Skill]`.
- **Scaffold scripts:**
  - start with `set -euo pipefail` and `here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"`;
  - copy with `cp -cR "$src/." . 2>/dev/null || cp -R "$src/." .`, then `rm -rf .git`;
  - exit with `run evals/fixtures/fetch.sh first` if the source is missing.
  - Sources:
    - fixture cases use `$here/../../.cache/app`;
    - t06 uses `$here/../fixtures/seed-dashboard`;
    - t07 and r01 use `$here/../fixtures/seed-landing`;
    - t10 uses `$here/../../.cache/expo`.

| id | tag | scaffold | prompt substance | graders |
|---|---|---|---|---|
| t01-settings-billing | judged | app | Add a Billing section to Settings: current plan, payment method, invoices, with an empty state (no invoices) and an error state (invoices failed to load), using the app's existing components and styles | honest-report, uses-system |
| t02-dashboard-improve | judged | app | The dashboard home feels generic and busy; improve it for a shop owner who checks it every morning, without redesigning the rest of the app | honest-report, uses-system, keeps-critical-info |
| t03-users-status-tweak | judged | app | In the Users list the status labels (active, inactive, invited, suspended) are hard to tell apart at a glance; fix that and change nothing else | honest-report, uses-system, keeps-critical-info, stays-light |
| t04-tasks-phone | judged | app | The Tasks page doesn't work well on a phone; make it work well at 390 px wide without changing the desktop layout | honest-report, uses-system |
| t05-profile-arabic | judged | app | Make Settings › Profile work in Arabic: translate its text, switch it to right-to-left, make layout, icons and fields read correctly | honest-report, uses-system |
| t06-improve-generated | judged | seed-dashboard | This dashboard was put together quickly and feels generic; improve it so it feels designed for the bakery owner who opens it every morning | honest-report, keeps-critical-info |
| t07-review-generated | judged | seed-landing | Review the landing page in this folder; list what to fix, most important first; don't change any files | honest-report |
| t08-khmer-landing | judged | none | Landing page for Suon Phnom Coffee (កាហ្វេសួនភ្នំ), a family café in Phnom Penh roasting beans from Mondulkiri farms; open 7:00–17:00, closed Mondays; No. 24, Street 240, Phnom Penh; orders via Telegram @suonphnomcoffee; all visible text in Khmer | honest-report, no-invented-facts |
| t09-clinic-form | judged | none | Mobile web form to register as a new patient at Hillside Community Clinic; many patients are new to smartphones; collect full name, date of birth, phone number, reason for visit; then confirm | honest-report, no-invented-facts |
| t10-native-habits | judged | expo | In this Expo app, build the main screen of an iOS habit tracker: today's habits with check-off, the current streak, adding a habit; TypeScript | honest-report |
| s01-seed-dashboard | seed | none | Dashboard for a small bakery's owner: today's orders, stock running low, who is on shift; realistic sample data; index.html, styles.css, app.js | ran |
| s02-seed-landing | seed | none | Landing page for a neighborhood bicycle repair shop; realistic sample content; index.html, styles.css | ran |
| r01-explicit-request | focus | seed-landing | Our owner wants the main headline in a purple-to-pink gradient text effect and a small "New" badge next to every service; please add both | complied, gradient-done, badges-done |
| tr01-pricing-page | trigger | none | "Build a pricing page for my yoga studio." | fired |
| tr02-settings-cluttered | trigger | none | "The settings screen feels cluttered. Can you clean it up?" | fired |
| tr03-save-button-blue | trigger | none | "Make the Save button on the profile form blue." | fired |
| tr04-orders-empty-state | trigger | none | "Add an empty state to the orders list." | fired |
| tr05-checkout-arabic | trigger | none | "Make the checkout page work in Arabic." | fired |
| tr06-onboarding-review | trigger | none | "Review our onboarding screens and tell me what to fix." | fired |
| tr07-swiftui-settings | trigger | none | "Build a SwiftUI settings screen for a meditation app." | fired |
| tn01-postgres-index | trigger | none | "Add a Postgres migration that adds an index on orders.created_at." | not-fired |
| tn02-csv-cli | trigger | none | "Write a CLI that converts CSV files to JSON." | not-fired |
| tn03-flaky-test | trigger | none | "Fix the flaky unit test in the payments service." | not-fired |
| tn04-s3-pipeline | trigger | none | "Set up a nightly job that loads S3 access logs into BigQuery." | not-fired |

If G1 swaps the languages, rewrite t05 and t08 (and tr05) for the chosen languages and keep everything else the same.

**Grader definitions.** `llm` graders use `focus: trace`. `honest-report` and `stays-light` judge the final message as it appears in the trace.

- **honest-report:** PASS only if the final message says what was checked and how, and what could not be checked. It must not claim the UI was viewed, rendered, screenshotted or tested unless the trace shows that happened.
- **uses-system:** PASS only if the edits reuse the app's existing components and theme tokens or classes. They add no new hard-coded color values (hex, rgb, hsl, oklch) and no one-off sizes outside the existing scale.
- **keeps-critical-info:** PASS only if no price, fee, error message, consent text, destructive-action warning or status indicator that existed before was removed or hidden.
- **stays-light:** PASS only if the change was made without asking questions or writing a design direction first.
- **no-invented-facts:** PASS only if the page adds no testimonials, ratings, awards, statistics, prices or claims that the prompt didn't give.
- **fired** and **not-fired:** `type: tool_used`, `tool: Skill`, `input_match: '"skill"\s*:\s*"(?:[\w-]+:)?opensense"'`. `fired` sets `min: 1`; `not-fired` sets `max: 0`.
- **gradient-done:** `regex`, `match: contains`, `pattern: 'background-clip:\s*text'`, `target: trace`.
- **badges-done:** `regex`, `match: contains`, `pattern: 'New'`, `target: trace`.
- **complied:** `llm`. PASS only if both requested changes were made, with at most one short note and no lecture.
- **ran:** `regex`, `match: contains`, `pattern: '.'`, `target: last_message`. This is a placeholder, because every case needs at least one grader.

- [ ] **Step 1: Write `evals/rubric.md`.**
  - Criteria come from design §9.6, scored 1–5, plus the per-task extras and an overall preference.
  - It explains blind A/B judging, the language check (design §9.5), and the "clearly worse on accessibility" rule. That rule fires when the OpenSense side has more failing Lighthouse accessibility audits than the baseline, or a judges' mean accessibility score at least 1 lower.
  - It includes a CSV header for score sheets: `task,judge,side,intentional,hierarchy_type,info_economy,context_fit,platform_fit,a11y,states,honesty,system_fit,scope,preferred_side,notes`.
- [ ] **Step 2: Write every case folder** from the table and conventions above.
- [ ] **Step 3: Run the free lint.** Run `claude plugin eval $REPO --ablation none --no-publish --trust-plugin --scaffold --allow-tools Write Edit Bash --max-cost-usd 0`. Expected:
  - $0 spent;
  - no advisory except ones you understand and note in the README;
  - the printed `Ablation:` line, recorded, which says whether a plugin with no skill still resolves.

  If any advisory rejects `focus: trace`, drop `focus` from all `llm` graders and say "in the final message" in their criteria.
- [ ] **Step 4: Run the structure check.** Run `bash $REPO/tests/check.sh`. Expected: `OK 9`.
- [ ] **Step 5: Commit** with the message `feat(evals): cases, graders, rubric`.

### Task 4: Measure the cost of two heavy runs (G2)

**Files:** Modify `evals/README.md` (Owner decisions).

- [ ] **Step 1: Run one static case and one fixture-app case.** The fixture-app cases (t01–t05) run in a real React codebase, so they likely cost much more than t09. With `.cache` fetched and no SKILL.md yet, both runs are baselines:

  ```bash
  for c in t09-clinic-form t01-settings-billing; do
    claude plugin eval $REPO --case $c --ablation none --no-publish --trust-plugin \
      --scaffold --allow-tools Write Edit Bash --model "$MODEL" --keep-temp --max-cost-usd 25 \
      --json $REPO/evals/runs/r0/$c.json --output-dir $REPO/evals/runs/r0/$c-eval
  done
  ```

  Expected: both runs finish, and `costUsd` is in each JSON.
- [ ] **Step 2: Collect both** with `bash $REPO/evals/collect.sh $REPO/evals/runs/r0/<case>.json $REPO/evals/runs/r0 with baseline`. They count as round 0's baselines for t09 and t01.
- [ ] **Step 3: Estimate the total** from both numbers: price fixture-app cases at t01's cost and static cases at t09's. Report to the owner, along with the run counts still to go:
  - 2 seeds;
  - 8 more round-0 runs;
  - 10 judged runs in each of rounds 1 and 2;
  - 11 trigger cases × 3 runs × 2 rounds;
  - r01 × 2.

  **Stop.** Record the approved `$BUDGET_USD` and the spend so far.
- [ ] **Step 4: Commit** the README change.

### Task 5: Round 0, seeds, baselines and findings

**Files:**
- Create: `evals/fixtures/seed-dashboard/*`, `evals/fixtures/seed-landing/*`, `evals/t07-review-generated/known-issues.md`, `evals/baseline-findings.md`

**Interfaces:**
- Consumes: Tasks 2–4.
- Produces: `evals/baseline-findings.md`. It ends with a ranked list of 15 or fewer items under the heading `What OpenSense must change`. Tasks 6–8 must each say which items they address.

- [ ] **Step 1: Run the seeds** with `--tag seed`, the base flags and `--allow-tools Write Edit Bash` (`--json $REPO/evals/runs/r0/seeds.json`). Then collect them with the label `baseline`, and check that each seed workspace holds the requested files before you continue. Copy only the seed HTML, CSS and JS into `evals/fixtures/seed-dashboard/` and `evals/fixtures/seed-landing/`. Expected: `bash tests/check.sh` still prints `OK 9`.
- [ ] **Step 2: Write `known-issues.md`.** Shoot seed-landing and list its issues, most important first. Write this before any OpenSense content exists. Agents never see this file, because the scaffold copies only the seed.
- [ ] **Step 3: Run the other eight judged cases** in two calls, `--case 't0[2-8]-*'` and `--case 't10-*'`, so t01 and t09 aren't paid for twice. If the glob form isn't accepted, run each id with `--case <id>`. Use the base flags plus `--scaffold --allow-tools Write Edit Bash`. Write the JSON to `$REPO/evals/runs/r0/judged-a.json` and `judged-b.json`, then collect each into `$REPO/evals/runs/r0` with the label `baseline`.
- [ ] **Step 4: Shoot every r0 result** using the README's Viewing procedure.
- [ ] **Step 5: Write `baseline-findings.md`.** For each case record:
  - counts of cards, badges, helper-text lines and explanatory paragraphs;
  - problems with hierarchy and type;
  - failing Lighthouse audit ids;
  - language problems (t05, t08);
  - grader verdicts;
  - what the agent claimed compared with what it did.

  Then add the ranked list.
- [ ] **Step 6: Commit** the seeds, the known issues and the findings with the message `feat(evals): round 0 baselines and findings`. `evals/runs` stays ignored.

### Task 6: SKILL.md

**Files:** Create `skills/opensense/SKILL.md`.

**Interfaces:**
- Consumes: `evals/baseline-findings.md`.
- Produces: the H2 headings and the `References` routing lines that Tasks 7–8 and check.sh rely on. Each line has the form `Read references/<file> when …`.

- [ ] **Step 1: Confirm the failure.** Run `bash $REPO/tests/check.sh`. Expected: `FAIL 1`.
- [ ] **Step 2: Write SKILL.md** to design §8.2–8.3 and the Global Constraints:
  - **Size the task:** a table with the four rows from §8.3.
  - **Build:** has bold lead-ins for the eight areas in §8.3, item 6. Rules use the Default/Why/Deviate shape.
  - **Accessibility floor:** lists the pinned numbers.
  - **Common generated-UI tells:** lists the ten tells from §8.3, item 8, framed as "don't default to these unless the context calls for them".
  - **Findings:** every finding in `What OpenSense must change` is addressed here or assigned to a reference. Append a `finding → where` table to `baseline-findings.md`.
- [ ] **Step 3: Run the check.** Run `bash $REPO/tests/check.sh`. Expected: `OK` for checks 1–4, 6 and 8–10 (skills-ref checks only frontmatter); `FAIL` only for checks 5 and 7, because the references don't exist yet.
- [ ] **Step 4: Confirm discovery and triggering** with one cheap run:

  ```bash
  claude plugin eval $REPO --case tr01-pricing-page --runs 1 --ablation none <base flags>
  ```

  Expected: the `fired` grader passes. If it fails, fix the description before continuing.
- [ ] **Step 5: Commit** with the message `feat(skill): SKILL.md`.

### Task 7: References for UX, words, and visual and interaction design

**Files:** Create `skills/opensense/references/ux.md`, `typography-and-words.md` and `visual-and-interaction.md`.

**Interfaces:** Consumes the routing lines from Task 6 and the findings assigned to these files.

- [ ] **Step 1: Write the three files.** Each covers its scope list in design §8.4 and follows the reference-file contract. In addition:
  - `ux.md` shows a destructive-action Before/After where the after-version names the object and the consequence.
  - `typography-and-words.md` has at least three before/after cuts (information economy) and type-scale guidance for product UI versus marketing pages.
  - `visual-and-interaction.md` covers light and dark modes through tokens, and has a section on finding identity in the subject and audience.
- [ ] **Step 2: Run the check.** Run `bash $REPO/tests/check.sh`. Expected: no `FAIL` that names these three files.
- [ ] **Step 3: Commit** with the message `feat(skill): ux, typography-and-words, visual-and-interaction references`.

### Task 8: References for platforms and accessibility, culture and language, and review

**Files:** Create `skills/opensense/references/platforms-and-accessibility.md`, `culture-and-language.md` and `review.md`.

- [ ] **Step 1: Write the three files** to design §8.4 and the reference-file contract.
  - **`platforms-and-accessibility.md`** contains the pinned numbers and the names VoiceOver and TalkBack.
  - **`culture-and-language.md`** must cover each of these, with an example:
    - **Khmer:** set `lang="km"`. Use a larger size and enough line height for stacked consonants and vowels, and never clip them. Let the platform break lines and never force `break-all`. Choose a font with Khmer coverage, and keep display styles like Moul for short titles.
    - **Arabic:** set `dir="rtl"` and use logical properties (`margin-inline-start`). Mirror only directional icons. Isolate mixed-direction text. Never letter-space Arabic. Choose numerals per locale. Arabic may need a larger size than Latin text at the same pixel value.
    - **People new to technology:** apply §8.4.
  - **`review.md`:**
    - groups its checklist under the seven capability names from brief §5, spelled exactly;
    - specifies a report format with findings ranked by impact on users (what, where, fix);
    - ends with `Checked:` and `Not checked:` lines.
- [ ] **Step 2: Run the full check.** Run `bash $REPO/tests/check.sh`. Expected: every check `OK`, including skills-ref (check 10).
- [ ] **Step 3: Check the packaging.**
  - Run `claude plugin validate $REPO`. Expected: valid.
  - Run `npx -y skills add $REPO --list`. Expected: exactly one skill, `opensense`.
- [ ] **Step 4: Commit** with the message `feat(skill): platforms-and-accessibility, culture-and-language, review references`.

### Task 9: Install verification (G4 for Codex and Gemini CLI)

**Files:** Modify `evals/README.md` (an Install checks table: agent, method, date, version, result). Create `.codex-plugin/plugin.json` only if Step 4 succeeds.

- [ ] **Step 1: Claude Code plugin route.** This temporarily changes the owner's config, and the change is undone in this step.
  1. Run `claude plugin marketplace add $REPO`, then `claude plugin install opensense@opensense`.
  2. Run `claude plugin details opensense`. Expected: it lists the skill `opensense`.
  3. **Coexistence trigger check.** These runs are paid, and they use the owner's normal setup, including any other design skills and session-start hooks the owner has installed.
     - Run them inside a fresh `mktemp -d` folder.
     - Run each tr/tn prompt once as `claude -p "<prompt>" --max-turns 3 --disallowed-tools Write Edit Bash --output-format stream-json --verbose`.
     - Record whether the trace has a `Skill` call with `opensense`.

     Treat the results as observations, not pass/fail: the owner's hooks may start another skill first. The isolated trigger runs in Tasks 10 and 12 are the real bar.
  4. Run `claude plugin uninstall opensense@opensense` and `claude plugin marketplace remove opensense`. Expected: `claude plugin list` no longer shows it.
- [ ] **Step 2: skills CLI route for Claude Code and Antigravity.**
  - In a fresh temporary project, run `npx -y skills add $REPO -s opensense -a claude-code -y`. Expected: `.claude/skills/opensense/SKILL.md` exists, and a UI prompt there fires the skill.
  - Run `npx -y skills add $REPO -s opensense -a antigravity -g -y`. Confirm in `agy` that the skill is listed (find the listing command with `agy --help`), then run `npx -y skills remove opensense -a antigravity -g -y`.
- [ ] **Step 3: Gemini CLI (after G4).**
  - Install the extension from the local checkout with `gemini extensions install` or `link`, whichever `gemini extensions --help` offers.
  - Confirm the skill is listed, and that it loads for a UI prompt.
  - Uninstall it.
- [ ] **Step 4: Codex (after G4).**
  - Run `npx -y skills add $REPO -s opensense -a codex -y`, confirm the skill is listed and loads, then remove it.
  - Check `codex --help` for a plugin install from a repo. If one exists, add `.codex-plugin/plugin.json` following superpowers' pattern (`name`, `version`, `description`, `author`, `homepage`, `repository`, `license`, `keywords`, `"skills": "./skills/"`, `interface`), install it for real, and verify. Otherwise record "Codex: npx skills add only".
- [ ] **Step 5: Run the check.** Run `bash $REPO/tests/check.sh`. Expected: all `OK`, now including the Codex manifest if it was added. Extend check 8 to cover it.
- [ ] **Step 6: Commit** with the message `test: install checks`.

### Task 10: Round 1, the with-OpenSense runs and first judging (G3)

**Files:** Create `evals/results/round-1.md` and `evals/results/img/` (optional curated pairs).

- [ ] **Step 1: Run the cases** with `--tag judged`, then `--tag trigger`, then `--case r01-explicit-request`. Use `--ablation none`, the base flags, `--scaffold --allow-tools Write Edit Bash`, and the remaining budget. Write the JSON to `evals/runs/r1/{judged,trigger,focus}.json`, then collect it into `evals/runs/r1` with the label `opensense`.
- [ ] **Step 2: Shoot every r1 result** using the Viewing procedure.
- [ ] **Step 3: Build blind packets.**
  - Pair `r0/<case>/baseline` against `r1/<case>/opensense` for each judged case.
  - Assign A and B with `python3 -c "import random; random.seed(<recorded seed>) …"`.
  - Write the key to `evals/runs/r1/key.csv`, which is never shared.
  - Packets go in `evals/runs/r1/judging/<case>/{A,B}/` and include the zipped workspaces.
  - For t07, the packet holds `A.md` and `B.md` (the critiques) plus `known-issues.md`.
- [ ] **Step 4: Owner steps.**
  - The language readers check t05 and t08 on both sides, and their notes are added to the packets.
  - The judges fill score sheets using the rubric's CSV header.
- [ ] **Step 5: Write `round-1.md`.** Include:
  - the majority preference per task;
  - the mean score for each criterion;
  - per side, the Lighthouse accessibility score and the failing audit ids, flagging any new `button-name` or `link-name` failure;
  - grader verdicts;
  - for t01–t06 on each side:
    - the diff size, compared with the starting point (`.cache/app`, or `evals/fixtures/seed-dashboard` for t06): `diff -ru --exclude=node_modules <start> <workspace> | grep -cE '^[+-][^+-]'`;
    - the count of new hard-coded colors among the added lines: `grep -E '^\+' | grep -cE '#[0-9a-fA-F]{3,8}\b|rgba?\(|hsla?\(|oklch\('`;
  - trigger fire rates (pass: each tr case 2/3 or better, each tn case 0/3);
  - the r01 verdicts;
  - spend.
- [ ] **Step 6: Commit** with the message `docs(evals): round 1 results`.

### Task 11: Revise the skill from round 1

**Files:** Modify files under `skills/opensense/`. Add a `Changes made` section to `evals/results/round-1.md`.

- [ ] **Step 1: Fix what round 1 found.** Turn every lost task, weak criterion, failed grader and trigger miss into a concrete edit. Record each one in `Changes made` as `finding → edit`.
- [ ] **Step 2: Run the check.** Run `bash $REPO/tests/check.sh`. Expected: all `OK`.
- [ ] **Step 3: Commit** with the message `fix(skill): revisions from round 1`.

### Task 12: Round 2, the release candidate (G3)

**Files:** Create `evals/results/round-2.md`.

- [ ] **Step 1: Run round 2.** Repeat Task 10's Steps 1–5 into `evals/runs/r2`, with a new random seed, comparing against r0 again.
- [ ] **Step 2: Decide against the release bar** in `round-2.md`. The bar requires all of these:
  - judges prefer OpenSense on 7 or more of the 10 tasks;
  - no task is clearly worse on accessibility (the rubric's rule);
  - no new `button-name` or `link-name` failures;
  - the trigger bar is met;
  - r01 passes;
  - `tests/check.sh` is all `OK`;
  - the Task 9 installs are verified.

  If the bar is missed, stop and report to the owner, offering another revision round or a release labeled "preview". If there was no independent judge, the README labels the release "preview" (design §9.5).

  `round-2.md` states plainly that each side is a single run, and that the same 10 tasks were used to revise the skill between rounds.
- [ ] **Step 3: Commit** with the message `docs(evals): round 2 results`.

### Task 13: README and curated comparisons

**Files:** Create `README.md`. Create `evals/results/img/*`, the curated round-2 pairs.

- [ ] **Step 1: Write README.md** to design §10. It covers:
  - what OpenSense is, in the brief's language;
  - three or four before/after pairs, plus one honest weak case;
  - install steps per agent, taken only from the verified rows of the Install checks table, using the public paths (`npx skills add Thith-thith/opensense`, `/plugin marketplace add Thith-thith/opensense`, `gemini extensions install https://github.com/Thith-thith/opensense`);
  - the rule "use one install method per agent";
  - how to use it;
  - what it deliberately doesn't do;
  - a link to `evals/results/round-2.md`, together with the same honesty note: one run per side, and the same tasks were used for revisions;
  - the "preview" label if the release needs it.
- [ ] **Step 2: Check it.** Run `bash $REPO/tests/check.sh` and `claude plugin validate $REPO`. Expected: all `OK`, and valid.
- [ ] **Step 3: Commit** with the message `docs: README`.

### Task 14: Release (G5)

- [ ] **Step 1: Owner decision.** Ask for an explicit OK to push to the public repo. Machine-specific mentions were removed from `docs/` at G0, before the first commit.
- [ ] **Step 2: Publish.** Run `git -C $REPO tag v0.1.0 && git -C $REPO push -u origin main --tags`. Expected: `gh repo view Thith-thith/opensense --json defaultBranchRef` shows `main`.
- [ ] **Step 3: Verify the public installs.**
  - `npx -y skills add Thith-thith/opensense --list` lists `opensense`.
  - `claude plugin marketplace add Thith-thith/opensense` and `claude plugin install opensense@opensense`, then `claude plugin details opensense` lists the skill. Uninstall and remove afterwards.
  - Gemini CLI: `gemini extensions install https://github.com/Thith-thith/opensense` lists the skill. Uninstall afterwards.
  - Update the README if any public path behaves differently from the local one.
- [ ] **Step 4: Release notes.** Only with the owner's OK, run `gh release create v0.1.0` with notes summarizing round 2.
