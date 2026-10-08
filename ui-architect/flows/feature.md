# Flow: Feature or small change

## Small change or feature?
- **Small change:** touches at most 2 files, with no new component, route or API call (e.g. add a column, change a label, tweak a style).
  - Flow: restate in one line → short plan → code → hand-over.
  - No checkpoint unless something is ambiguous.
- **Feature:** anything bigger. Follow the steps below.

## 1. Understand
- Restate the feature in your own words.
- Ask only what is missing: who uses it, where it lives (page, tab, dialog, side panel), data, actions, permissions, edge cases.
- Give your UX recommendation.
- → *Checkpoint*

## 2. Context
- Read the decisions file (if any) and related code.
- Find screens, components, services and types to reuse.
- Note the patterns you'll follow (inconsistent-pattern rule: `flows/existing-project.md`).
- **API contract.** Never guess response shapes. In this order:
  1. existing types or services
  2. API docs (OpenAPI/Swagger)
  3. **the backend repo, if available: read it, never edit it unless the plan approves it**
  4. ask the user for the endpoint and a sample response
  - **Backend not ready:** plan a typed mock (`services/mocks/`, or the project's equivalent) and mark it clearly.
- **Impact:** list existing screens and components this feature will touch or could affect.

## 3. Size check
If the feature is large (several screens, more than about 8 files, or more than one user flow), **split it into slices**. Each slice must be usable or reviewable on its own (e.g. "1. list + filters → 2. create/edit dialog → 3. bulk actions"). Plan and approve each slice separately.

## 4. Plan
Write the plan with `templates/feature-plan-template.md`. It must include:
- **Acceptance criteria:** "Done when…", a checklist the user can verify.
- **Wireframe:** a low-fidelity layout as an ASCII sketch in the plan, showing regions, key controls and the mobile layout. Generate an HTML wireframe instead only if the user asks.
- **Density:** state what you'll use (default or recorded override). Ask only if this page type has no precedent.
- **URL state:** filters, tabs, sorting, pagination and the selected record live in the URL, so refreshing and deep links work.
- **Data loading:** server or client paging, and refresh-after-save behaviour (see "Data loading rules" below).
- **Tables:** follow `templates/table-standard.md` for any new or changed table.
- **Unsaved changes:** how leaving a dirty form is handled.
- **Navigation updates:**
  - sidebar or menu entry
  - breadcrumbs
  - page title
  - who can see it (role visibility)
- **Edge data:** how long text, 0 / 1 / many items, large numbers, slow network and no permission are handled.
- **Text:** final wording for buttons, empty states, errors and confirmations.
- **Backend:** if an endpoint is missing, specify it. Change backend code only if the user approves that part of the plan.
- **Impact list** from step 2.

→ *Checkpoint: wait for approval of the whole plan.*

## 5. Multi-session work
If the feature has slices, or will clearly span sessions, and the decisions file is allowed:
- save the plan to `docs/plans/<feature>.md`
- tick off slices and steps as they finish
- set its status (in progress / done)

A new session will find it at Step 0.

## Data loading rules (no TanStack Query by default)
In existing projects, follow the project's data pattern. Without one, apply these:
- **Stale responses:** when a newer request replaces an older one (search, filters, paging), ignore or abort the older one, so a slow old response never overwrites new data. Use `AbortController` or a request id.
- **Cancel on leave:** abort in-flight requests when the component unmounts or the inputs change.
- **Debounce typing:** search-as-you-type waits about 300ms before calling the API.
- **After a save:** either reload the affected list, or update it in place from the server response. State which in the plan. Never show data the server didn't confirm, unless the plan says it's an optimistic update and how it's rolled back on failure.
- **Server or client paging:** use server-side paging, sorting and filtering when the list can grow past about 200 rows. Client-side is fine for small fixed lists. Say which in the plan.
- **Loading vs refreshing:** show a full skeleton only on first load. Later refreshes keep the old data visible with a subtle indicator.
- **Errors:** show a retry action on load errors. Never leave a blank screen.
- **Double submit:** disable submit while saving.

## 6. Build
Code everything in the approved plan (or slice), in this order:
1. types
2. validation schemas (only if the project uses a schema library)
3. API service (or mock)
4. shared components
5. page/dialog
6. route and navigation

## 7. Self-review and hand-over
- Check the work against the plan's acceptance criteria and the quality bar.
- Follow the hand-over rules in `SKILL.md`: files changed, assumptions, manual check list, affected screens, open decisions.
- Update the decisions file and the plan file (if they exist).
