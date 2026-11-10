# Visual design and interaction

Read this when deciding layout, color, components, imagery, motion, or the visual identity of a new product.

## Composition and focal point

**Default:** Decide what the person must see first, and make it the largest or highest-contrast thing on the screen. Make sure nothing else competes. **Why:** a screen with three focal points has none. **Deviate when:** the screen is a neutral tool surface, like an editor or a table, where content is the focus and chrome must recede.

**Default:** Align things to a few shared edges. **Why:** shared edges make a layout feel calm and deliberate, and stray edges make it feel generated. **Deviate when:** you deliberately break the grid once, for emphasis.

Before: a dashboard of eight same-size tiles, each a big number with a trend arrow.
After: one primary number the owner checks daily, set large, followed by a short list of the items that need attention.

## Space and grouping

**Default:** Use the project's spacing scale (otherwise a 4- or 8-based one). Put less space inside a group than between groups. **Why:** proximity is the cheapest way to show what belongs together. **Deviate when:** dense data views need tighter spacing. Keep the inside-versus-between ratio anyway.

**Default:** Group with space and alignment first, and add borders, dividers or cards only when space can't do it. **Why:** every box adds edges to parse. **Deviate when:** the container means something: an item you select, drag, open or repeat.

Before: settings fields each inside its own bordered card, separated by dividers.
After: settings fields in one column, with generous space between groups and one heading per group.

## Color strategy

**Default:**
- Start from the product's palette and tokens.
- Give each color one role: background, surface, text, primary action, focus, success, warning, danger.
- Use neutral surfaces, with one accent for primary actions and the current selection.

**Why:** color is strongest when it means something, and a palette used everywhere means nothing. **Deviate when:** a brand page uses color as identity, such as a bold background for a hero section. Commit to it there, and keep app screens calmer.

**Default:** Pick a palette from the subject, the place and the audience, not from a category reflex. **Why:** "finance is navy", "health is teal" and "AI is purple" are training-data defaults, not decisions. **Deviate when:** the audience depends on a convention, like red for loss in a Western trading app. Even then, check the audience's own convention.

Before: a purple-to-blue gradient on every button of a hardware store's inventory app.
After: one solid accent taken from the store's signage for primary actions, with gray surfaces.

## Light and dark

**Default:** Theme both modes through the same tokens, never with hard-coded colors. Dark mode is a separate palette, not an inversion. **Why:** a hard-coded light color shows up as a bright patch in dark mode. **Deviate when:** the product supports only one mode. Then don't add the other unasked.

**Default:** Check contrast in both modes: 4.5:1 for body text, 3:1 for large text and UI components. **Why:** a gray that passes on white often fails on near-black. **Deviate when:** never.

Before: a new component styled with a fixed hex background in an app that switches themes.
After: the same component using the surface and foreground tokens, so it changes with the theme.

## Imagery and icons

**Default:** Use the project's icon set, or the platform's symbols, in one style and one weight. Use an icon only where it replaces words or speeds up scanning a repeated set, like navigation or file types, and keep its word unless the platform's own apps show that icon alone. **Why:** mixed icon styles look assembled, decorative icons add noise, and few icons are understood without a word. **Deviate when:** the audience is new to technology or reads with difficulty. Then pair every icon with its word.

**Default:** Use real or realistic images of the actual subject. Never invent customers, logos or testimonials. **Why:** fake proof destroys trust. **Deviate when:** no assets exist. Then use honest placeholders, and say so.

Before: a row of emoji as feature icons, above a band of fake client logos.
After: three short feature statements with icons from the app's own set, and no logo band until real clients exist.

## Components and states

**Default:** Reuse the project's components, then the platform's, before building new ones, and use them the way sibling screens do. **Why:** a familiar control needs no learning. **Deviate when:** no existing component fits. Then build one in the system's style, and use it consistently.

**Default:** Every interactive element shows its default, hover (pointer only), pressed, focus, disabled and loading states. Fields also show an error state. **Why:** missing states make an interface feel broken or unresponsive. **Deviate when:** a state truly can't occur, like a disabled state for an always-available link.

**Default:** Use badges for states that differ between items or change over time. **Why:** a badge that always says the same thing is decoration. **Deviate when:** a single status is critical and easy to miss, like "Overdue".

Before: every plan, user and invoice carries a colored badge, including "Active" on the only plan.
After: badges only on invoices whose state varies (Paid, Due, Overdue), with text that makes sense without color.

## Elevation and borders

**Default:** Use shadows and borders to show layering and separation, such as a menu over content or a selected item. Never put them on everything. **Why:** the same shadow on every card flattens the page into noise. **Deviate when:** the design system defines elevation levels. Use exactly those.

Before: every card with the same radius and soft gray shadow, with nested cards inside.
After: flat sections separated by space, and a shadow only on the floating menu.

## Motion and feedback

**Default:** Use motion to explain change: where something came from, where it went, and what is loading. Keep durations short, about 150–250 ms for UI. **Why:** purposeful motion orients people, and decorative motion delays them. **Deviate when:** a brand page has one deliberate entrance moment. Use one, not one per section.

**Default:** Respect the reduced-motion setting by replacing movement with a fade or an instant change. **Why:** motion can cause discomfort. **Deviate when:** never.

Before: every section fades and slides up as it scrolls into view.
After: no scroll animation, and the newly added item briefly highlights where it landed.

## Identity without decoration

**Default:** Find identity in the subject, the place and the audience: its materials, vernacular and colors. Choose one place to be bold, and keep everything around it quiet. **Why:** distinctive comes from fit, not from effects, and boldness everywhere cancels itself out. **Deviate when:** the product is a tool that should disappear into the task. There, identity is restraint and consistency.

Before: a café page with a gradient hero, glassmorphism cards and floating blobs.
After: a large photo of the actual café counter, the menu set like the chalkboard at the till, and the address where a passer-by would look for it.

## Native differences

- **iOS:**
  - Use system materials and colors, so the app follows light, dark and increased contrast.
  - Use SF Symbols where the app has no icon set.
- **Android:**
  - Use Material color roles and dynamic color where the app supports it.
  - Show elevation with tonal surfaces as well as shadows.
- **Both:** respect the platform's motion and haptics. A light haptic confirms an important action, not every tap.

Before: an iOS screen with web-style drop shadows on every row.
After: a grouped list using the system background and separator colors.
