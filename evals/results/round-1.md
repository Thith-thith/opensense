# Round 1: v0.1.0 preview

Run 2026-11-10 on `claude-sonnet-5-5`, through `claude plugin eval`. Every run gets its own fresh config and home folders, so the only difference between the two sides is OpenSense. Each task ran once per side.

**Limits, stated plainly:**
- **One run per side**, so the results show tendencies, not statistics.
- **No independent judges yet.** The "better" column is the author's read of the screenshots, made while building the skill.
- **One task was rerun after revising.** The t02 loss led to a skill change, and t02 was then rerun once.
- **Arabic and Khmer haven't been checked** by native readers yet.
- **No shell in the sandbox.** Shell commands were blocked inside the eval sandbox for both sides, so neither agent could build or preview its own work. Both said so in their final reports.

## Which side is better

| Task | Better | What made the difference |
|---|---|---|
| t01 Settings › Billing | **OpenSense** | It followed the sibling settings pages: no cards, no description repeating each title, and badges only where the status varies ("Paid", "Payment failed"). The baseline used three cards with a filler description each, plus an "Active" badge. |
| t02 Improve the dashboard | Baseline in round 1, a tie after the fix | In round 1, OpenSense decluttered but kept generic SaaS metrics, while the baseline rebuilt the page around the owner's morning. The skill then learned that "improve" means rethinking the screen around its user's job. One rerun produced a job-first dashboard that matches the baseline's. |
| t03 Users status tweak | Tie | Same change, same small diff. |
| t04 Tasks page on a phone | **OpenSense** | It turned the table into stacked rows that read on a phone. The baseline left the desktop table squeezed, with its columns cut off. |
| t05 Profile in Arabic | **OpenSense**, narrowly | Both translated the page and flipped it right-to-left. OpenSense isolated mixed-direction text ("I own a computer." keeps its period, and the username stays left-to-right) and localized "@mention". |
| t08 Khmer landing page | **OpenSense** | An opening-hours table with Monday marked closed and today highlighted, the address and hours in Khmer digits, Telegram ordering steps, and no invented facts. It still put a small label above the hero title, and the skill was reworded afterwards to catch that in any script. The baseline used a generic coffee-cup illustration and numbered cards, and invented a claim about the farms. |
| t09 Clinic sign-up form | Tie | OpenSense dropped the field label that repeated the question, and the header bar. The baseline kept a more useful hint ("as on your ID or insurance card"). |
| t10 Native habit tracker | **OpenSense** | It shows the check-off loop, with no emoji and no all-caps date label. The baseline showed only an empty card with a 🔥. |

**Tally:** in round 1, OpenSense was better on 5 tasks, 2 were ties and the baseline was better on 1. After the fix, t02 is a tie, from one rerun. t06 and t07 (improve and review generated pages) haven't run yet.

## Accessibility (Lighthouse, phone)

| Task | With OpenSense | Without |
|---|---|---|
| t01 | 0.90 | 0.90 |
| t02 | 0.99 | 0.95 |
| t03 | 0.93 | 0.93 |
| t04 | 0.93 | 0.93 |
| t05 | 0.91 | 0.91 |
| t08 | 1.00 | 1.00 |
| t09 | 1.00 | 1.00 |
| t10 | 0.92 | 0.93 |

Equal scores on t01, t03, t04 and t05 come from failures in the test app's own shell. OpenSense added no `button-name` or `link-name` failures. On t10, each side has a different failure: `aria-required-attr` with OpenSense, color contrast without.

## Graders (supporting evidence only)

- **Honest final report:** OpenSense passed in 8 of 8 tasks, the baseline in 6 of 8.
- **Other graders:** the uses-system, keeps-critical-info and no-invented-facts graders are cheap AI judges. Their results were mixed and noisy, so no decision rests on them.

## Trigger tests

These check whether the skill loads on its own, with 3 runs per prompt.

- **First run:** 7 UI prompts each loaded it 3/3, except two small tweaks, "Make the Save button on the profile form blue" and "Add an empty state to the orders list", which loaded it 0/3.
- **After rewording the description** to name one-line tweaks: every UI prompt loaded it 3/3, and the 4 backend prompts (Postgres, CSV CLI, flaky test, S3 pipeline) never did. That is 33 of 33.
- **How often agents opened the reference files:** the Arabic task opened culture-and-language; the Khmer task didn't. The clinic form opened it too, along with ux and review. The other tasks worked from SKILL.md alone, so SKILL.md now carries a short pre-finish check.

## Cost

$8.85 in total:

| Part | Cost |
|---|---|
| 8 judged tasks, both sides | $4.47 |
| Khmer t08, both sides | $0.35 |
| Trigger tests, two passes | $3.65 |
| t02 rerun | $0.29 |
| Earlier cost-measurement runs | $0.59 |

## Images

These are side-by-side screenshots, without OpenSense on the left and with it on the right. The demo account in the test app's sidebar is covered.

- [Settings › Billing](img/t01-settings-billing.jpg)
- [Dashboard, round 1](img/t02-dashboard-round1.jpg)
- [Dashboard after the fix](img/t02-dashboard-after-fix.jpg)
- [Tasks on a phone](img/t04-tasks-phone.jpg)
- [Profile in Arabic](img/t05-profile-arabic.jpg)
- [Khmer landing page](img/t08-khmer-landing.jpg)
- [Native habit tracker](img/t10-native-habits.jpg)
