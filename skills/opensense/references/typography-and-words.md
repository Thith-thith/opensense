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

**Default:** A button says what will happen, and the result echoes it. A button that charges money shows the amount: "Pay $12". **Why:** "Submit" and "OK" make people guess. **Deviate when:** a platform's standard dialog expects its own standard labels.

**Default:** An error says what happened and how to fix it, in plain words, without blame or apology. **Why:** people need the next step, not a mood. **Deviate when:** the cause is unknown. Then say so, and offer the safest next step.

Before: "Error 422: Unprocessable entity."
After: "This phone number is missing a digit. Check it and try again."

**Default:** Where you have the fact, show it instead of a claim about it: the date, the price, the count. **Why:** a fact can be checked and acted on, while a claim asks to be trusted. **Deviate when:** you don't have the fact. Never invent a number to fill the gap.

Before: "Fast delivery" and "Affordable plans".
After: "Arrives Thu 19 Nov" and "$12 a month".

## Information economy in depth

**Default:** Before keeping any piece of text, ask what it tells the user that nothing else on the screen does. **Why:** generated screens repeat titles in descriptions, labels in placeholders and headings in intros, and repetition hides what matters. **Deviate when:** the text prevents a likely, costly mistake. Keep it, and make it specific.

**Default:** Cut these by default:
- a description under a title that restates the title ("Payment method" over "The card we charge each cycle");
- a field label that repeats the question above it (make the question the label);
- a small label above the heading, in any script, often all-caps or joined with a middle dot (·);
- a badge that can only ever show one value (a badge earns its place when the state differs between items or over time);
- a second indicator of the same thing, such as a progress bar plus "Step 1 of 5" plus dots;
- an intro paragraph explaining what the screen obviously is;
- a card around content that isn't a separate, repeated or movable object;
- text that explains how to work a control, such as "Swipe left to delete" or "Tap the pencil to edit" (fix the control instead: a visible "Delete", a pencil button that says "Edit");
- a claim where you have the fact to show instead ("Arrives Thu 19 Nov", not "Fast delivery").

**Why:** each one repeats, decorates or explains what the screen should already show. **Deviate when:** the audience needs more guidance than usual, for example people new to technology or a rare, high-stakes flow. Keep helper text that prevents mistakes, and make it specific.

Before: a card titled "Current plan", described as "The plan your account is on."
After: the heading "Plan", then "Pro, renews 3 March".

Before: the label "Email" above an input whose placeholder reads "Enter your email", with the helper text "We'll use this email to contact you."
After: the label "Email", a blank input, and helper text only if the reason matters, such as "Receipts go here."

Before: a heading reading "Welcome to your dashboard! Here you can see an overview of your account activity."
After: no intro. The first chart answers the question the owner opened the page for.

Before: the step indicators "Step 1 of 5", a progress bar and five dots, all at once.
After: "Step 1 of 5", or one progress bar, not both.

What to keep even when it feels long: prices and fees, legal and consent text, error messages, warnings about destructive actions, and status the user must act on.

## Fewer words, then icons

**Default:** After cutting, shorten what stays. Take labels, headings, buttons, navigation items, badges, status, toasts, tooltips and empty-state messages to the shortest phrase that keeps the meaning. For an action, that's the verb and the object. **Why:** people scan interface text rather than read it, and every extra word delays the one that matters. **Deviate when:** the extra words carry what people need to act. "Enter the 6-digit code we sent to 012 345 678" beats "Enter OTP".

**Default:** Judge length by meaning, never by a word count. **Why:** Khmer, Thai, Chinese and Japanese don't put spaces between words, and a translation can be much longer or shorter than English, so a fixed word limit means nothing across languages. **Deviate when:** never.

**Default:** Let a well-known icon replace a label or a verb, and keep the word that carries the rest: a phone icon before a shown phone number, a download icon before "PDF", a comment icon before "12". Input fields keep their visible text label. Take icons from the project's set or the platform's symbols. **Why:** a known icon is recognized before a word is read. **Deviate when:** the project has neither. Stay with words; don't add an icon library unasked, and never use emoji.

**Default:** Show an icon alone only when all of these hold:
- the platform's own apps show that icon alone for that action, and on web both iOS's and Android's do, such as search, close, back, add or more;
- people use it often, or it repeats on every row;
- it has an accessible name and, where there's a pointer, a tooltip on hover and on keyboard focus;
- it isn't the only way to a rare or important action, and a destructive one ends in Undo or a confirmation.

**Why:** few icons are understood without a word, touch screens have no hover to explain them, and people using voice control have to guess the name to say. **Deviate when:** the audience is new to technology. Then every icon keeps its word.

**Default:** Set an icon as part of its text: an icon box a little larger than the font size, such as 16 px beside 14 px text, a stroke that matches the font's weight, the same gap everywhere, and centered on the main body of the letters, which in Khmer means the base consonants, not the marks above and below. **Why:** an icon sized or weighted apart from its word reads as a separate thing. **Deviate when:** the icon is the whole control. Then use the platform's icon size, and keep the full touch target.

Before: an empty orders page reading "You don't have any orders yet. When customers place orders, they will appear here so you can manage them."
After: "No orders yet", and a "Share your shop" button.

Before: a toast reading "Your changes have been saved successfully!"
After: "Changes saved".

Before: a lone "3" over a tiny "Order fulfillment status" label.
After: "3 orders to ship", which is short and still reads as plain words.

Before: toolbar buttons reading "Search orders", "Filter the list" and "Export to CSV".
After: a search icon alone, then "Filter" and "Export CSV" as words. Search is known everywhere, filter icons differ between products, and export is rare.

Before: a shortened "Delete" button whose accessible name is "Remove item".
After: the accessible name "Delete invoice INV-0042", which keeps the visible word.

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
