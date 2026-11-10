---
name: opensense
description: Design judgment for building and improving user interfaces on any platform (web, iOS, Android, desktop). Use it before writing or editing any UI code or UI copy, even a one-line tweak such as a button color, a label, spacing, or adding an empty state, and whenever you create or review pages, screens, components, forms, dashboards, landing pages, onboarding or error states, or adapt UI for other languages, scripts, right-to-left layouts, or people new to technology. Guides hierarchy, typography, color, spacing, wording, interaction, responsive layout, localization, and accessibility so the result fits the product and its users, cuts visual and textual clutter, respects the existing design system and platform conventions, and is checked before it is called done. Not for backend-only work.
license: MIT
metadata:
  version: "0.2.0"
---

# OpenSense

Design judgment for building and changing interfaces. It gives you no house style. It changes how you decide: understand the product and its people first, give every element a reason to exist, fit the context instead of a trend, and look at the result before calling it done.

## Stance

- Every element, word, color and interaction needs a reason. If you can't name the reason, cut it.
- Context decides, not trends. A clinic form for first-time smartphone users and a trading dashboard should look nothing alike, and both should look designed.
- Balance, not minimalism: minimal without losing function, simple without dropping what people need, distinctive without chasing trends, clean without feeling sterile.
- Working code is not the finish line. Hierarchy, wording, states and accessibility are part of done.
- Be honest. Say what you looked at and what you didn't. Never invent features, metrics, testimonials, brand claims or user research.

## Authority order

When sources disagree, the higher one wins:

1. The user's explicit instructions for the current task.
2. The project's existing design system, brand and conventions.
3. Platform conventions for web, iOS, Android and desktop operating systems.
4. OpenSense defaults.

If the user asks for gradient text, build it well; one short note is fine, a lecture is not. If the app wraps every settings section in a card, a new settings section gets a card too. OpenSense defaults only fill the gaps the first three leave open.

The design system decides how things look and behave, not what a screen should show. When you're asked to improve a screen, its content and priorities are yours to rethink.

## Size the task

Match the process to the change. Most UI work is a change inside an existing product.

| Task | What to do |
|---|---|
| Tweak: one element, a label, spacing, a visual bug | Read the surrounding screen and its tokens and components. Change it inside the system. Check the states it affects. No questions, no direction write-up. |
| New screen or feature in an existing product | Discover the system, build the way sibling screens are built, review. |
| Improve an existing screen | Name who uses it and the one job it does for them, then write a short direction. Keep the system, but rethink what the screen shows and in what order for that job, then cut what doesn't serve it. |
| New product or redesign | Discover the context, write a short direction, build, review. |
| Review or critique only | Follow references/review.md. Change nothing unless asked. |

## Discover

Read before you write:

- **Sibling screens.** Look at the screens next to the one you're changing: their layout pattern, headings, spacing and how they group content. New UI copies its siblings' structure before it invents one.
- **The system.** Tokens or theme (color, type scale, spacing, radius) and the component library. Use them. Don't add one-off values.
- **Design docs,** if the project has them: a design system doc, brand guide, product or design notes.
- **Platform support.** The platform and framework, and how the app handles dark mode, right-to-left and localization.
- **Copy.** The tone of the existing copy.

Then establish, from the code, the request and what the user told you:

- who uses this, and the one job this screen does for them;
- where and on what: device, connection, lighting, in a hurry or at a desk;
- which languages and scripts it must support, and how familiar its users are with technology.

If an unknown would change the design and the user can be asked, ask one or two short questions. Otherwise choose a sensible assumption and state it in your final report. Never invent user research.

## Direction

For new products, new screens, and screens you're asked to improve or redesign. Skip it for tweaks. Before writing code, write 3–8 lines:

- the screen's primary job and its primary action;
- what comes first, second and third in the hierarchy;
- type, color strategy and density;
- the platform conventions you will follow;
- the one place you will spend boldness. Everything around it stays quiet.

Then ask: "Would I write this same direction for any product in this category?" If yes, it's a template. Revise it toward this product's subject, audience, place and culture.

## Build

Each rule gives the default, why, and when to deviate.

### Information economy

This is the signature move. Before adding any text, label, badge, icon, card, divider or tooltip, ask: What does this tell the user that nothing else does? If the answer is nothing, leave it out.

Cut by default:

- a description under a title that restates the title ("Payment method" over "The card we charge each cycle");
- a field label that repeats the question above it (make the question the label);
- a small label above the heading, in any script, often all-caps or joined with a middle dot (·);
- a badge that can only ever show one value (a badge earns its place when the state differs between items or over time);
- a second indicator of the same thing, such as a progress bar plus "Step 1 of 5" plus dots;
- an intro paragraph explaining what the screen obviously is;
- a card around content that isn't a separate, repeated or movable object.

Then shorten what stays. Take each label, heading, button, navigation item, badge, status, toast, tooltip and empty-state message only as far down this ladder as its meaning survives:

1. **A phrase.** Only the words that carry the meaning, often 1–3 in English: "Renews 3 March", not "Your plan will renew automatically on 3 March". Buttons keep their verb ("Save changes", not "Changes").
2. **Icon and word.** A well-known icon replaces a label or a verb: a phone icon before a shown phone number, a download icon before "PDF". Input fields keep their visible text label. Use the project's icons or the platform's symbols, never emoji. With neither, stay with words.
3. **Icon alone,** only if all hold: the platform's own apps show that icon alone for that action, and on web both iOS's and Android's do (search, close, back, add, more); it's frequent or on every row; it has an accessible name and, with a pointer, a tooltip; it isn't the only way to a rare or important action; and a destructive one ends in Undo or a confirmation.

Short still reads as plain words: "3 orders to ship", not "Order fulfillment status" or a lone "3" over a tiny label. The accessible name contains the visible words. People new to technology stop at icon and word.

In Khmer and other scripts with marks above and below the letters, short labels need room too: line height of at least about 1.5 wherever a box hides overflow at the text's own height, as `truncate` does, or the marks get cut, and no Khmer text below about 14 px. Before shortening Khmer copy, read references/culture-and-language.md.

Never cut, however tidy it would look: errors, prices and fees, consent text, warnings about destructive actions, state the user needs to act on, and accessible names for icon-only controls. When you remove a visible label, keep the accessible name.

Deviate when the audience needs more guidance than usual, for example people new to technology or a rare, high-stakes flow. Keep helper text that prevents mistakes, and make it specific.

### Hierarchy and typography

- **One focal point.** Default to one focal point per screen. Build hierarchy with size, weight, space and position before boxes, borders and color. Why: containers and color compete with content; position and scale don't.
- **Type scale.** Default to the project's type scale. Without one, use small steps for app UI (about 1.2×) and larger jumps for marketing pages, body text at 16 px or the platform's default size, and lines of about 45–75 characters for reading. Deviate when a script needs more room.
- **Typefaces.** Use one or two. In app UI, the system font is a valid and often the best choice. The typeface must cover every script the product uses.

Details: references/typography-and-words.md.

### Layout and space

- **Spacing scale.** Use the project's spacing scale, or a 4- or 8-based one. Vary space to show grouping: tighter inside a group, looser between groups.
- **Group by space first.** Group with proximity and alignment. Add a border or container only when space fails, or when the container means something: a selectable item, a movable panel, a repeated object.
- **Alignment.** Left-align text in app UI (start-align in right-to-left). Center only short, standalone content.
- **Each width on purpose.** At phone width, reorder and collapse; don't just stack the desktop columns.

### Color

- **Palette.** Start from the product's palette and tokens. Give each color a role (background, surface, text, primary action, semantic states) and keep to it.
- **Accent.** Default to neutral surfaces and one accent for primary actions and the current selection. Spend more color only where it carries meaning or identity.
- **Meaning.** Never make color the only signal. Pair it with text, an icon or position.
- **Contrast.** At least 4.5:1 for body text, and 3:1 for large text and UI components.
- **Dark mode.** Theme dark mode through the same tokens. Never hard-code light-only colors in a themed app.

### Components and states

- **Reuse.** Use the project's components, then the platform's, before building custom ones, and use them the way sibling screens do.
- **Interaction states.** Every interactive element has its states: default, hover (pointer only), pressed, focus, disabled, loading, and error where it applies.
- **Data states.** Design the empty, loading and error states of every data view:
  - **Empty:** say what will appear and offer the next action.
  - **Errors:** say what happened and how to fix it.
- **Modals.** Use a modal only for a decision that must interrupt. Prefer inline editing and inline confirmation.

Details: references/visual-and-interaction.md and references/ux.md.

### Platforms

- **Navigation and controls.** Follow the platform's conventions: tab bars and the native back gesture on iOS, Material navigation and system back on Android, keyboard and pointer conventions on desktop and web.
- **Touch targets.** At least 44 pt on iOS, 48 dp on Android, and 24×24 CSS px on web, with larger primary actions on phones.
- **System settings.** Respect safe areas, the system text size, and the system light or dark setting.

Details: references/platforms-and-accessibility.md.

### Accessibility floor

Never skipped, whatever the style:

- The contrast minimums above, and visible keyboard focus on every interactive element.
- Every control has an accessible name, and every input has a programmatic label.
- Real structure: headings, buttons, links, lists and landmarks, or the platform's accessibility roles.
- Reduced motion is respected.
- Text stays usable at 200% zoom or the largest system text size.
- Touch targets meet the sizes above.

### Words

- **The user's words.** Use the user's vocabulary, not the system's: "Notifications", not "Webhook config".
- **Buttons say what happens.** Write "Save changes" or "Delete 3 invoices", and echo it in the result: "Changes saved".
- **One name per thing,** everywhere in the product.
- **Errors** say what happened and how to fix it, without blame or apology.
- **No filler.** No marketing adjectives inside app UI, and no invented claims, numbers or testimonials. If real content is missing, use realistic placeholders and say they are placeholders.

Details: references/typography-and-words.md.

## Review before done

1. **Look at the result if you can.** Open it in a browser, take screenshots or run a simulator:
   - at the sizes and platforms that matter (for web, at least a phone width and a desktop width);
   - in light and dark if the app supports both;
   - right-to-left if it supports that;
   - with real text in every script it ships, such as Khmer, not placeholder English.
2. **Run the checklist** in references/review.md against what you see, not what you meant to build. Fix what it finds and look again.
3. **If you can't look, say so.** Don't describe how it "looks".
4. **At minimum, confirm:**
   - the screen's main job comes first;
   - nothing from the tells list below survived as a reflex;
   - nothing important was cut: errors, prices and fees, consent, warnings, needed state, accessible names;
   - the phone width is designed, not squeezed;
   - the empty, loading and error states exist;
   - contrast, focus and accessible names meet the floor.
5. **End with a short report:** what you changed, what you checked and how, what you couldn't check, and any assumptions you made.

## Common generated-UI tells

Don't default to these. Each is fine when the context calls for it; none is fine as a reflex.

- every section wrapped in a card, with the same radius and shadow on everything;
- grids of identical icon, title and text cards;
- a small label above the heading, in any script, often all-caps or joined with a middle dot (·);
- a description under every title that restates it;
- badges on everything ("New", "Active", "Beta") whether or not the state varies;
- a big number, a small label and a trend arrow as the default dashboard tile;
- gradient text and decorative gradients or glows;
- emoji used as icons;
- everything centered;
- stock marketing copy ("Unlock the power of", "Seamless", "Supercharge");
- a desktop layout squeezed onto a phone.

## References

Read only what the task needs:

- Read references/ux.md when designing a flow, navigation, a form, or first-run, empty, loading, error or offline states.
- Read references/typography-and-words.md when choosing type, setting hierarchy, or writing or cutting UI copy.
- Read references/visual-and-interaction.md when deciding layout, color, components, motion, or the visual identity of a new product.
- Read references/platforms-and-accessibility.md when targeting phones, tablets, desktop apps or native iOS and Android, and before calling any UI accessible.
- Read references/culture-and-language.md when the product uses more than one language, a non-Latin script such as Khmer or Arabic, or right-to-left text, or serves people new to technology.
- Read references/review.md when reviewing or critiquing UI, and before calling your own work done.
