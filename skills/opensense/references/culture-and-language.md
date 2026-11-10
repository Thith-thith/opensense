# Culture and language

Read this when the product uses more than one language, a non-Latin script or right-to-left text, serves a specific region, or serves people new to technology.

## Reading the context

**Default:** Before designing, find out:
- which languages and scripts the product serves, and in which regions;
- how familiar the users are with technology;
- what devices and connections they have.

Look in the request, the locale files and the existing UI. **Why:** a layout that works in English on a new laptop can fail in Khmer on a low-end phone with slow, costly data. **Deviate when:** the product is single-language and the context is known. Then follow it.

Before: an English-only layout with fixed-width labels, built for a product that also ships in Arabic and Khmer.
After: start-aligned layout using logical properties, labels that wrap, and fonts that cover all three scripts.

## Non-Latin scripts: Khmer

**Default:** Set `lang="km"` on Khmer content, and let the platform break lines. Keep any zero-width spaces already in the text. **Why:** Khmer is written without spaces between words. The browser and OS use the language, and those invisible marks, to find where words end. **Deviate when:** never use `word-break: break-all` on Khmer, because it splits a word inside a stacked cluster.

**Default:** Give Khmer more room than Latin text: body text at about 17–18 px, and line height of about 1.8–2.0. Never clip the line box with fixed heights or hidden overflow. **Why:** Khmer stacks subscript consonants below the base letter, and places vowels above, below and before it. Tight line boxes cut those marks off, and small sizes blur them. **Deviate when:** a large single-line heading can be a little tighter. Check it with the deepest stacks.

**Default:** Choose a typeface with real Khmer coverage, such as Noto Sans Khmer or Kantumruy Pro. Keep decorative display styles like Moul for short titles only. **Why:** a Latin-only font falls back to a mismatched system face, and display styles are hard to read at small sizes. **Deviate when:** the brand specifies a Khmer typeface. Use it.

Before: Khmer body text in a Latin web font, at 14 px and line height 1.2, inside a fixed-height button.
After: a Khmer typeface at 17 px and line height 1.9, inside a button that grows with its text.

## Right-to-left: Arabic

**Default:** Set `dir="rtl"` and the language (for example `lang="ar"`) on the document, and lay out with logical properties (`margin-inline-start`, `padding-inline-end`, `text-align: start`) rather than left and right. **Why:** the whole layout mirrors, so navigation, alignment and the flow of steps run right to left. **Deviate when:** content is inherently left to right, such as code, phone numbers or a media timeline.

**Default:** Mirror icons that show direction or progress (back and forward arrows, chevrons, steppers). Don't mirror icons that depict objects, logos, checkmarks or media playback. **Why:** direction is relative to reading order, and objects aren't. **Deviate when:** a local convention differs. Follow the platform's mirroring rules.

**Default:** Isolate mixed-direction text, such as user names, numbers with units, emails and URLs, with `<bdi>` or `dir="auto"`, or isolation in native text APIs. **Why:** without isolation, punctuation and numbers jump to the wrong side. **Deviate when:** the string is guaranteed to be in one direction.

**Default:** Never letter-space Arabic, and don't use all-caps styles for emphasis. Use weight or size instead. Arabic often needs a slightly larger size than Latin text to read at the same size. **Why:** Arabic letters join, so spacing breaks the joins, and the script has no capitals. **Deviate when:** the typeface is designed with matched sizes. Trust its metrics.

**Default:** Format numbers, dates and currency with the user's locale. Some Arabic-speaking regions use Eastern Arabic digits (٠١٢٣), and others use Western digits. **Why:** the wrong digits look foreign or ambiguous. **Deviate when:** the product's locale settings already decide. Use them.

Before: a settings page with `margin-left` everywhere, a back chevron pointing left in Arabic, and a letter-spaced uppercase label.
After: logical margins, a back chevron pointing right, and the label at normal spacing in a heavier weight.

## Translation and text length

**Default:** Design for text that grows. Labels can grow 30–40% from English, and very short labels can double or more, while Chinese or Japanese may shrink. **Why:** fixed widths truncate translations and hide meaning. **Deviate when:** you control every string and language. Still test with the longest one.

**Default:** Never put text in images, never build sentences by joining fragments, and allow for plural and gender rules. **Why:** word order and grammar differ between languages, so concatenated strings break. **Deviate when:** never.

Before: a button sized to fit "Save", with "Speichern" cut off.
After: the button fits its label in every shipped language, and the label can wrap.

## Local conventions

**Default:** Use the locale's conventions for:
- date order, the first day of the week, 12- or 24-hour time and the calendar (Khmer dates often use the Buddhist Era alongside the Common Era, so label which one you show);
- decimal and thousands separators, currency position and units, and which digits to use (Khmer ០–៩ or Western 0–9);
- currency (in Cambodia people pay in both riel and US dollars, so show the one they pay with, or both);
- name order and structure (not everyone has a "first" and a "last" name);
- address formats (not every country has states or postcodes);
- phone formats (accept spaces and a leading +).

**Why:** forms that force a foreign format reject real people. **Deviate when:** the data feeds a system that needs one format. Then convert behind the scenes, and keep the input forgiving.

**Default:** Check what colors, symbols, gestures and images mean to this audience. Never let color carry meaning alone. **Why:** a meaning that is obvious in one culture is wrong or empty in another. **Deviate when:** the audience is documented. Follow what the product team knows. Never assume it.

Before: a required "First name" and "Last name", a US state dropdown and a date field fixed to MM/DD/YYYY.
After: one "Full name" field, an address that adapts to the selected country, and dates in the user's locale.

## People new to smartphones

**Default:**
- **Words:** use plain words. Avoid jargon such as "OTP", "sync" or "upload".
- **Icons:** pair every icon with a text label.
- **Steps:** one task per screen.
- **Targets:** large tap targets.
- **Visibility:** visible buttons instead of hidden gestures (no swipe-only or long-press-only actions).
- **Input:** forgiving input that accepts spaces, dashes and different formats.
- **Confirmation:** a clear message that something was saved or sent.
- **Going back:** back without losing what was typed.

**Why:** many people meet a smartphone app as their first computer, and every unexplained convention is a wall. **Deviate when:** the audience is expert. Even then, plain words cost nothing.

Before: "Enter OTP" and a field that rejects "012 345 678" because of the spaces.
After: "Enter the 6-digit code we sent to 012 345 678", and a field that ignores spaces.

## Real-world conditions

**Default:** Assume a low-end device on a slow, costly or dropping connection unless you know otherwise:
- keep pages light;
- compress and size images;
- never autoplay video;
- save drafts locally;
- retry quietly;
- say clearly what works offline.

**Why:** heavy pages cost real money and time for many users, and a lost form costs their trust. **Deviate when:** the product is internal and runs on known fast hardware.

Before: a 6 MB hero video that autoplays on a clinic's sign-up page.
After: a light page with one compressed photo, and a form that keeps its answers if the connection drops.

## Native differences

- **iOS:**
  - Use leading and trailing constraints, or leading and trailing alignment, so layouts mirror in right-to-left languages automatically.
  - Format with the user's Locale.
- **Android:**
  - Use start and end attributes, never left and right.
  - Enable right-to-left support in the manifest.
  - Format with the user's locale.
- **Both:** test with the system language set to Arabic, and to a long language such as German, before calling the UI ready.

Before: an Android layout using `marginLeft`, which stays on the left in Arabic.
After: `marginStart`, which moves to the right automatically.
