# Judging rubric

Human blind judging decides the release. Grader scores from `claude plugin eval` are supporting evidence only.

## Blind A/B judging

- Judges see each pair side by side, with left and right randomized, and do not know which side used OpenSense.
- Where possible, give judges a build they can run, not only screenshots.
- Judges are the owner plus at least one person who did not write the skill.
- Judges do not eyeball accessibility. The builder gives them the measured numbers: contrast ratios, target sizes, focus visibility, missing labels and the Lighthouse accessibility score.
- For native cases, record how each result was viewed (simulator, web build) and whether the agent claimed to have seen something it could not have.

## Language check

Before judging t05 (Arabic) and t08 (Khmer), someone who reads the language checks the text and layout: clipped marks, line breaks, mirroring and wording. Blind judging then goes ahead as usual. If nobody who reads a language is available, swap it for one a judge does read. The task stays the same.

## Criteria (score each 1 to 5, per side)

| Column | Criterion |
|---|---|
| intentional | Feels intentionally designed rather than templated |
| hierarchy_type | Hierarchy and typography |
| info_economy | Information economy (count cards, badges, helper-text lines, explanatory paragraphs) |
| context_fit | Fit to the product's context and audience |
| platform_fit | Platform fit |
| a11y | Accessibility basics: contrast, focus, labels, target sizes |
| states | States covered (empty, error, loading, where relevant) |
| honesty | Honesty of the agent's final report |

Then give an overall preference (`preferred_side`: A, B or tie).

## Extra criteria by task

**Tasks that change existing UI (t01 to t06).**

- `system_fit`: stays inside the system. It uses existing tokens and components and adds no one-off values.
- `scope`: stays in scope. No unrelated changes; a small diff for the tweak (t03).
- The builder reports the diff size and any new one-off values for each run.

**The review task (t07).** Before the runs, the builder writes a list of the input's known issues. Judges compare each critique with that list and score:

- the important issues it found;
- its false alarms;
- whether each fix is actionable;
- whether it is honest about what it did not view.

Leave `system_fit` and `scope` empty for t07 and for tasks that start from nothing (t08 to t10).

## Clearly worse on accessibility

A task counts as clearly worse on accessibility, which blocks release, when either holds:

- the OpenSense side has more failing Lighthouse accessibility audits than the baseline;
- the judges' mean `a11y` score for the OpenSense side is at least 1 lower than the baseline's.

## Score sheet

One row per judge, per task, per side.

```
task,judge,side,intentional,hierarchy_type,info_economy,context_fit,platform_fit,a11y,states,honesty,system_fit,scope,preferred_side,notes
```
