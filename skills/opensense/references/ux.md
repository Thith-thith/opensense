# UX: context, flows and states

Read this when designing a flow, navigation, a form, or the first-run, empty, loading, error or offline state of a screen.

## Context before layout

**Default:** Name the person, their job on this screen and their situation before you choose a layout. **Why:** the same data needs a different screen for a nurse between patients than for an analyst at a desk. **Deviate when:** the change is a tweak inside an existing screen. Then the screen's existing context is your context.

**Default:** Take facts from the code, the request and the user. **Why:** an invented persona or invented research sends the design confidently in the wrong direction. **Deviate when:** never invent research. If you assume something, say so in your report.

Before: "Users want a powerful, flexible dashboard."
After: "The owner checks today's orders and low stock on a phone at 6 a.m., before the shop opens."

## Information architecture and navigation

**Default:** Organize by the user's tasks and words, not by database tables or code modules. **Why:** people look for "Billing", not "Subscription service". **Deviate when:** the users are the engineers who own those modules, as in an internal admin tool.

**Default:** Keep navigation shallow and predictable, and always show where the user is: a selected tab, a breadcrumb or a clear title. **Why:** people should know where they are, what they can do and what happens next. **Deviate when:** a linear flow like checkout or sign-up works better with no navigation chrome at all.

**Default:** Put a new screen where its siblings live, and copy their structure. **Why:** consistency is how people learn an app. **Deviate when:** the sibling pattern is wrong for this content. Then change all the siblings, or follow the pattern. Never fork it silently.

Before: a new Billing page built as three cards, while the sibling settings pages are a heading, a separator and form rows.
After: Billing uses the same heading, separator and form rows as Profile and Account.

## Flows and forms

**Default:** Use one decision per step for long, unfamiliar or high-stakes flows, and one page for short, familiar forms. **Why:** steps lower the load for rare tasks, but slow down frequent ones. **Deviate when:** the user needs to compare answers across steps. Then show a summary before submitting.

**Default:** Keep labels visible above fields, and never use placeholder text as the label. **Why:** placeholders vanish on input and fail contrast and screen readers. **Deviate when:** a single, self-explanatory field like search has a visible icon and an accessible name.

**Default:** Ask only for what you need, in the order people think of it, with the right input type and keyboard (email, tel, numeric, date). **Why:** every field costs effort and invites mistakes. **Deviate when:** the law or the domain requires the field. Then say why it's needed.

**Default:** Validate when a field loses focus and on submit, not on every keystroke. Show the error next to the field, and keep what the user typed. **Why:** early red errors punish people mid-typing. **Deviate when:** live feedback helps, as with a password rule or a username check.

**Default:** Put the primary action where the eye ends: at the end of the form, full width on phones. Make secondary actions visually quieter. **Why:** one clear next step. **Deviate when:** the platform puts it elsewhere, such as a top-right Save in an iOS navigation bar.

Before: a button labeled "Submit".
After: a button labeled "Register as a patient".

## Feedback and system status

**Default:** Every action shows a pressed state at once, and anything slower than about a second shows progress. **Why:** silence reads as broken, and people tap again. **Deviate when:** the action is instant and its result is visible on the spot.

**Default:** Confirm success in place, with a short message or the changed item itself, instead of a modal. **Why:** a modal costs an extra tap and says nothing new. **Deviate when:** the success has consequences the user must read, such as an order number for a phone call.

Before: an "Operation completed successfully" modal with an OK button.
After: the row updates, and "Invoice sent to ana@example.com" appears briefly beside it.

## Empty, loading, error and offline states

**Default:** Design every data view's empty, loading and error states as part of the feature, not afterwards. **Why:** new users meet the empty state first, and everyone meets the error state eventually. **Deviate when:** never. A missing state falls back to a blank screen or a raw error.

- **Empty:** say what will appear here and offer the next action. If there is nothing to do, say when it will fill.
- **Loading:** use a skeleton shaped like the content when the layout is known, and a small spinner only for short, unknown waits.
- **Error:** say what happened, why if you know, and what to do. Keep the user's input and offer a retry.
- **Offline:** say what still works and what will sync later.
- **First run:** show the one first step. Skip the tour.

Before: "No data."
After: "No invoices yet. Your first invoice appears after your first payment."

Before: "Something went wrong."
After: "Couldn't load invoices. Check your connection, then try again." with a "Try again" button.

## Destructive actions

**Default:** Name the object and the consequence in the confirmation, and label the button with the action. **Why:** people press "OK" out of habit. **Deviate when:** the action can be undone. Then act immediately and offer Undo, which beats any confirmation.

Before: "Are you sure?" with OK and Cancel.
After: "Delete 3 invoices? This can't be undone." with "Delete invoices" and "Cancel".

## Native differences

- **iOS:**
  - navigation stacks put back at the top left, and people expect to swipe back from the edge;
  - destructive choices go in an action sheet;
  - Save and Done usually sit in the navigation bar.
- **Android:**
  - system back must always work;
  - confirm reversible actions with a snackbar that offers Undo;
  - use bottom sheets for secondary choices.
- **Desktop:**
  - keyboard shortcuts for frequent actions;
  - Enter submits a form, Escape cancels a dialog;
  - right-click menus are a bonus, never the only path.

Before: an Android screen with its own back arrow that skips unsaved-changes handling.
After: system back and the app bar arrow both run the same unsaved-changes check.
