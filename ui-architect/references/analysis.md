# Analysis (focused on reuse, consistency and structure)

Present it in chat. Use search results for counts; don't read every file. Every finding gives **current → problem → fix → priority (High / Medium / Low)** with real file paths.

## 1. Duplicated UI
The same markup or logic in two or more places, e.g. hand-built modals, copied tables, repeated form fields, repeated status badges. Give the count and the files.

## 2. Missing shared components
Patterns that should be shared components but aren't, e.g. no shared `Modal`, `Select`, `DatePicker`, `EmptyState`. Also list native browser controls used where custom ones should be.

## 3. Shared components that aren't customisable
- Boolean-prop piles.
- No `className` passthrough.
- No way to pass custom content.
- Copies made because the original couldn't be extended.

## 4. Structure
- Files in the wrong place.
- Competing folder patterns.
- Dead or duplicate files.
- Giant files that should be split.

## 5. Consistency
- Raw colours and arbitrary values instead of tokens.
- Two or more ways of doing the same thing (dialogs, toasts, tables, loading states).
- Density drift.

## Output
- Mode and stack in one line.
- The 5 sections above (skip a section with "No issues found").
- **Component inventory:** what exists today (name, props, variants), so the user can see the starting point.
- **Fix first (top 5).**
- Up to 3 questions, e.g. which competing pattern to keep, and whether you may create the project memory files.
