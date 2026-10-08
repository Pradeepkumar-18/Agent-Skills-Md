# Flow: Improvements and refactoring

Use this for "fix the High items", "do the top 5", "replace hard-coded colours", "split this page", "remove `any`", or "fix that in all popups".

## Act on the analysis
1. Take the chosen findings (from the analysis or the user's list).
2. **Group them into batches.** One concern per batch, **at most about 6 files**, small enough to check by hand in about 10 minutes (e.g. "Batch 1: tokens in Schedule, 4 files"). Split bigger groups.
3. **Order by risk:** safe and isolated first, shared components and wide changes last.
4. Write the batch plan with `templates/batch-plan-template.md`. → *Checkpoint*
5. Do **one batch at a time.** After each batch, hand over (changes, manual check list, affected screens) and continue only when the user says so, unless they said "do all batches".

## Refactor without changing behaviour
- **The rule:** the screen must look and behave exactly the same, unless the user agreed to a change.
- **Before:** note the current behaviour and appearance you must keep (states, edge cases, responsive layout).
- **During:** move code in small steps, one module at a time. Don't mix a refactor with a feature or a fix.
- **After:** the manual check list compares before and after.
- **Common refactors:**
  - **Raw colours → tokens:** map each value to the nearest token. Ask before creating new tokens.
  - **Split a giant file:** extract sections into components and hooks inside a feature folder. Keep the public route and props.
  - **Remove `any`:** start at the API client and services, then work outwards to pages.
  - **Replace copies with a shared component:** see the next section.

## Fix a pattern everywhere
When the same problem exists in many places (e.g. 7 hand-written popups):
1. **List every instance** with file paths.
2. **Design the shared solution** (e.g. a `Modal` component), with its props, variants and accessibility. Follow `flows/design-system.md`.
3. **Pilot:** move **one** screen to it, then hand over for the user to check.
4. **Roll out** to the rest in batches, as in "Act on the analysis".
5. Remove the old copies only when nothing uses them.

## Regression safety (no tests)
Every batch's hand-over includes:
- a **manual check list** per affected screen ("open X → do Y → expect Z")
- the **affected screens** list: every place that uses a changed shared component or file
- what to compare **before vs after** (layout, states, mobile, keyboard)
