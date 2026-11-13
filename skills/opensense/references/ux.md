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

**Default:** Use one decision per step for long, unfamiliar or high-stakes flows, and one page for short, familiar forms. In a multi-step form, show one step indicator that names the step ("Step 2 of 4: Address"), keep every answer when people go back, save progress on long forms, and end with a review where each answer can be changed, right before the button that commits. **Why:** steps lower the load for rare tasks but slow down frequent ones, and people abandon flows that lose their work or surprise them at the end. **Deviate when:** answers in different steps depend on each other, like a delivery date and its price. Then show them together where the choice is made.

**Default:** Keep labels visible above fields, and never use placeholder text as the label. **Why:** placeholders vanish on input and fail contrast and screen readers. **Deviate when:** a single, self-explanatory field like search has a visible icon and an accessible name.

**Default:** Ask only for what you need, in the order people think of it, with the right input type and keyboard (email, tel, numeric, date). **Why:** every field costs effort and invites mistakes. **Deviate when:** the law or the domain requires the field. Then say why it's needed.

**Default:** Validate when a field loses focus and on submit, not on every keystroke. Show the error next to the field, and keep what the user typed. **Why:** early red errors punish people mid-typing. **Deviate when:** live feedback helps, as with a password rule or a username check.

**Default:** Put the primary action where sibling screens put theirs, so each kind of action stays in the same place across the product. With no sibling to follow, put it where the eye ends: at the end of the form, full width on phones. Make secondary actions visually quieter, and keep destructive ones apart from it. In dialogs, the confirming action goes on the trailing side. **Why:** one clear next step, found where it was last time, and a Delete right beside Save gets pressed by mistake. **Deviate when:** the platform puts it elsewhere, such as a top-right Save in an iOS navigation bar, or OK before Cancel in Windows dialogs.

Before: a button labeled "Submit".
After: a button labeled "Register as a patient".

Before: a four-step application with unnamed dots, a Back button that empties the step, and a last step that submits without a review.
After: "Step 2 of 4: Address", answers kept on Back, a draft saved after each step, and a review page with "Change" beside each answer, above "Submit application".

**Default:** Where most people make the same choice, choose it for them, show it, and keep it easy to change: today's date, the saved address, standard delivery. **Why:** each decision costs effort, and a visible default settles it for most people without hiding it from the rest. **Deviate when:** the choice is consent, a paid extra or anything costly to undo. Leave it unselected, for the person to choose.

**Default:** When a control needs instructions to be used, such as "Swipe left to delete" or "Tap the pencil to edit", change the control rather than add the text. **Why:** instructions are read once, if at all, while the control is used every time. **Deviate when:** the audience is new to technology. Fix the control, and keep a short hint as well.

Before: "Standard delivery" hidden behind a separate step, a pre-ticked "Add delivery protection ($4)" box, and "Swipe left on an address to delete it" above the saved addresses.
After: "Standard delivery, arrives Thu 19 Nov" with a "Change" button, the protection box unticked, and "Delete" in each address's menu.

**Default:** Next to the button that commits, show the total with every fee, the conditions that apply, such as renewal or cancellation terms, and anything that can't be undone. Detail only some people need, such as the full policy, can sit one tap away. **Why:** people decide at the button, and a cost found after it feels like a trick. **Deviate when:** never. A tooltip, a collapsed section or the next step is not next to the button.

Before: a booking screen with "Book now", a service fee inside an info tooltip, and the cancellation terms on another page.
After: "Total $48, including $3 service fee" and "Free cancellation until 12 Nov" right above "Pay $48", with the full policy behind a "Details" link.

## Feedback and system status

**Default:** Every action shows a pressed state at once, and anything slower than about a second shows progress. **Why:** silence reads as broken, and people tap again. **Deviate when:** the action is instant and its result is visible on the spot.

**Default:** Confirm success in place, with a short message or the changed item itself, instead of a modal. **Why:** a modal costs an extra tap and says nothing new. **Deviate when:** the success has consequences the user must read, such as an order number for a phone call.

**Default:** Use a modal only for a decision that must interrupt, and prefer inline editing and inline confirmation. **Why:** a modal hides the context the decision is about, and costs a tap to dismiss. **Deviate when:** a focused task needs the whole screen, such as writing a message, or the platform presents it as a sheet.

Before: an "Operation completed successfully" modal with an OK button.
After: the row updates, and "Invoice sent to ana@example.com" appears briefly beside it.

**Default:** Once a submit, payment or send starts, show that it's in progress and ignore further presses until it finishes. **Why:** a slow response invites a second tap, and a second tap can charge or send twice. **Deviate when:** repeating the action is harmless, like refreshing a list.

**Default:** Keep a form's submit button enabled. When it's pressed with something missing, show what's missing beside each field and move focus to the first one. If a control must be disabled, say why in visible text beside it. **Why:** a grayed-out button gives no reason, often can't take keyboard focus, and has no hover on touch, so people can't find out what to fix. **Deviate when:** the action is unavailable rather than incomplete, such as a sold-out size. Say so, and offer the next best step.

Before: a "Pay $12" button that stays live while the payment runs, and a grayed-out "Continue" with no hint.
After: the button reads "Paying…" and ignores taps until the result comes back, and "Continue" stays enabled; pressing it marks the empty phone field with "Add your phone number".

## Empty, loading, error and offline states

**Default:** Design every data view's empty, loading and error states as part of the feature, not afterwards. **Why:** new users meet the empty state first, and everyone meets the error state eventually. **Deviate when:** never. A missing state falls back to a blank screen or a raw error.

- **Empty:** say what will appear here and offer the next action. If there is nothing to do, say when it will fill.
- **No results:** when filters or a search exclude everything, say which, and offer to clear them. It's a different state from empty.
- **Loading:** use a skeleton shaped like the content when the layout is known, and a small spinner only for short, unknown waits.
- **Error:** say what happened, why if you know, and what to do. Keep the user's input and offer a retry.
- **Offline:** say what still works and what will sync later.
- **First run:** show the one first step. Skip the tour.

Before: "No data."
After: "No invoices yet. Your first invoice appears after your first payment."

Before: "Something went wrong."
After: "Couldn't load invoices. Check your connection, then try again." with a "Try again" button.

Before: "No data." under an orders table filtered to "Refunded" and "Last 7 days".
After: "No refunded orders in the last 7 days", with "Clear filters".

## Tables, filters and bulk actions

These apply when you build or rework a data view. A tweak to one changes only what it touches.

**Default:** Set density by how often people use the screen: compact rows, more columns and keyboard shortcuts for people who work in it daily, and fewer columns with plainer labels for occasional users. Take compact spacing from the design system's density tokens. Compact rows still keep touch targets at their minimum sizes on touch screens, and each script's minimum text size and line height. **Why:** padding made for a landing page hides the data an expert needs, and expert density overwhelms a newcomer. **Deviate when:** both kinds of user share the screen. Start comfortable, and offer a compact setting.

**Default:** In a table:
- use a real table with header cells, so screen readers announce each cell's column;
- order columns by the task, with the column that identifies each row first, and put rarely used columns in a column picker;
- align each header like its column's data, and put units and currency in the header ("Total (USD)") instead of in every cell;
- show a missing value as "—", never as 0 or "null";
- keep the header in view while scrolling, and the identifying column too when the table scrolls sideways;
- start with the sort that serves the task, such as most overdue first, and mark the sorted column and its direction in the header, and on the web with `aria-sort`;
- make a cut-off value readable in full without hovering, in the row's detail or by letting the cell wrap.

**Why:** people scan down columns to compare and across rows to act, and each of these keeps both quick. **Deviate when:** each row is a whole record people read rather than compare, like messages. Then a list fits better than a table.

Before: ten equal-width columns, "$" and "null" in the cells, no sort, and long customer names cut off with only a hover tooltip to read them.
After: Order, Customer, Status, Total (USD) and Due, sorted by most overdue, "—" for a missing date, the other columns in a column picker, and full names in the row's detail.

**Default:** Show active filters as chips that remove them, beside the result count and "Clear all". Keep filters, sort and page when people go back or reload; on the web, keep them in the URL so a shared link keeps them too. Apply a filter at once when results come back fast; on phones, or when results are slow, gather filters in a sheet whose button shows the count ("Show 24 orders"). **Why:** hidden filters make missing rows look like missing data, and filters lost on Back have to be rebuilt. **Deviate when:** the product has saved views. Then show the view's name, and mark it when its filters have changed.

**Default:** When rows are selected, show the bulk actions where the eye already is, usually in place of the toolbar, with the count ("3 selected"). Name each row's checkbox ("Select order 1042"). If "select all" could mean more than the visible rows, say which: "All 50 on this page are selected. Select all 1,240 orders". After a bulk delete, move focus to the next row or the table's heading. **Why:** a bulk action on rows people can't see is how mass mistakes happen, and lost focus strands keyboard and screen-reader users. **Deviate when:** the table has no bulk actions. Then leave out the checkboxes.

**Default:** For records people come back to, use pages or "Load more" with the total ("1–50 of 1,240"), and return people to the same place after they open a row. Keep endless scrolling for feeds people browse, and never put it above a footer people need. **Why:** people need to find their place again, and endless scrolling hides both the total and the footer. **Deviate when:** the list is short enough to show whole.

**Default:** Build a dashboard from the decisions people make with it. Each chart answers one question, and its values can be read without hovering. Where the data has them, show the comparison it needs ("vs last week") and when it was last updated; never invent either. **Why:** a dashboard is read in seconds, right before a decision. **Deviate when:** the screen is for exploring data rather than checking it. Then filters and a table may serve better than charts.

Before: filters hidden in a closed panel and lost on Back, and a header checkbox that selected the 50 visible orders while "Delete" removed all 1,240.
After: chips for "Refunded" and "Last 7 days" above the table, kept on Back, and "Select all 1,240 orders" as a separate, explicit step.

## Destructive actions

**Default:** Name the object and the consequence in the confirmation, and label the button with the action. **Why:** people press "OK" out of habit. **Deviate when:** the action can be undone. Then act immediately and offer Undo, which beats any confirmation.

Before: "Are you sure?" with OK and Cancel.
After: "Delete 3 invoices? This can't be undone." with "Delete invoices" and "Cancel".

## Native differences

- **iOS:**
  - navigation stacks put back at the top left, and people expect to swipe back from the edge;
  - destructive choices go in an action sheet;
  - Save and Done usually sit in the navigation bar;
  - on iPhone, a table becomes a list showing the key fields, with the rest on tap; on iPad and Mac, a table with sortable columns and selection fits.
- **Android:**
  - system back must always work;
  - confirm reversible actions with a snackbar that offers Undo;
  - use bottom sheets for secondary choices;
  - on phones, a table becomes a list showing the key fields, with the rest on a detail screen.
- **Desktop:**
  - keyboard shortcuts for frequent actions;
  - tables with resizable columns, and multi-select with Shift-click and Ctrl- or Command-click;
  - Enter submits a form, Escape cancels a dialog;
  - right-click menus are a bonus, never the only path.

Before: an Android screen with its own back arrow that skips unsaved-changes handling.
After: system back and the app bar arrow both run the same unsaved-changes check.
