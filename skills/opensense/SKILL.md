---
name: opensense
description: Design judgment for building and improving user interfaces on any platform (web, iOS, Android, desktop). Use it before writing or editing any UI code or UI copy, even a one-line tweak such as a button color, a label, spacing, or adding an empty state, and whenever you create or review pages, screens, components, forms, dashboards, landing pages, onboarding or error states, or adapt UI for other languages, scripts, right-to-left layouts, or people new to technology. Guides hierarchy, typography, color, spacing, wording, interaction, responsive layout, localization, and accessibility so the result fits the product and its users, cuts visual and textual clutter, respects the existing design system and platform conventions, and is checked before it is called done. Not for backend-only work.
license: MIT
metadata:
  version: "0.2.0"
---

# OpenSense

Design every screen so people understand it and act at a glance. Text is optional for routine tasks, and detail is one tap away. It must look like a senior human designer made it for this product, not an AI template.

Text drops away only as far as the ladder under Words and flow allows, and accessible names always stay.

## Stance

- Every element, word, color and interaction needs a reason. If you can't name the reason, cut it.
- Context decides, not trends. A clinic form for first-time smartphone users and a trading dashboard should look nothing alike, and both should look designed.
- Balance, not minimalism: minimal without losing function, simple without dropping what people need, distinctive without chasing trends, clean without feeling sterile.
- Working code is not the finish line. Hierarchy, wording, states and accessibility are part of done.
- Be honest. Say what you checked and what you couldn't. Never invent features, metrics, testimonials, brand claims or user research.

## Authority order

When sources disagree, the higher one wins:

1. The user's explicit instructions for the current task.
2. The project's existing design system, brand and conventions.
3. Platform conventions for web, iOS, Android and desktop operating systems.
4. OpenSense defaults.

If the user asks for gradient text, build it well; one short note is fine, a lecture is not. If the app wraps every settings section in a card, a new settings section gets a card too. The design system decides how things look, not what a screen should show.

## Size the task

| Task | What to do |
|---|---|
| Tweak: one element, a label, spacing, a visual bug | Read the screen around it and its tokens and components. Change it inside the system, and check the states it affects. No questions, no direction. |
| New screen or feature in an existing product | Read the sibling screens and the system, build the way the siblings are built, review. |
| Improve an existing screen | Name who uses it and the one job it does for them, and write a short direction. Keep the system, but rethink what the screen shows and in what order for that job, then cut what doesn't serve it. |
| New product or redesign | Discover the context, write a short direction, build, review. |
| Review or critique only | Follow references/review.md. Change nothing unless asked. |

## Discover

Read before you write: the sibling screens, whose structure new UI copies before it invents one; the tokens and components; any design docs; how the app handles dark mode, right-to-left and languages; and the tone of its copy. Then establish who uses the screen, the one job it does for them, their device and situation, the languages and scripts, and how familiar they are with technology. If an unknown would change the design and the user can be asked, ask one or two short questions. Otherwise assume, and say so in your report.

## Direction

For new products, new screens and screens you're asked to improve. Before code, write 3–8 lines: the primary job and action; what comes first, second and third; type, color and density; the platform conventions you'll follow; and the one place you'll be bold, with everything around it quiet. Then ask: "Would I write this same direction for any product in this category?" If yes, it's a template. Revise it toward this product's subject, audience, place and culture.

## Build

Page by page, then component by component.

### Words and flow

If 4 words work, never use 10. If an icon, a layout or a default says it better, use that. Remove until it breaks, then put one thing back. Keep only the words that prevent mistakes or explain consequences. In Khmer and other scripts without spaces, count meaning, not words.

Before adding any text, label, badge, icon, card or divider, ask: What does this tell the user that nothing else does? If nothing, leave it out: no description that restates its title, no small label above a heading, no badge that never changes, no intro explaining the obvious, no card around something that isn't a separate object.

1. **One purpose, one obvious primary action.** On a screen for browsing or comparing, make the purpose clear without pushing one choice.
2. **Purpose and next step are clear in 3 seconds.** Fix confusion with layout, not paragraphs.
3. **A label that explains a control means the control failed.** Fix the control: a visible "Delete", not "Swipe left to delete". Label any icon that could be misread. Input fields keep their visible label.
4. **Detail is one tap away, but cost, conditions and consequences are always visible before someone commits.** What people need before they commit stays in view next to the button that commits: the total with every fee, renewal or cancellation terms, and anything that can't be undone. Never leave those only in a tooltip, a collapsed section or a later step.
5. **One obvious path.** Decide sensible defaults, keep them visible and changeable, and never assume consent. Never pre-select consent, a paid extra or a choice that's hard to undo.
6. **Show, don't tell:** real prices, photos, status and progress, when you have them; never invent them. Never use color alone to carry meaning.
7. **Buttons are specific verbs:** "Book now", "Pay $12". The result echoes the verb: "Booked".
8. **Errors sit beside the field,** say what to do next, and keep the user's input.

Text becomes optional step by step. Take each label, heading, button, status, toast and empty-state message only as far down this ladder as its meaning survives:

1. **A phrase.** Only the words that carry the meaning: "Renews 3 March", not "Your plan will renew automatically on 3 March". Buttons keep their verb.
2. **Icon and word.** A well-known icon from the project's set or the platform's symbols, never emoji, replaces a label or a verb.
3. **Icon alone,** only if all hold: the platform's own apps show that icon alone for that action, and on web both iOS's and Android's do (search, close, back, add, more); it's frequent or on every row; it has an accessible name and, with a pointer, a tooltip; it isn't the only way to a rare or important action; and a destructive one ends in Undo or a confirmation.

People new to technology stop at icon and word. Khmer needs room: no text below about 14 px, and line height of at least about 1.5 wherever a box can clip it, or the marks above and below get cut. Before shortening Khmer copy, read references/culture-and-language.md.

Never cut, however tidy it would look: errors, prices and fees, consent text, warnings about destructive actions, state the user needs to act on, and accessible names for icon-only controls.

Details: references/typography-and-words.md and references/ux.md.

### Visual design

Build the identity from the product, its content, its brand and its users' culture. Question every pattern in the tells list below, and use one only with a clear reason.

- **Color:** a small palette with neutrals, one accent for the primary action, and semantic colors, all from the project's tokens, in dark mode too. Measure contrast in every theme: at least 4.5:1 for body text, and 3:1 for large text and UI components.
- **Type:** chosen on purpose, with few sizes and weights, covering every script the product uses. Type and space make the hierarchy, not boxes. Check Khmer rendering, wrapping and clipping.
- **Layout:** a real grid, related things grouped tightly, thumb-sized targets: at least 44 pt on iOS, 48 dp on Android and 24×24 CSS px on web. Nothing sticky covers content, and the keyboard never hides the field or its button. At phone width, reorder and collapse; don't squeeze the desktop layout.
- **Platform:** follow its navigation and controls: tab bars and swipe-back on iOS, system back on Android, keyboard and pointer on desktop and web. Respect safe areas, the system text size and the light or dark setting.
- **Restraint:** remove any border, shadow or animation that adds no meaning. Motion only explains a change, briefly, and never makes people wait.
- **Content:** design with real content. Never invent testimonials or numbers, and mark placeholders as placeholders.
- **The test:** for a new product or a brand page, the product is recognizable with the logo hidden.

Details: references/visual-and-interaction.md and references/platforms-and-accessibility.md.

### States

Design loading, empty, error, success and disabled states, with a reason shown for disabled. Destructive actions get undo or a confirmation. Prevent double submits. Every interactive element also has its hover, pressed and focus states.

### Accessibility floor

Never skipped, whatever the style:

- the contrast minimums above, and visible keyboard focus, moving in the order things appear on screen;
- an accessible name for every control, a programmatic label for every input, and a text alternative for every meaningful image;
- real structure: headings, buttons, links, lists and landmarks, or the platform's accessibility roles;
- reduced motion respected, and important status changes announced to screen readers;
- text usable at 200% zoom or the largest system text size;
- touch targets at the sizes above.

## Review before done

1. **Look at the result if you can,** in a browser, screenshots or a simulator: at a phone width and a desktop width, in light and dark, right-to-left if the app supports it, and with real text in every script it ships. Review on a small phone with large text, as a tired first-time user on a slow connection. Check the keyboard and focus.
2. **Run the checklist** in references/review.md against what you see, not what you meant to build. Fix what it finds, and look again.
3. **If you can't look, say so.** Don't describe how it "looks".
4. **At minimum, confirm** that the main job comes first, nothing from the tells list survived as a reflex, nothing on the never-cut list was cut or hidden, the phone width is designed rather than squeezed, the states exist, and the accessibility floor holds.
5. **A design review is not proof of usability,** so name the key flows to test with real users.

Report, per page, briefly, grouping decisions that repeat:

- the primary action;
- what you fixed, removed or moved one tap away, and why;
- your color and type decisions, with reasons;
- the generic patterns you replaced;
- the states checked;
- open questions and assumptions;
- `Checked:` what you checked and how, and `Not checked:` what you couldn't.

For a tweak, report what you changed and any assumptions, then the `Checked:` and `Not checked:` lines.

## Common generated-UI tells

Question these, and use one only with a clear reason. Swapping one for the next fashionable default is still a template.

- purple and other decorative gradients, glowing blobs and gradient text;
- glass effects, heavy shadows, big radii everywhere;
- sparkle or emoji icons, and "AI" badges;
- a centered hero over three identical cards, or any grid of identical icon, title and text cards;
- generic 3D or stock art;
- every section the same;
- a card around every section, badges on everything, and a description under every title;
- a small label above the heading, in any script, often all-caps or joined with a middle dot (·);
- a big number, a small label and a trend arrow as every dashboard tile;
- sections that fade in as you scroll, and numbers that count up;
- everything centered;
- stock marketing copy ("Unlock the power of", "Seamless", "Supercharge");
- a desktop layout squeezed onto a phone.

## References

Read only what the task needs:

- Read references/ux.md for flows, navigation and forms, including multi-step forms; tables, filters, bulk actions and dashboards; defaults, disabled and submitting states; and first-run, empty, loading, error or offline states.
- Read references/typography-and-words.md for type and hierarchy, and before writing, cutting or shortening any UI copy.
- Read references/visual-and-interaction.md for layout, spacing, position, color, images, icons, components, motion and micro-interactions, and the visual identity of a new product.
- Read references/platforms-and-accessibility.md when targeting phones, tablets, desktop apps or native iOS and Android, and before calling any UI accessible.
- Read references/culture-and-language.md when the product uses more than one language, a non-Latin script such as Khmer or Arabic, or right-to-left text, or serves people new to technology.
- Read references/review.md when reviewing or critiquing UI, and before calling your own work done.
