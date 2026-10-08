# Flow: Bug fix

Use this when something is broken: a popup not closing, broken layout, a wrong state, a form not submitting, a console error.

## Steps
1. **Understand.** Ask only what's missing: steps to reproduce, expected vs actual, which screen, device/browser, console error.
2. **Find the root cause, not the symptom.** Trace the code until you can explain *why* it happens. State it in one or two lines before fixing.
3. **Classify:**
   - **UI-only:** fix it.
   - **Data or API:** fix the frontend handling (e.g. a missing error state) and report the API problem.
   - **Backend:** explain the cause and propose the fix. Change backend code only if the user approves.
4. **Fix minimally, following existing patterns.** No redesign or refactor while fixing.
5. **Look for the same bug elsewhere.** Search for the same pattern. **Report** the other places and the real fix (e.g. a shared component), but don't change them. If the user says "fix them all", switch to `flows/improvements.md` → "Fix a pattern everywhere".
6. **Verify:**
   - Run lint/typecheck if allowed.
   - If the tool has a browser, reproduce the bug before the fix and confirm it's gone after.
   - Otherwise rely on the manual check list.
7. **Hand-over** (as in `SKILL.md`): root cause, files changed, manual check list, affected screens, related issues found.

**Checkpoint only when** the fix changes behaviour or UX, touches a shared component used across many screens, or needs backend changes. A local fix goes straight through.

## Extra checks by bug type

| Bug type | Check |
|---|---|
| **Layout / "broken on mobile"** | Check at 360, 768 and 1280px wide; check long text and empty data; no horizontal scroll |
| **Slow page** | **Measure before fixing:** count re-renders, look for repeated or waterfall API calls, large lists without pagination or virtualisation, heavy imports. Fix the measured cause, then measure again |
| **Accessibility** | In this order: keyboard (Tab/Shift+Tab/Enter/Esc reach and work) → labels and names → contrast → focus visibility and focus trap → screen-reader roles |
| **Form not submitting** | Validation blocking silently, a disabled button never re-enabled, an unhandled API error, a wrong payload shape |
| **Popup / dialog** | Esc, clicking outside, focus trap, focus returns to the trigger, scroll lock, stacking (z-index) with other overlays |

## "Fix this" with an image

**First decide what the image is for.** If it's not clear, ask one question: *"Is this image showing the bug, or how it should look?"*

| Image is… | Do this |
|---|---|
| **Evidence of the bug** | Run this bug-fix flow. Read the visible symptoms to help find the root cause. **Never treat it as a design to build.** |
| **The target design** ("make it look like this") | It's a design change, not a bug: `flows/reference-image.md` + feature plan with a checkpoint |
| **The spec it should already match** | **Mismatch fix:** list each difference as *current → expected* (mapped to tokens), and fix **only those**. Checkpoint only if a difference changes behaviour or touches a shared component. Compare again afterwards |

## Hotfix mode

Triggered by "urgent", "production is broken", "hotfix" and similar.
- Skip the analysis, the decisions-file question and checkpoints.
- Make the **smallest safe fix** that stops the damage, even if it isn't the ideal design.
- Never mix in refactoring or unrelated changes.
- Hand-over adds a **follow-up note:** what the proper fix is, and why the hotfix is temporary.
