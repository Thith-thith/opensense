# OpenSense evals

Evaluation runs on Claude Code's built-in `claude plugin eval`. The scripts here stage fixtures, collect kept runs and take screenshots. Human blind judging decides the release; grader scores are supporting evidence only.

## Fixture

`bash evals/fixtures/fetch.sh` is idempotent. It creates, under `.cache/` (gitignored):

- `.cache/app/`: shadcn-admin (Vite, React, TanStack Router, shadcn/ui) at commit `e16c87f213a5ba5e45964e9b67c792105ec74d26`, installed with `pnpm install --frozen-lockfile`.
- `.cache/expo/`: create-expo-app@5.0.0 with the blank-typescript template, plus `react-dom`, `react-native-web` and `@expo/metro-runtime`, so `npx expo export --platform web` writes `dist/index.html`. Run it with `CI=1` and stdin closed when scripting.

Run the app with `pnpm build && pnpm preview --port 4173 --strictPort` in `.cache/app`.

**Routes.** All of these render without signing in (the app has no auth guard; routes under `/clerk` need a Clerk key, so ignore them):

| Route | Screen |
| --- | --- |
| `/` | Dashboard: revenue cards, bar chart, recent sales |
| `/tasks` | Tasks table with filters and pagination |
| `/users` | User List table, Invite User and Add User buttons |
| `/settings` | Settings shell, opens the Profile tab |
| `/settings/account` | Account form: name, date of birth, language |

Other settings tabs: `/settings/appearance`, `/settings/notifications`, `/settings/display`.

**Dark mode.** The theme defaults to `system` and the page follows `prefers-color-scheme`, so `--color-scheme dark` (what `shoot.sh` passes) is enough on a fresh browser. A saved `vite-ui-theme` cookie overrides it, which does not happen in a fresh Playwright context.

**Right-to-left.** `DirectionProvider` sets `dir` on `<html>` from a `dir` cookie (`ltr` or `rtl`, default `ltr`). In the UI, open the settings gear in the top bar (config drawer), then Direction, then the RTL option. `shoot.sh` cannot set cookies. To shoot the RTL state, use Playwright's `--load-storage` with a state file holding a `dir=rtl` cookie for `localhost`, as in the screenshot command `npx -y playwright@1.65.0 screenshot --channel chrome --load-storage rtl.json ...` (checked on `/users`: layout mirrors, sidebar moves right, table columns reverse).

## Collecting runs

Run `claude plugin eval` with `--keep-temp`. Each run leaves a root such as `/private/tmp/e-AbC123/` holding `out/trace.jsonl`, `sealed/` (mode 000) and `config/`. The workspace is `<root>/sealed/home/cwd/`. Never run git inside a kept root.

```
bash evals/collect.sh <result.json> <dest-dir> <arm> <label>
```

- `<label>` is `baseline` in round 0 and `opensense` in rounds 1 and 2. With `--ablation none` the single arm is always `with`, so the label tells the sides apart.
- For each run in `cases[].arms[<arm>]` it copies the workspace (without `node_modules` and `.claude`) to `<dest>/<case>/<label>/workspace/`, the trace to `<dest>/<case>/<label>/trace.jsonl`, and appends `case,label,costUsd,turns` to `<dest>/costs.csv`. Then it deletes the kept root, because it holds copied home config.
- Runs with an empty `tracePath` (errored before launch) and absent arms are skipped, with a message.
- It validates the whole batch first and refuses, changing nothing, on: a root that is not a direct `/private/tmp/e-*` or `/tmp/e-*` folder, a symlinked root, a `tracePath` not ending in `/out/trace.jsonl`, an arm with more than one run per case (one run per case is assumed), or an existing `<dest>/<case>/<label>`.

Raw runs go to `evals/runs/` (gitignored). Curated results go to `evals/results/`.

## Viewing

`bash evals/shoot.sh <url> <outdir> <light|dark>` writes `phone.png` (390x844), `desktop.png` (1440x900), both full page, and `lighthouse.json` (accessibility category; the score is `.categories.accessibility.score`).

**Static cases.** Run `python3 -m http.server` in the workspace and shoot `index.html`.

**Fixture cases.** Use the identical procedure for both sides:

1. Overlay the workspace onto a clonefile copy of `.cache/app` (`cp -cR`).
2. Run `pnpm install`, in case the agent added a dependency.
3. Run `pnpm build`. Count the build as failed only if it still fails after the install. A failed build is a recorded result, not a reason to retry.
4. Start `pnpm preview`.
5. Shoot the case's route in light and dark.

**t05.** Also shoot the right-to-left state, the way the agent's final message describes (the `dir=rtl` cookie, see Fixture).

**t10.** Run `npx expo export --platform web` and shoot the phone size only.

Stop every preview or HTTP server when done and delete temporary copies.

## Owner decisions

- Execution: subagent-driven.
- G0: machine-specific mentions scrubbed from `docs/` before the first commit.
- G1: Arabic and Khmer (the owner chose Khmer). Readers are not yet found; if none turn up before judging, swap the language then and re-run the t05 and t08 baselines.
- G2: `$MODEL` is `claude-sonnet-5-5`. Measured on 2026-11-10 (baseline runs, no skill): t09-clinic-form cost $0.176 (5 turns, 70 s), t01-settings-billing cost $0.362 (41 turns, 90 s); judging adds about $0.02 and $0.03. Budget: pending owner approval.
- G3 to G5: open.

## Cases

One folder per case, each with `case.yaml` and, where the case starts from files, `scaffold.sh`. Select cases with `--tag`.

| Tag | Cases | Run |
|---|---|---|
| `judged` (10) | t01 to t10: the human-judged tasks (design §9.2) | 1 run, 60 turns |
| `seed` (2) | s01-seed-dashboard, s02-seed-landing: generate the inputs for t06 and t07 | 1 run, 60 turns |
| `focus` (1) | r01-explicit-request: an explicit user request must be followed, not argued with | 1 run, 60 turns |
| `trigger` (11) | tr01 to tr07 should load the skill (`fired`), tn01 to tn04 should not (`not-fired`) | 3 runs, 3 turns, read-only tools |

- Scaffolds copy a source into the empty workspace, then remove `.git` and `dist`: `.cache/app` (t01 to t05), `.cache/expo` (t10), `fixtures/seed-dashboard` (t06), `fixtures/seed-landing` (t07, r01). The seed folders are created from the s01 and s02 outputs. A scaffold exits with "run evals/fixtures/fetch.sh first" if its source is missing. The Expo template's own CLAUDE.md and AGENTS.md stay, because both sides see them equally.
- t07 gets read-only tools plus `Skill`.
- `llm` graders use `focus: trace`. The free lint accepts it.
- `ran` is a placeholder grader, because every case needs at least one.
- Scoring is in `rubric.md`.

## Running

Every paid run passes `--no-publish --trust-plugin --model "$MODEL" --keep-temp --max-cost-usd <remaining budget>`. Without `--no-publish`, a report that includes the prompts is published to claude.ai.

Heavy runs (judged, seed, focus) also pass `--scaffold --allow-tools Write Edit Bash`. Writing needs both that flag and the case's `allowed_tools`.

```
claude plugin eval . --tag judged --ablation <none|...> --no-publish --trust-plugin --model "$MODEL" --keep-temp --max-cost-usd <N> --scaffold --allow-tools Write Edit Bash
```

Trigger runs (`--tag trigger`) never use `--keep-temp`: they need no workspace, and a kept root holds copied home config.

Free lint, spends nothing:

```
claude plugin eval . --ablation none --no-publish --trust-plugin --scaffold --allow-tools Write Edit Bash --max-cost-usd 0
```
