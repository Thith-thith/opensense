# Visual design and interaction

Read this when deciding layout, color, components, imagery, motion, or the visual identity of a new product.

## Composition and focal point

**Default:** Decide what the person must see first, and make it the largest or highest-contrast thing on the screen. Make sure nothing else competes. **Why:** a screen with three focal points has none. **Deviate when:** the screen is a neutral tool surface, like an editor or a table, where content is the focus and chrome must recede.

**Default:** Align things to a few shared edges. **Why:** shared edges make a layout feel calm and deliberate, and stray edges make it feel generated. **Deviate when:** you deliberately break the grid once, for emphasis.

Before: a dashboard of eight same-size tiles, each a big number with a trend arrow.
After: one primary number the owner checks daily, set large, followed by a short list of the items that need attention.

**Default:** Let each section's content choose its layout: opening hours as a table, a menu as a price list, a story as text beside a photo. Keep one spacing scale throughout. **Why:** when every section has the same shape, nothing stands out and the page reads as a template. **Deviate when:** the sections hold the same kind of thing, like product listings. Then they should match.

Before: a café page where the hours, the menu and the story are each a centered heading over three cards.
After: the hours as a table with today highlighted, the menu as a price list, and the story as two short paragraphs beside a photo of the counter.

**Default:** Lay out with the normal flow, flex and grid. Position something absolutely only when it floats over another thing by design, such as a badge on an avatar, a menu or a tooltip, and anchor it to that thing. Take stacking order from the system's layers (menu, sticky header, dialog, toast), not from ever-larger z-index numbers. **Why:** absolutely positioned things stay put when text grows, wraps or is translated, so they overlap at other widths and text sizes. **Deviate when:** the surface places items by their data, like a map, a diagram or a canvas editor.

Before: a "New" badge placed at a fixed distance from the card's corner, which lands on the title once the title is translated.
After: the badge sits in the title's row with a gap, and wraps with it.

## Space and grouping

**Default:** Use the project's spacing scale (otherwise a 4- or 8-based one). Put less space inside a group than between groups, with a clear step between them, about 1.5× or more, and more space above a heading than below it, so it sits with what it introduces. **Why:** proximity is the cheapest way to show what belongs together, and spacing values that barely differ look like mistakes. **Deviate when:** dense data views need tighter spacing. Keep the inside-versus-between ratio anyway.

**Default:** Group with space and alignment first, and add borders, dividers or cards only when space can't do it. **Why:** every box adds edges to parse. **Deviate when:** the container means something: an item you select, drag, open or repeat.

Before: settings fields each inside its own bordered card, separated by dividers.
After: settings fields in one column, with generous space between groups and one heading per group.

**Default:** In new layout code, space siblings with their parent's gap: `gap` in flex and grid on the web, the stack's spacing in SwiftUI, `Arrangement.spacedBy` in Compose. **Why:** one value sets the rhythm, nothing doubles up or trails after the last item, and wrapped rows keep their gaps. **Deviate when:** you're changing an existing screen. Keep the spacing method it already uses, margins included.

**Default:** On phones, shrink the page margins and the space between sections, and keep the space inside groups. Page margins of about 16 px are a common minimum. **Why:** outer space costs the most on a narrow screen, and the inner spacing still carries the grouping. **Deviate when:** the platform sets the margins, as iOS layout margins and safe areas do.

Before: a heading with 24 px above and 24 px below, settings 24 px apart in groups 16 px apart, and every element spaced by its own margin.
After: 32 px above the heading and 8 px below, 12 px between settings and 32 px between groups, and each list spaced by one gap on its parent.

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

**Default:** Theme both modes through the same tokens, never with hard-coded colors. Dark mode is a separate palette, not an inversion, and logos and illustrations need a version that reads on it. **Why:** a hard-coded light color shows up as a bright patch in dark mode. **Deviate when:** the product supports only one mode. Then don't add the other unasked.

**Default:** Measure contrast in both modes: 4.5:1 for body text, 3:1 for large text and UI components. Start where it usually fails: muted text, placeholders, input borders, focus rings and error text. **Why:** a gray that passes on white often fails on near-black, and the eye can't judge a ratio. **Deviate when:** never.

Before: a new component styled with a fixed hex background in an app that switches themes.
After: the same component using the surface and foreground tokens, so it changes with the theme.

## Imagery and icons

**Default:** Use the project's icon set, or the platform's symbols, in one style and one weight. Use an icon only where it replaces words or speeds up scanning a repeated set, like navigation or file types, and keep its word unless the platform's own apps show that icon alone. **Why:** mixed icon styles look assembled, decorative icons add noise, and few icons are understood without a word. **Deviate when:** the audience is new to technology or reads with difficulty. Then pair every icon with its word.

**Default:** Use real or realistic images of the actual subject. Never invent customers, logos or testimonials. **Why:** fake proof destroys trust. **Deviate when:** no assets exist. Then use honest placeholders, and say so.

Before: a row of emoji as feature icons, above a band of fake client logos.
After: three short feature statements with icons from the app's own set, and no logo band until real clients exist.

**Default:** Give every image its size or aspect ratio before it loads (width and height, or `aspect-ratio`), keep one aspect ratio across a set such as product cards, and crop with `object-fit: cover` and an `object-position` that keeps the subject in frame. Never stretch an image. When one is missing, show a neutral placeholder of the same size, with the item's name or initials. **Why:** images without reserved space push the page around as they arrive, and mixed, stretched or empty crops make a set look broken. **Deviate when:** the image is the content, such as a photo viewer, a document scan or an upload being checked. Show it whole.

**Default:** Use the project's image component or pipeline for sizes, formats and loading. Without one, serve each image near the size it's shown, in a modern format such as WebP or AVIF with `srcset` and `sizes`, lazy-load images below the first screen but never the first image people see, and use SVG for logos and simple illustrations. **Why:** an oversized photo costs time and data on a slow phone, and a lazy-loaded first image arrives last. **Deviate when:** a static page has only a few small images. Plain images with their sizes set are enough; don't add an image library or service unasked.

**Default:** Give each meaningful image a text alternative that says what it shows where it's used: "The café counter, with the espresso machine and pastry case", not "image" or a file name. Hide decorative images from screen readers, with `alt=""` on the web. **Why:** screen-reader users need the image's meaning, not its existence. **Deviate when:** the text right beside the image already says what it shows. Then treat the image as decorative.

**Default:** Put text on a photo only over a scrim or a calm, even area, and measure contrast against the part behind the text with the least contrast. **Why:** a photo's brightness varies, so text that reads on one part disappears on another, and a new photo can break it. **Deviate when:** the photo never changes and the text passes everywhere on it. Then no scrim is needed.

Before: product photos in three shapes, stretched to fit, lazy-loaded even in the first row, with "image" as their alt text, and white text straight on a bright hero photo.
After: square crops centered on each product, the first row loading at once, alt text such as "Green ceramic mug", and the hero text on a dark scrim that passes 4.5:1.

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

**Default:** Use motion only to explain change: where something came from, where it went, and what is loading. **Why:** purposeful motion orients people, and decorative motion delays them. **Deviate when:** a brand page has one deliberate entrance moment. Use one, not one per section.

**Default:** Take curves and durations from the project's motion tokens, then from the platform. Without either, match the curve to the direction: entering slows to a stop (ease-out, `cubic-bezier(0, 0, 0.2, 1)`), leaving speeds away (ease-in, `cubic-bezier(0.4, 0, 1, 1)`), and moving on screen does both (`cubic-bezier(0.4, 0, 0.2, 1)`). Match duration to distance: about 100 ms for a press, toggle or color change, and 200–300 ms for a menu, sheet or panel, with exits a little quicker than entrances. Only spinners and progress move at constant speed. **Why:** things in the world speed up and slow down, so constant speed looks mechanical, and long motion makes people wait. **Deviate when:** the brand moment above earns a slower entrance.

**Default:** Use a spring for motion that follows a gesture: a sheet dragged and let go, a card swiped away, a list pulled to refresh. It starts at the finger's speed and can be caught mid-motion. In tools, it settles without a visible bounce. **Why:** a spring carries the gesture's momentum and changes target without a jump, so the motion feels like part of the touch. **Deviate when:** nothing is dragged. A menu opening on a tap is fine with a curve, and on the web that avoids adding an animation library for one sheet.

**Default:** Never make people wait for motion. Input works during a transition, a reversed action turns back from where the motion is, and content doesn't wait for a staggered entrance. **Why:** motion that blocks input turns polish into delay. **Deviate when:** never.

**Default:** Animate transform and opacity, and name the properties you animate instead of `transition: all`. **Why:** animating width, height, position or margin recalculates the layout on every frame and stutters on low-end phones, and `all` animates changes nobody meant to, like a theme switch. **Deviate when:** a row or accordion expands. A short size change is fine there.

**Default:** Show a cheap, reversible change at once, inside the control: a toggle, a star or a reorder changes immediately, and changes back with a short message if saving fails. "Copy" becomes "Copied" for a moment, and a new or changed row briefly highlights where it landed. Reserve space for content that's loading, so nothing jumps under a finger. **Why:** feedback where the eye already is gets noticed without breaking attention, and an instant change makes the app feel fast. **Deviate when:** the action charges, sends or deletes. Then show progress and wait for the result.

**Default:** Respect the reduced-motion setting by replacing movement with a fade or an instant change, and keep the feedback itself. **Why:** motion can cause discomfort, and the change still has to be seen. **Deviate when:** never.

Before: every section fades and slides up as it scrolls into view, and the dashboard's numbers count up from zero on each load.
After: no scroll animation, the numbers appear at once, and a newly added item briefly highlights where it landed.

Before: a settings toggle that waits a second for the server before it moves, and a sheet that slides in at constant speed over 600 ms.
After: the toggle flips at once and flips back with "Couldn't save. Try again." if the request fails, and the sheet slows as it arrives, in about 250 ms, and follows the finger when dragged down.

## Identity without decoration

**Default:** Find identity in the subject, the place and the audience: its materials, vernacular and colors. Choose one place to be bold, and keep everything around it quiet. **Why:** distinctive comes from fit, not from effects, and boldness everywhere cancels itself out. **Deviate when:** the product is a tool that should disappear into the task. There, identity is restraint and consistency.

Before: a café page with a gradient hero, glassmorphism cards and floating blobs.
After: a large photo of the actual café counter, the menu set like the chalkboard at the till, and the address where a passer-by would look for it.

**Default:** For a new product or a brand page, hide the logo and the name. If the screen could belong to any product in its category, take the next change from the product's content, place or people. Don't swap one fashionable default for another, such as a purple gradient for the cream background and oversized serif that many redesigns now reach for. **Why:** identity that lives only in the logo isn't identity, and a newer template is still a template. **Deviate when:** the product is a tool inside an existing design system. There, consistency with the system is the identity.

Before: a purple-gradient hero redone as a cream background with a large italic serif, over the same three feature cards.
After: the three cards replaced by what customers come to check: today's hours, the menu and the address.

## Native differences

- **iOS:**
  - Use system materials and colors, so the app follows light, dark and increased contrast.
  - Use SF Symbols where the app has no icon set.
  - Prefer SwiftUI's built-in springs, such as `.smooth` and `.snappy`, to custom curves.
  - Give meaningful images an accessibility label, and make decorative ones `Image(decorative:)`.
- **Android:**
  - Use Material color roles and dynamic color where the app supports it.
  - Show elevation with tonal surfaces as well as shadows.
  - Prefer Compose's spring animations, and Material's motion tokens where the app has them, to custom curves.
  - Set a `contentDescription` on meaningful images, and `null` on decorative ones.
- **Both:** respect the platform's motion and haptics. A light haptic confirms an important action, not every tap.

Before: an iOS screen with web-style drop shadows on every row.
After: a grouped list using the system background and separator colors.
