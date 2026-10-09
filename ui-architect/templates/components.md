# Component inventory

Maintained by the ui-architect skill. **Check this before writing any UI.** Update it whenever a shared component is created or extended.

| Component | Location | Purpose | Key props | Variants / sizes | Slots / parts |
|---|---|---|---|---|---|
| Button | components/ui/Button.tsx | All clickable actions | `variant`, `size`, `loading`, `startIcon`, `className`, native button props | primary, secondary, outline, ghost, danger / sm, md, lg | children |
| … | | | | | |

## Usage notes
- **Button:** use `danger` for destructive actions; icon-only buttons need `aria-label`.

## Change log
| Date | Component | Change |
|---|---|---|
