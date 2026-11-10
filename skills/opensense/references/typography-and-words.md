# Typography and words

Read this when choosing type, setting hierarchy, or writing, cutting or naming anything users read.

## Choosing type

**Default:** Use the project's typefaces. In app UI with no typeface set, use the platform's system font. **Why:** system fonts render well, load instantly, match the platform and cover many scripts. **Deviate when:** a brand surface like a landing page or a marketing site needs a voice. Then pick one display face that fits the subject, and a plain text face.

**Default:** Choose type from the subject and audience, not from what is fashionable. **Why:** a children's reading app, a law firm and a coffee roaster should not share a typeface. **Deviate when:** the product must disappear into a task, like a dense admin tool. Familiar is right there.

**Default:** At most two families. **Why:** each family adds weight and noise, and hierarchy comes from size and weight anyway. **Deviate when:** a third face carries data (a monospace for code or IDs).

Before: a bakery's order page in the same geometric sans as every SaaS dashboard.
After: a warm serif for the shop name and headings, the system font for the order details.

## Scale and hierarchy

**Default:** Build hierarchy with size, weight and space before color or boxes. Use few steps: three or four sizes per screen is usually enough. **Why:** a clear scale lets people scan, while ten slightly different sizes look accidental. **Deviate when:** a dense data view needs very small type. Keep it at the platform minimum and above.

**Default:** In app UI, steps of about 1.125 to 1.25×, and body text at 16 px or the platform default. On marketing pages, larger jumps between display and body. **Why:** app screens hold many levels at once, while pages tell one story at a time. **Deviate when:** the project already has a scale. Use it.

**Default:** One heading level per idea. Don't bold whole paragraphs, and don't emphasize a single word in every heading. **Why:** when everything is emphasized, nothing is. **Deviate when:** a word is the actual point, like a price or a deadline.

Before: a title, a subtitle, a section label, a card title and a card description, five levels for one setting.
After: a section heading and the setting's label. The description is gone, because the label said it.

## Reading comfort

**Default:** Lines of about 45–75 characters for paragraphs, and line height about 1.4–1.6 for body text, tighter for large headings. **Why:** long lines lose the reader's place, and tight lines blur. **Deviate when:** the script has tall or stacked marks and needs more line height, or the content is a table or data rather than prose.

**Default:** Left-align text, or start-align it in right-to-left languages. **Why:** a straight left edge is easiest to scan, and justified text leaves gaps on narrow screens. **Deviate when:** a short, standalone heading or empty-state message reads better centered.

Before: a paragraph running the full width of a 1440 px screen.
After: the same paragraph capped at a readable measure, with the extra width given to whitespace or a side panel.

## Numbers and data

**Default:** Use tabular figures and right-alignment for numbers in columns, and the user's locale for separators, currency and dates. **Why:** aligned digits compare at a glance, and locale formats prevent misreading 1,000 as 1.000. **Deviate when:** a single number stands alone as a headline.

**Default:** Show the precision the decision needs. **Why:** "$1,234.5678" is noise when the decision is "is revenue up?". **Deviate when:** the user reconciles exact amounts, as in accounting.

Before: "Revenue: 12345.678 USD (+0.0213)"
After: "$12,346, up 2.1% from last week"

## Microcopy

**Default:** Write in the user's words and name things by what they do for the user. **Why:** "Notifications" is understood, "Webhook config" isn't. **Deviate when:** the users are specialists whose own words are the technical terms.

**Default:** A button says what will happen, and the result echoes it. **Why:** "Submit" and "OK" make people guess. **Deviate when:** a platform's standard dialog expects its own standard labels.

**Default:** An error says what happened and how to fix it, in plain words, without blame or apology. **Why:** people need the next step, not a mood. **Deviate when:** the cause is unknown. Then say so, and offer the safest next step.

Before: "Error 422: Unprocessable entity."
After: "This phone number is missing a digit. Check it and try again."

## Information economy in depth

**Default:** Before keeping any piece of text, ask what it tells the user that nothing else on the screen does. **Why:** generated screens repeat titles in descriptions, labels in placeholders and headings in intros, and repetition hides what matters. **Deviate when:** the text prevents a likely, costly mistake. Keep it, and make it specific.

Before: a card titled "Current plan", described as "The plan your account is on."
After: the heading "Plan", then "Pro, renews 3 March".

Before: the label "Email" above an input whose placeholder reads "Enter your email", with the helper text "We'll use this email to contact you."
After: the label "Email", a blank input, and helper text only if the reason matters, such as "Receipts go here."

Before: a heading reading "Welcome to your dashboard! Here you can see an overview of your account activity."
After: no intro. The first chart answers the question the owner opened the page for.

Before: the step indicators "Step 1 of 5", a progress bar and five dots, all at once.
After: "Step 1 of 5", or one progress bar, not both.

What to keep even when it feels long: prices and fees, legal and consent text, error messages, warnings about destructive actions, and status the user must act on.

## Naming and tone

**Default:** One name for one thing across the product. Keep the same verb from button to confirmation to history. **Why:** a new word reads as a new thing. **Deviate when:** never inside one product. Rename everywhere at once, or not at all.

**Default:** Plain verbs, sentence case and the tone of the product. Friendly can still be brief. **Why:** title case and exclamation marks feel like marketing inside a tool. **Deviate when:** the brand voice is documented. Follow it.

Before: a "Publish" button, a "Your post went live!" toast and a "Posted" label in history.
After: a "Publish" button, a "Published" toast and a "Published" label in history.

## Native differences

- **iOS:**
  - Support Dynamic Type, so text grows with the user's setting.
  - Use the text styles (Body, Headline, Caption) instead of fixed sizes.
  - Never truncate the only copy of important text.
- **Android:**
  - Size text in sp so it follows the system font scale.
  - Prefer the Material type roles when the app has no scale of its own.
- **Both:** buttons and labels must still fit at the largest text sizes. Let them wrap, don't clip them.

Before: a fixed-height button whose label is cut off at large text sizes.
After: the button grows in height, and the label wraps onto two lines.
