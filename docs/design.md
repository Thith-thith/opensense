# OpenSense: design for v1

Date: 2026-11-10 · Status: approved 2026-11-10 (the owner sent the repo in reply to the approval request) · Source: [brief.md](brief.md)

Anything marked **(Claude's call)** was decided by Claude while writing this, and the owner can overrule it. Everything else comes from the owner, either in the brief or in conversation.

---

## 1. Intent

OpenSense is an open-source Agent Skill that gives AI coding agents a designer's judgment when they build or change user interfaces.

**Why it exists.** AI made building software cheap, and the result is a flood of interfaces that look alike: card grids, badges, gradients, explanatory paragraphs, desktop layouts squeezed onto phones. People don't trust or invest in a product that looks like something anyone's agent could produce. Working code is no longer the hard part. The hard part is making something people trust, enjoy and find valuable.

**What it changes.** OpenSense does not give the agent a style. It changes how the agent decides:

- understand the product and its people first;
- give every element, word, color and interaction a reason to exist, and cut what has none;
- fit the design to the product's context, not to a trend;
- don't call it done because it compiles.

Tagline: *Design with intention.*

**The balance is the point.** OpenSense is not "make it minimal". The pairs in brief §3 set the target:

- minimal without losing function;
- simple without dropping important information;
- distinctive without chasing trends;
- clean without feeling sterile.

A form for first-time smartphone users and a trading dashboard should look nothing alike, and both should look designed.

The full philosophy (brief §3–4) is the reference. The skill condenses it and must never contradict it.

### 1.1 Emphasis (owner confirmed 2026-11-10)

OpenSense leads with two strengths that the existing design skills cover least:

1. **Improving what already exists, inside its own design system, with no setup.** Most real agent UI work is a change to an existing product. Of the skills read for this doc:
   - impeccable requires a PRODUCT.md before any design work (plus a confirmed brief for its `craft` command), and runs Node scripts;
   - Anthropic's frontend-design is mostly about giving new pages a distinctive identity.
2. **Cutting clutter (information economy) as the signature move.** It is also measurable: count the cards, badges, helper-text lines and explanatory paragraphs before and after.

New-product design is still fully in scope. The emphasis only decides what gets the most care and eval coverage.

---

## 2. Goals (v1)

1. **Measurably better UI.** Agents using OpenSense produce UI that human judges rate as more intentional, clearer and better fitted to its context than the same agent produces without it, so it needs less human design correction. The eval in §9 is how that is shown (Claude's call for the eval's form).
2. **Works in any agent.** It runs in Claude Code, Codex, Gemini CLI and any other agent that supports the Agent Skills standard, with nothing to set up beyond installing it and no runtime dependencies.
3. **Any platform.** It covers responsive web, native mobile (iOS, Android), tablet and desktop apps, in whatever framework the project uses.
4. **Process scales with the task.** A one-line tweak gets a light touch. A new product gets discovery and a direction before any code.
5. **Honest reporting.** The agent reports what it actually looked at and verified, and what it couldn't.

## 3. Non-goals (v1) (Claude's call)

- **Not a kit.** No component library, theme, token generator or UI kit.
- **No tooling inside the skill.** The skill folder contains no scripts, live browser modes or automated detectors. OpenSense uses whatever the agent already has (browser preview, screenshots, simulators) and works without any of it.
- **One entry point.** No command menu or sub-commands.
- **No files written into users' projects** to persist design context, such as PRODUCT.md or DESIGN.md. It reads such files when they exist.
- **No always-on loading.** No hooks or session-start context files. It loads on demand like any skill.
- **No asset generation.** No logos, illustrations or generated imagery.
- **No eval harness of our own.** *(Changed during planning, 2026-11-10.)* The eval runs on Claude Code's built-in `claude plugin eval`. Probes showed that it gives every run its own config and home folders, so the owner's hooks and skills don't leak in, and that it keeps each run's files. A few small developer scripts are added outside the skill: a structure check, a fixture fetch, run collection and a screenshot helper. The steps that stay manual are written down in `evals/README.md`.
- **No usability tests with real users.** Brief §9 lists them as one way to judge quality, but they need recruited target users and calendar time. v1 uses blind judging (§9). Usability tests are the first step after v1.

## 4. Anti-goals: failure even if it "works"

- **An "OpenSense look".** If outputs become recognizable as made with OpenSense, it has failed. Write guidance as defaults with reasons and stated exceptions, not as absolute taste bans (no "never use this color or punctuation" rules). (Claude's call, from "Context Over Trends")
- **Forced minimalism that drops information people need.** That includes errors, prices and fees, consent, the consequences of destructive actions, and system state.
- **Heavy process on small tasks.** No questionnaires, gates or design briefs before a spacing fix.
- **Claims without evidence.** Never claim to have seen, tested or validated something it didn't.
- **Invented facts.** Never invent product features, brand claims, metrics, testimonials or user research.
- **A borrowed definition of good.** Apple, Linear, Stripe or any other reference is not the default definition of "good".
- **Overriding an existing design system** with OpenSense's taste, or rebuilding something it was asked to refine.
- **Breaking platform conventions** to look distinctive, such as Android navigation patterns in an iOS app.
- **Treating accessibility as optional.**
- **Single-agent instructions.** No tool names or model names that only make sense in one agent.

---

## 5. Constraints

### 5.1 Agent Skills standard (checked 2026-11-10 at agentskills.io/specification)

- **Folder and file.** The skill is a folder `opensense/` with a `SKILL.md`: YAML frontmatter followed by Markdown.
- **`name`** (required): 1–64 characters, lowercase a–z, 0–9 and hyphens. No hyphen at the start or end, and no double hyphens. It must equal the folder name, so it is `opensense`.
- **`description`** (required): 1–1024 characters. It must say what the skill does and when to use it, with specific keywords.
- **Optional fields:**
  - `license` and `metadata` (a map of strings to strings) are used.
  - `compatibility` is not needed.
  - `allowed-tools` is experimental and not used.
- **References.** Optional folders are `scripts/`, `references/` and `assets/`. Reference files by relative path, one level deep from SKILL.md, with no reference that points on to another reference.
- **Size.** The spec says the SKILL.md body should stay under 5,000 tokens and 500 lines. OpenSense targets **≤ 300 lines** (Claude's call).
- **What loads when.** The name and description are always loaded (about 100 tokens). The SKILL.md body loads when the skill activates. Reference files load only when the agent reads them.
- **Validation.** Check with `skills-ref validate` (github.com/agentskills/agentskills, `skills-ref/`).

### 5.2 Agent-neutral writing

- No tool names (Read, Bash, Playwright, MCP servers) and no model or vendor names. Describe capabilities instead: "if you can open the UI in a browser or capture a screenshot…".
- It must work when the agent can see nothing: no browser, no screenshots, no simulator.

### 5.3 Authority order (Claude's call)

When sources disagree, the higher one wins:

1. The user's explicit instructions for the current task.
2. The project's existing design system, brand and conventions: tokens, components, existing screens, and design docs such as DESIGN.md, PRODUCT.md or brand guides.
3. Platform conventions for web, iOS, Android and desktop operating systems.
4. OpenSense defaults.

SKILL.md states this order. It is what makes "improve within the existing system" work, and it lets OpenSense coexist with other design skills and their context files.

### 5.4 Coexistence

Users may also have other design skills installed, such as impeccable or frontend-design. OpenSense must not depend on them, mention them or argue with them. Its description must be specific enough to trigger on its own merits. (Claude's call)

### 5.5 One install path per agent (Claude's call)

Installing the same skill twice into one agent, for example as a plugin and again through the skills CLI, loads two copies. This happens in practice: a design skill installed both ways loads twice in the same session, and its two copies can give conflicting instructions. The README must tell users to choose one install method per agent.

### 5.6 License and originality

- MIT license. (Claude's call)
- All guidance is written fresh. WCAG 2.2, Apple's Human Interface Guidelines and Material Design 3 may be cited by name and link, but text is never copied from them or from other skills.

---

## 6. Distribution

The owner's decision: OpenSense is "a plugin which anyone can install into Claude Code, Codex, Gemini and others".

The content exists once, at `skills/opensense/`. Thin manifests point each agent at it. (Claude's call)

| Agent | How users install | What the repo needs | Verified? |
|---|---|---|---|
| Any Agent Skills agent (Cursor, Copilot, OpenCode, Codex, Gemini CLI, Claude Code, …) | `npx skills add Thith-thith/opensense` | `skills/opensense/SKILL.md` | **Pattern seen.** The skills CLI installs anthropics/skills from `skills/<name>/SKILL.md` and links skills into each agent's folder, such as `~/.claude/skills`, `~/.codex/skills` and `~/.gemini/skills`. |
| Claude Code (plugin) | `/plugin marketplace add Thith-thith/opensense`, then `/plugin install opensense@opensense` | `.claude-plugin/plugin.json` (skills in `skills/` are found by convention), plus `.claude-plugin/marketplace.json` with one plugin entry, `"source": "./"` | **Pattern seen** in obra/superpowers v7.0.0. Not yet installed. |
| Gemini CLI (extension) | `gemini extensions install https://github.com/Thith-thith/opensense` | `gemini-extension.json` (name, version, description) and no context file, because Gemini finds the bundled `skills/` folder itself | **Pattern seen** in superpowers' porting guide. Not yet installed. |
| Codex (plugin) | **Unverified** | `.codex-plugin/plugin.json` with `"skills": "./skills/"` (the superpowers pattern) | **Not verified.** Superpowers documents Codex installs only through OpenAI's official marketplace. In v1, Codex users install with `npx skills add`. The builder checks whether Codex can install a plugin directly from a repo, and adds the manifest only if a real install works. |

**Done means installed.** On each agent above, install from a local checkout (or the published repo), start a session, and confirm that OpenSense shows up in the skill list and loads for a UI prompt. A manifest that hasn't been installed for real doesn't count. The README claims only installs that have been verified. (Claude's call)

**"Gemini" covers both of Google's agents.** (Claude's call)
- **Gemini CLI** installs the extension above.
- **Antigravity** (the IDE and the `agy` CLI) installs through `npx skills add`. The skills CLI installs into Antigravity's global skills folder, and the `agy` CLI can confirm the install.
- **Codex and Gemini CLI checks** need those CLIs installed and signed in.

**Not in v1:** manifests for Cursor, Copilot CLI, Antigravity and other plugin systems, because `npx skills add` already covers those agents. Add them later if people ask. (Claude's call)

---

## 7. Repository layout (Claude's call)

```
opensense/
├── skills/opensense/
│   ├── SKILL.md
│   └── references/
│       ├── ux.md
│       ├── typography-and-words.md
│       ├── visual-and-interaction.md
│       ├── platforms-and-accessibility.md
│       ├── culture-and-language.md
│       └── review.md
├── evals/
│   ├── README.md          how to run and judge the eval
│   ├── rubric.md          what judges score
│   ├── <case-id>/         one folder per eval or trigger case: case.yaml (+ scaffold.sh)
│   ├── fixtures/          fetch script for the fixture app; generated seed pages
│   ├── collect.sh         copies kept run folders out, then deletes them
│   ├── shoot.sh           screenshots + accessibility numbers for one URL
│   └── results/           curated side-by-side comparisons
├── tests/
│   └── check.sh           structure check for the skill and manifests
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── gemini-extension.json
├── docs/
│   ├── brief.md
│   ├── design.md
│   └── plan.md
├── .gitignore             ignores .cache/ (fixture app + Expo template) and raw eval runs
├── README.md
└── LICENSE
```

*(Layout changed during planning, 2026-11-10.)* `claude plugin eval` reads one folder per case, so the single `evals/prompts.md` became case folders. `tests/check.sh`, `evals/fixtures/fetch.sh`, `evals/collect.sh` and `evals/shoot.sh` are developer tools outside the skill. The fixture cache lives in `.cache/` at the repo root, outside `evals/`, so case discovery never scans its `node_modules`.

Five reference files follow the v1 list in brief §8. The sixth, culture-and-language.md, covers the area the owner chose to go deep on (§8.5). Six is the limit, so tighten a file that runs long rather than split it.

---

## 8. The skill

### 8.1 How it's written (Claude's call, and the most important decision in this doc)

Models already "know" design principles, so restating them changes little. These things do change what a model produces:

- **Checks at the moment of decision.** Phrase guidance as checks the agent runs right when it is about to act. Example: "Before adding a badge, ask what state it reports that nothing else on screen already shows. If none, leave it out."
- **Defaults with a reason and an exception.** Use the form "Default: X. Why: Y. Deviate when Z." Don't write bans.
- **Short before/after examples.** Keep them concrete, as a plain description or minimal markup. Add a non-web example wherever a rule differs on native platforms.
- **The essentials live in SKILL.md.** Agents often skip reference files. References add depth; they don't hold the rules that matter most.
- **Clear triggers.** Each reference opens with one line saying when to read it, and SKILL.md lists the same triggers.

### 8.2 Frontmatter

- `name: opensense`
- `description`: written to trigger correctly.
  - It must cover creating, changing or reviewing UI on any platform, including small visual and copy tweaks; screens, components, forms, dashboards, landing pages, onboarding, and empty and error states; responsive, localization, right-to-left and accessibility work; and design reviews.
  - It must exclude backend-only work.
  - It must be a single line with no `: ` and no ` #`, so that it stays a valid plain YAML value in every agent's parser. *(Added during planning, 2026-11-10: the first draft had "platform: web", which plain YAML can't hold.)*
  - Starting draft for the builder to tune with trigger tests (§9.4):
  > Design judgment for building and improving user interfaces on any platform (web, iOS, Android, desktop). Use whenever you create, change, or review UI, including pages, screens, components, forms, dashboards, landing pages, onboarding, empty and error states, and small visual or copy tweaks, and when adapting UI for other languages, scripts, right-to-left layouts, or people new to technology. Guides hierarchy, typography, color, spacing, wording, interaction, responsive layout, localization, and accessibility so the result fits the product and its users, cuts visual and textual clutter, respects the existing design system and platform conventions, and is checked before it is called done. Not for backend-only work.
- `license: MIT`
- `metadata:` `version: "0.1.0"`

### 8.3 SKILL.md body: required content, in order (target ≤ 300 lines)

1. **Stance (≤ 15 lines).** The brief's philosophy cut down to the lines that steer decisions:
   - every element needs a reason;
   - context over trends;
   - the balance pairs;
   - craft beyond "it compiles";
   - honesty.
2. **Authority order** (§5.3).
3. **Size the task.** How much process each kind of task gets:
   - *Tweak* (one element, copy, spacing, a visual bug): read the surrounding UI and its tokens and components, change it within the system, check the affected states, and finish. No questions and no direction write-up.
   - *New screen or feature in an existing product:* discover the system, design within it, build, review.
   - *New product or redesign:* discover the context, write a short direction, build, review.
   - *Review or critique only:* run the review (references/review.md) and change nothing unless asked.
4. **Discover.**
   - Read before writing: screens near the change, tokens or theme, components, platform and framework, the tone of existing copy, and any design docs.
   - Establish who uses it, the job of this screen, where, when and on what device, which languages and scripts it uses, how familiar its users are with technology, and the constraints.
   - If an unknown would materially change the design and the user is reachable, ask one or two questions. Otherwise state assumptions in the final report.
   - Never invent user research.
5. **Direction (new screens and products only).** Write 3–8 lines before any code:
   - the screen's primary job and action;
   - what comes first, second and third in the hierarchy;
   - type, color strategy and density;
   - the platform conventions to follow;
   - the one place to spend boldness.

   Then run a self-check: "Would I write this same direction for any product in this category?" If yes, revise it toward this product's subject, audience and culture.
6. **Build: the core defaults.** Short, high-leverage rules under each heading below, each with its reason and exception. The detail lives in the references.
   - **Information economy, OpenSense's signature.**
     - For every text, label, badge, icon, card and divider, ask: "What does this tell the user that nothing else does?"
     - Name the common clutter patterns.
     - Keep a never-cut list: errors, prices and fees, consent, destructive consequences, state the user needs, and accessible names for icon-only controls.
   - **Hierarchy and typography.** One focal point. Build hierarchy with size, weight, space and position before reaching for boxes and color. Choose type that covers every language the product uses.
   - **Layout and space.** Use a spacing scale. Group by proximity before borders or cards. Add a container only when it means something.
   - **Color.** Start from the product's own palette. Assign semantic roles. Meet contrast requirements. Never use color as the only signal.
   - **Components and states.** Use the design system's and the platform's components before custom ones. Every interactive element has its states. Loading, empty and error states are designed, not left to defaults.
   - **Platforms.** Design each target on purpose, follow its conventions, and design for touch, pointer and keyboard separately.
   - **Accessibility floor.** A short list of rules that are never skipped.
   - **Words.**
     - Use the user's vocabulary.
     - Buttons say what happens.
     - One name for one thing throughout.
     - Errors say what happened and how to fix it.
     - No filler and no invented claims.
7. **Review before done.**
   - Look at the result if possible (browser, screenshot, simulator) at the sizes and platforms that matter.
   - Run the checklist, fix what it finds, and look again.
   - If you can't look, say so.
   - The final report states what was checked and how, and what wasn't.
8. **Common generated-UI tells.** A short list framed as "don't default to these unless the context calls for them":
   - grids of icon + title + text cards;
   - badges on everything;
   - a small label above every heading;
   - a headline and subheadline that repeat each other;
   - gradient text and decorative gradients;
   - the same radius and shadow on everything;
   - emoji used as icons;
   - a desktop layout shrunk to mobile;
   - everything centered;
   - stock marketing copy.
9. **References: when to read which.**

### 8.4 Reference files: scope

Each file opens with "Read this when…", stays around 300 lines or less, and gives each rule with its reason, its exception and before/after examples. Each covers where native platforms differ from web.

- **ux.md**
  - discovering context: the product, its users and their goals, device and environment;
  - information architecture and navigation, task flows, forms and input;
  - feedback and system status;
  - first-run, empty, loading, error and offline states;
  - destructive actions.
- **typography-and-words.md**
  - choosing type for the product's personality;
  - type scales for product UI versus marketing or brand pages;
  - line length, hierarchy, numbers and data;
  - microcopy;
  - information economy in depth, with before/after cuts;
  - naming and tone.
- **visual-and-interaction.md**
  - composition and focal point;
  - spacing systems and rhythm; grouping;
  - color strategy and semantic color; light and dark modes;
  - imagery and icons;
  - component design and states;
  - elevation (shadows, borders) used with meaning;
  - motion that explains change, and feedback timing;
  - finding identity in the product's subject and audience rather than in decoration;
  - when to be restrained and where to spend boldness.
- **platforms-and-accessibility.md**
  - **Web:** rethink the layout at each size instead of shrinking it, with breakpoints set by content.
  - **iOS and Android:**
    - navigation patterns and system components;
    - safe areas;
    - gestures and back behavior;
    - system text sizes and dynamic type;
    - haptics;
    - touch targets of at least 44 pt (iOS) and 48 dp (Android).
  - **Tablets.**
  - **Desktop apps:** windows, density, keyboard and pointer.
  - **Accessibility on each platform:**
    - contrast to WCAG 2.2 AA;
    - focus and keyboard use;
    - semantics and labels (ARIA, accessibility labels and traits, content descriptions);
    - VoiceOver and TalkBack;
    - reduced motion;
    - text scaling and zoom;
    - target sizes.
- **culture-and-language.md** (the depth area the owner chose, §8.5)
  - **Reading the context:** which languages and scripts the product serves, in which regions, how familiar its users are with technology, and what devices and connections they have.
  - **Non-Latin scripts:**
    - font coverage and fallbacks;
    - line height and size for scripts with tall or stacked marks, such as Khmer, Devanagari and Arabic;
    - line breaking in scripts written without spaces between words, such as Khmer, Lao and Burmese.
  - **Right-to-left:** mirrored layout and navigation, which icons flip and which don't, mixed-direction text, and numbers.
  - **Translation:** text that grows or shrinks when translated, and layouts that survive it.
  - **Local conventions:** dates, times, calendars, numbers, currency, names, addresses and phone numbers, plus what colors, symbols and imagery mean locally.
  - **People new to smartphones or with low digital literacy:** plain words, familiar icons with labels, fewer steps, forgiving input and clear confirmation.
  - **Real-world conditions:** low-end devices, slow or costly data, and connections that drop.
  - Examples center on Arabic (right-to-left) and Khmer (a non-Latin script written without spaces between words).
- **review.md**
  - The review loop and how to look:
    - which sizes, platforms and states to check;
    - what to do when you can't look.
  - The checklist, grouped by the seven capabilities in brief §5.
  - How to report: findings ranked by impact on users, each with what is wrong, where it is and the fix.
  - The honesty rule.
  - The format for critique-only requests.

### 8.5 Culture and language (owner confirmed 2026-11-10: more depth than native)

- Culture and language get their own reference file (culture-and-language.md, §8.4) and two eval tasks (§9.2).
- SKILL.md's Discover step asks which languages and scripts the product serves and how familiar its users are with technology.
- Its reference list sends the agent to culture-and-language.md whenever the product goes beyond one Latin-script language, or serves people new to technology.
- Examples and tests center on Arabic for right-to-left and Khmer for a non-Latin script. Arabic was Claude's pick, which the owner accepted, and the owner chose Khmer on 2026-11-10.

### 8.6 Web versus native depth (owner confirmed 2026-11-10)

- Principles are written to be platform-neutral.
- Examples default to web, since that is where most agent UI work happens.
- Every reference covers where iOS, Android and desktop differ.
- The eval includes a native task.

In v1, native apps get their platform conventions and one eval task. Deeper native coverage can come later.

---

## 9. Evaluation (Claude's call: brief §9 asks for human judgment, not self-grading)

### 9.1 Baseline first

Run every task *without* OpenSense and study the failures **before** writing the reference content. The observed failures decide what the references emphasize. Then compare runs with OpenSense against runs without it.

### 9.2 Tasks (one case folder each in `evals/`)

There are 10 realistic prompts, each specific enough that a designer could act on it. The mix follows the emphasis in §1.1 and the depth choice in §8.5:

- seven tasks start from something that already exists;
- three build something new;
- two of the ten work on language and culture.

The specific tasks are Claude's call.

**An existing product with a real design system** (the fixture app, §9.3):

1. Add a new screen or feature using the app's own tokens and components, including its empty and error states.
2. Improve an existing screen that is cluttered or unclear, without redesigning the app.
3. **Small tweak:** change one thing on an existing screen. This checks that OpenSense stays light and stays inside the system.
4. Make an existing desktop-first screen work well on a phone.
5. **Arabic:** make an existing screen work in Arabic. That means a right-to-left layout, mirrored navigation, icons that point the right way, and room for longer text.

**Generated UI as the starting point** (baseline outputs, §9.3):

6. Improve a generic generated dashboard so it feels designed for the people who use it.
7. Review a generic generated landing page, as a critique only.

**New builds:**

8. **Khmer:** a landing page in Khmer for a specific local business with a Khmer audience.
9. A multi-step mobile form for people new to smartphones, such as registering at a clinic.
10. A native mobile screen in React Native with Expo. *(Picked during planning, 2026-11-10. It needs no Xcode, Flutter or Android SDK, and Expo's web export is the viewable build that §9.5 allows. If the owner installs Xcode later, SwiftUI with the iOS simulator is a drop-in swap.)*

### 9.3 Starting points (Claude's call)

- **Fixture app.** A real open-source app with its own design system (tokens, components, existing screens), pinned to one commit.
  - Its license must allow publishing screenshots.
  - It must be small enough to run locally.
  - It needs at least one screen worth improving.

  *(Picked during planning, 2026-11-10.)* The fixture is **satnaing/shadcn-admin** (MIT), pinned at commit `e16c87f213a5ba5e45964e9b67c792105ec74d26`. It uses Vite, React and shadcn/ui, with theme tokens in `src/styles/theme.css`, light and dark themes, a right-to-left direction provider, and Dashboard, Tasks, Users and Settings screens.
- **Generated baselines.** Tasks 6 and 7 start from UI the agent generated without OpenSense for a dashboard prompt and a landing-page prompt. Both prompts are kept as seed cases in `evals/`. These are realistic generated UI by construction, so nothing needs to be built by hand.
- **The owner's own products** can be added as private test beds. Their results aren't published.

### 9.4 Trigger tests

- **Should load OpenSense:** UI tasks of every kind, including a tiny tweak.
- **Should not:** backend, CLI and data-pipeline tasks.
- Run them with and without other design skills installed, and record whether OpenSense loaded.

### 9.5 Running and viewing

- **Setup.** Same agent, same model, a fresh session for every run: one run without OpenSense and one with it. At minimum use Claude Code, and ideally Codex and Gemini CLI too.
- **Runner** *(changed during planning, 2026-11-10)*. Claude Code runs go through `claude plugin eval`, always with `--no-publish` and a pinned `--model`. To save cost, round 0's baseline outputs serve as the without-OpenSense side in rounds 1 and 2, which use the same prompts and model. The owner approves a total cost ceiling before the first paid run.
- **Screenshots.** Capture each result at the relevant sizes, at least one phone width and one desktop width for web.
- **Native tasks.** People view the result in a simulator or emulator, or through a web build (Flutter web, React Native through Expo web). Record how each result was viewed, and whether the agent claimed to have seen something it couldn't have.
- **Blind judging.**
  - Judges see each pair side by side, with left and right randomized, and don't know which is which.
  - Where possible, judges also get a build they can run, not just screenshots.
- **Judges.** The owner plus at least one person who didn't write the skill, because the brief asks for independent feedback. If no independent judge is available, release as a 0.x preview with the comparisons published for public feedback, and save the 1.0 label for after an independent judge has judged it. (Claude's call)
- **Accessibility numbers.** Judges don't eyeball accessibility. The builder measures what can be measured and gives judges the numbers: contrast ratios, target sizes, focus visibility and missing labels, using the platform's automated checks where they exist.
- **Two rounds at least.** Judge the first complete draft, revise, then judge the release candidate, so judges' feedback can still change the skill.
- **Language check.** For the Arabic and Khmer tasks (5 and 8), someone who reads the language checks the text and layout before judging: clipped marks, line breaks, mirroring and wording. Blind judging then goes ahead as usual. If nobody who reads one of these languages is available, swap it for a language a judge does read. The tasks stay the same. (Claude's call)

### 9.6 Rubric (rubric.md)

Each criterion is scored 1–5:

- feels intentionally designed rather than templated;
- hierarchy and typography;
- information economy, with counts of cards, badges, helper-text lines and explanatory paragraphs;
- fit to the product's context and audience;
- platform fit;
- accessibility basics: contrast, focus, labels, target sizes;
- states covered;
- honesty of the agent's final report.

Judges also give an overall preference.

Extra criteria by task type:

- **Tasks that change existing UI (1–6):**
  - It stays inside the system: it uses existing tokens and components and adds no one-off values.
  - It stays in scope: no unrelated changes, and a small diff for the tweak.
  - The builder reports the diff size and any new one-off values for each run.
- **The review task (7):** Before the runs, the builder writes a list of the input's known issues. Judges compare each critique with that list and score:
  - the important issues it found;
  - its false alarms;
  - whether each fix is actionable;
  - whether it is honest about what it didn't view.

### 9.7 Results and release bar

- Curated side-by-side comparisons go in `evals/results/` and feed the README, so it shows the difference rather than describing it. Raw runs don't need to be committed.
- **v1 ships when all of these hold:**
  - judges prefer OpenSense on at least 7 of the 10 tasks;
  - no task is judged clearly worse on accessibility;
  - the trigger tests pass;
  - `skills-ref validate` passes;
  - the installs in §6 are verified.

  (Claude's call on the numbers.)

---

## 10. Release (Claude's call)

- **Version.** 0.1.0, kept in sync across the SKILL.md `metadata` and every manifest. Syncing by hand is fine for v1.
- **README contents:**
  - what OpenSense is, using the brief's language;
  - before/after comparisons;
  - install steps per agent, with the "one install method per agent" rule;
  - how to use it: just ask the agent to build or improve UI, or name OpenSense explicitly;
  - what it deliberately doesn't do;
  - a link to the evals.
- **Publishing.** Publish at github.com/Thith-thith/opensense, which was public and empty on 2026-11-10.

## 11. Left to the builder

- The exact wording of SKILL.md, the references, the examples and the checklists.
- The exact eval prompts within the §9.2 coverage, and which native stack to use.
- The README's design and visuals.
- Keeping each reference near 300 lines. Tighten a long file rather than split it, so there are still six.
- The specifics of whether a Codex plugin can be installed directly (§6).
- Writing the known-issues list for the review task (§9.6). The fixture app was chosen during planning (§9.3).

## 12. What was checked while writing this

- **Agent Skills spec:** agentskills.io/specification, read 2026-11-10.
- **Multi-agent packaging:** obra/superpowers v7.0.0:
  - `.claude-plugin/`, `.codex-plugin/` and `gemini-extension.json`;
  - the README's install section;
  - `docs/porting-to-a-new-harness.md`.
- **skills CLI behavior:** its lock file and per-agent skill folders on a working install.
- **Prior art, read but not run on real tasks:**
  - impeccable (pbakaus/impeccable): its SKILL.md and product reference, with a keyword search of the rest;
  - frontend-design: both the anthropics/skills copy and the Claude plugin v1.1.1.

## 13. Open questions for the owner

The builder check raised these, and the owner answered them on 2026-11-10 by accepting Claude's picks:

1. **Emphasis:** improving existing products leads v1 (§1.1, §9.2).
2. **Depth:** culture and language get more depth than native platforms, and examples and tests center on Arabic and Khmer (§8.5, §8.6).

Nothing about the design itself is open. Releasing v1 needs these from the owner:

- **Hosting:** supplied on 2026-11-10 as github.com/Thith-thith/opensense.
- **An independent judge:** at least one judge who didn't write the skill (§9.5).
- **Language readers:** someone who reads Arabic and someone who reads Khmer, for the language check (§9.5). Otherwise swap to languages a judge reads.
- **Codex and Gemini CLI:** access for the install checks (§6), or permission to install them and sign in.
- **A way to view the native task:** an iOS simulator, an Android emulator, or a web build (§9.5).
