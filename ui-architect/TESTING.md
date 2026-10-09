# Testing ui-architect 3.0

Run each test as one prompt in a **new conversation**, opened at the project root. For a real project, add: *"This is a test: don't change files, show what you would change."*

## 0. Installed and loaded
**Prompt:** "What version is ui-architect?" **Expect:** `3.0.0`.

## 1. Analysis
**Prompt:** "Use the ui-architect skill and analyse this project."
- [ ] Covers duplicated UI, missing shared components, non-customisable components, structure, consistency, each with file paths and a priority
- [ ] Shows the current component inventory
- [ ] Doesn't drift into security, performance or data loading
- [ ] At most 3 questions, including asking before creating `docs/ui-decisions.md` and `docs/components.md`

## 2. Real-session regression (the task list)
**Prompt:** "Use ui-architect: show my tasks in a table with serial numbers, and edit and delete actions."
- [ ] **One** continuous table, with serial numbers running 1, 2, 3…
- [ ] Edit and delete are **always visible** (not hover-only)
- [ ] Reuses existing table, button and dialog components; no copy-paste
- [ ] No new visual pattern invented

## 3. New popup when there's no shared Modal
**Prompt:** "Use ui-architect to add a delete confirmation popup on <page>."
- [ ] Notices how popups are built today (inline copies?)
- [ ] Proposes a **shared** `Modal`/`ConfirmDialog` with an API (props, variants, slots, accessibility) and **stops for approval**
- [ ] Doesn't build yet another inline popup

## 4. Extend, don't copy
**Prompt:** "Use ui-architect: I need a small red outlined button with a trash icon."
- [ ] Uses or extends the existing `Button` (a variant or prop); no new button component, no inline-styled `<button>`
- [ ] The extension is backward-compatible and uses tokens

## 5. Extract on second use
**Prompt:** "Use ui-architect: show the same summary cards from page A on page B."
- [ ] Extracts a shared component, places it in the shared folder, and **replaces the first copy too**
- [ ] Stops at the new-shared-component checkpoint

## 6. Structure
**Prompt:** "Use ui-architect: where should a new hook for filters go?" (or create a feature in a new module)
- [ ] Follows the existing or agreed structure; doesn't invent a new folder

## 7. New project (empty folder)
**Prompt:** "Use ui-architect. New expense tracker app."
- [ ] Checkpoints: structure → theme + density
- [ ] Plans the shared component set (including custom form controls with date limits) and the inventory **before** pages

## 8. Should not trigger
"Write the Express endpoint for /api/leads" · "Fix the failing Jest test" · "Audit for XSS" · "Build a page in Vue"

## Scoring
- **Pass:** every box ticked.
- **Fail:** copy-pasted UI, a new pattern invented, files created without asking, a shared component created without approval, or a list split into several tables.
