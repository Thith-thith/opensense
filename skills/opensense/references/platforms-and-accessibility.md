# Platforms and accessibility

Read this when targeting phones, tablets, desktop apps or native iOS and Android, and before calling any UI accessible.

## Web: responsive by rethinking

**Default:** Design the phone layout on purpose: reorder by priority, collapse secondary content, and turn wide tables into lists or cards that show the key columns. **Why:** desktop columns squeezed side by side, or simply stacked, bury the main task. **Deviate when:** the content is a single readable column already.

**Default:** Set breakpoints where the content breaks, not at device names. Let text and components flex between them. **Why:** devices change, and content limits don't. **Deviate when:** the design system defines breakpoints. Use those.

**Default:** Keep the main action reachable on phones, at the end of the content or in a sticky bar that doesn't cover anything. **Why:** thumbs rest at the bottom of the screen. **Deviate when:** a sticky bar would hide content the user needs while acting.

**Default:** When the on-screen keyboard opens, keep the field being typed in and its submit button in view, below any fixed header and above the keyboard. **Why:** a hidden field means typing blind, and a hidden button means closing the keyboard to finish. **Deviate when:** never.

Before: a seven-column tasks table that scrolls sideways on a phone.
After: each task as a row showing the title, status and due date, with the rest one tap away.

Before: a sticky "Send" bar left behind the keyboard, and a fixed header covering the field that just took focus.
After: the bar sits above the keyboard, and the focused field scrolls into view below the header.

## iOS

**Default:**
- Follow iOS conventions: a tab bar for top-level sections, navigation stacks with back at the top left, and sheets for focused tasks.
- Use system controls (switches, pickers, segmented controls).
- Respect safe areas, and keep the focused field and its action above the keyboard (SwiftUI does this by default; in UIKit, use the keyboard layout guide).

**Why:** people know the platform before they know your app. **Deviate when:** the brand demands a custom control. Then match the system control's behavior and accessibility exactly.

**Default:** Touch targets of at least 44 pt, text styles that support Dynamic Type, and the system light, dark and increased-contrast settings. **Why:** they are the platform's accessibility baseline. **Deviate when:** never go below them.

Before: a hamburger menu and an Android-style floating action button in an iOS app.
After: a tab bar for the four main sections, and an add button in the navigation bar.

## Android

**Default:**
- Follow Material navigation: a navigation bar or rail for top-level sections, and a top app bar.
- System back must always work.
- Use bottom sheets for secondary actions and snackbars for undo.
- Keep the focused field and its action above the keyboard by handling the keyboard (IME) insets, such as with `imePadding()` in Compose.

**Why:** Android users rely on system back and on familiar patterns. **Deviate when:** the app has its own documented design system. Then follow it, but keep system back.

**Default:** Touch targets of at least 48 dp, text sized in sp, and support for the system font scale and dark theme. **Why:** they keep the app usable at large text sizes and in all lighting. **Deviate when:** never go below them.

Before: a custom back arrow that ignores the system back gesture.
After: system back and the top app bar arrow lead to the same place.

## Tablets and desktop apps

**Default:** On tablets and wide windows, use the extra width for structure, such as list and detail side by side, not for bigger versions of phone controls. **Why:** stretched phone layouts waste space and lengthen eye travel. **Deviate when:** the task is a single focused flow. Keep it centered at a readable width.

**Default:** Desktop apps support the keyboard fully, including shortcuts for frequent actions and a visible focus. They support pointer hover and right-click as extras, plus window resizing and the platform's menu conventions. **Why:** desktop users work fast with keyboards, in windows of any size. **Deviate when:** never. Every action needs a keyboard path.

Before: a tablet app showing a phone-width list in the middle of a large blank screen.
After: the list on the left and the selected item's detail on the right.

## Accessibility on every platform

**Default:** Meet WCAG 2.2 AA on web, and the platform guidelines on native. The minimums are:

- **Contrast:** 4.5:1 for body text, 3:1 for large text and for UI components and focus indicators.
- **Focus:** keyboard focus is always visible, and moves in reading order. Keep interactive and reading content in the same order on screen as in the code: CSS `order`, `row-reverse` or absolute positioning alone moves what people see, not what focus and screen readers follow. Moving an image above its text on phones is fine, and right-to-left mirroring through `dir` isn't reordering.
- **Names and labels:** every control has an accessible name, and every input has a programmatic label.
  - On the web, use real elements (button, a, label, headings, landmarks), with ARIA only where no element exists.
  - On iOS, set accessibility labels and traits.
  - On Android, set content descriptions, and check that controls are reachable with TalkBack.
- **Screen readers:** the screen makes sense read aloud in order by VoiceOver and TalkBack, meaningful images have a text alternative that says what they show, and decorative images are hidden from them.
- **Status:** important changes, such as an error, a "Saved" message or a finished load, are announced: through a live region on the web (`role="status"`, or `role="alert"` for errors), an accessibility announcement on iOS, and a live region on Android.
- **Targets:** at least 24×24 CSS px on web, 44 pt on iOS and 48 dp on Android, with more for primary actions. Separate controls, such as toolbar icons or a destructive action beside another, get about 8 px, pt or dp between them; list rows, tab bars and segmented controls can sit flush.
- **Motion:** respect reduced motion, and never flash content.
- **Text size:** content works at 200% zoom on web and at the largest system text sizes on native.
- **Color:** never the only signal. Pair it with text, an icon or a pattern.

**Why:** these are what decide whether people can use the product at all. They are not polish. **Deviate when:** never. Where a request conflicts with them, do what was asked as accessibly as possible, and say what remains.

Before: an icon-only trash button with no label, and a "Required" state shown only by a red border.
After: the button has the accessible name "Delete invoice INV-0042", and the field shows a "Required" message tied to the input.

## Checking accessibility honestly

**Default:** Use the checks you actually have:
- an automated audit on web;
- the platform's accessibility inspector on native;
- tabbing through the page with the keyboard;
- a pass with the screen reader if one is available.

Report which checks ran. **Why:** automated tools catch only part of the problems, and claiming more than you checked misleads. **Deviate when:** you can't run anything. Then say that, and list what still needs checking.

Before: "The page is fully accessible."
After: "The automated audit shows 0 failures. I checked keyboard focus by tabbing through the form. I haven't checked VoiceOver or TalkBack."
