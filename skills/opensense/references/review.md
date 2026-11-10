# Review and refinement

Read this when reviewing or critiquing a UI, and before calling your own UI work done.

## The review loop

**Default:**
1. Look at the real result.
2. Run the checklist below against what you see.
3. Fix the most important problems.
4. Look again, until a pass finds nothing important.

**Why:** code that compiles can still be confusing, cluttered or inaccessible, and you only see that by looking. **Deviate when:** the task is critique only. Then report the problems and change nothing.

Before: "Implemented the settings page." with no look at the result.
After: "I opened the settings page at 390 px and 1440 px in light and dark, and fixed a clipped label and a low-contrast hint. Then I looked again."

## How to look

**Default:** Check the result:
- at the sizes and platforms that matter (for web, at least a phone width and a desktop width);
- in light and dark when the app supports both;
- right-to-left when the app supports it;
- with long and empty content;
- in loading and error states.

Tab through with the keyboard. **Why:** most problems hide at the edges: a narrow screen, a long name, an empty list. **Deviate when:** a tweak touched one element. Then look at that element in its states, plus anything near it.

**Default:** If you can't render the UI (no browser, no screenshots, no simulator), say so plainly. Review the code against the checklist instead. **Why:** describing how something "looks" without seeing it misleads the user. **Deviate when:** never.

Before: "The layout looks clean and balanced on mobile."
After: "I couldn't render the page. From the code: the table has no small-screen layout, so it will likely scroll sideways at 390 px."

## The checklist

Check each group against what you see. Skip what doesn't apply.

**Design Context Intelligence**
- Does it follow the authority order? The user's request first, then the project's design system, then platform conventions.
- Does new UI copy the structure of its sibling screens?
- Does it use the project's tokens and components, with no new one-off colors or sizes?

**Human-Centered UX**
- Is the person, their job and their situation clear from the design?
- Is it suited to their language, script and familiarity with technology?
- Is nothing invented: no fake features, metrics, testimonials or research?

**UX Architecture**
- Can people tell where they are, what they can do and what happens next?
- Are the flows short, the labels visible, the input types right, and errors kept next to their fields?
- Are the empty, loading, error and offline states designed?
- Are destructive actions named, with their consequence stated?

**Visual Excellence**
- Is there one focal point, with hierarchy by size, weight and space?
- Is spacing on a scale, with grouping shown by proximity?
- Does color have roles, with one accent?
- Are shadows and borders only where they mean layering?
- Does the identity come from the subject, not from decoration?

**Information Economy**
- Does every text, label, badge, icon, card and divider tell the user something nothing else does?
- Has every repeated title, label or indicator been cut?
- Is what stays at its shortest clear phrase, with icons only where they replace words or speed up scanning?
- Does every icon shown alone meet every condition for showing an icon alone?
- Are errors, prices, fees, consent, warnings and needed status still present?

**Cross-Platform Experience**
- Is the phone layout designed on purpose?
- Are platform navigation and controls respected?
- Are targets at least 24×24 CSS px on web, 44 pt on iOS and 48 dp on Android?
- Does it work at large text sizes?

**Design QA & Refinement**
- Is contrast enough in every mode?
- Is focus visible, with every control named?
- Is reduced motion respected?
- Did you look at the real result, or say that you couldn't?

Before: "The design feels cluttered."
After: "Settings › Billing: all three cards repeat their title in a description. Remove the descriptions."

## Reporting findings

**Default:** List findings in order of their impact on users, most important first. Each finding says:
- **what:** the problem, in plain words;
- **where:** the screen and element, or the file and line;
- **fix:** the concrete change.

End every report with `Checked:` and `Not checked:` lines. **Why:** a ranked, specific list can be acted on, while a vague verdict can't, and the last two lines keep the report honest. **Deviate when:** the user asked for a single verdict. Give it, then the top three findings.

Before: "Overall, the page could be improved in terms of visual hierarchy and spacing."
After:
1. Checkout, total row: the delivery fee is hidden in a tooltip. Show it in the total. (Users pay it, and should see it before paying.)
2. Checkout, card fields: the error appears only as a red border. Add the message "Card number is missing a digit" under the field.
3. Header: the small all-caps label above the title repeats the page name. Remove it.

Checked: 390 px and 1440 px in light mode, keyboard focus order.
Not checked: dark mode, screen readers.

## Critique without changes

**Default:** When asked only to review, change no files. Report the ranked findings, what is working and worth keeping, and the `Checked:` and `Not checked:` lines. **Why:** the person asked for judgment, not edits, and changing files takes the decision away from them. **Deviate when:** the user asks you to apply the fixes. Then apply them, and review the result.

Before: a review request answered with a rewritten page and a short note.
After: a ranked list of findings, two things to keep (a clear price table and a strong photo of the shop), and the `Checked:` and `Not checked:` lines. No files changed.
