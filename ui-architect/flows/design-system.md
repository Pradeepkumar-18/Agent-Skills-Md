# Flow: Design system, shared components and theme changes

## Shared components (create or extend `Button`, `Modal`, `Table`, `Input`…)
1. **Check what exists.** Extend an existing component rather than adding a parallel one.
2. **Design the API:**
   - props, variants (keep them few and distinct; no duplicates like `primary`/`solid`), sizes
   - controlled vs uncontrolled
   - `className` pass-through
   - forwarded refs where focus matters
3. **States:** default, hover, focus-visible, active, disabled, loading, error, and selected where relevant.
4. **Accessibility:** correct element and roles, keyboard support, labels, focus management (dialogs trap focus and return it).
5. **Tokens only.** No raw colours or sizes inside shared components.
6. **Plan → Checkpoint → Build.**
7. **Document it:**
   - add it to the UI showcase page (if the project has one)
   - add a one-line usage rule to the decisions file "Patterns to follow" (e.g. "All dialogs use `Modal`")
8. **Replacing old copies** is a separate job: `flows/improvements.md` → "Fix a pattern everywhere".

## Theme change, rebrand or adding dark mode (existing projects, only when asked)

This is a **token migration**, not a restyle.

1. **Audit.** List the current tokens and count the raw colour, hex and arbitrary values per file. Tokens with no dark value count as findings.
2. **Target tokens:**
   - define the new or changed tokens (light, and dark if needed)
   - **semantic names** (`surface`, `text-muted`, `success`), not colour names
   - for dark mode, switch values with CSS variables (`:root` and `.dark`), so components need no `dark:` classes
3. **Mapping table:** old value or token → new token, for every value found in the audit.
4. **Preview:** offer an HTML preview of the new theme (as in `flows/new-project.md` step 4). Ask before writing it into `docs/`.
5. **Plan** the migration in batches with `templates/batch-plan-template.md`: token definitions first, then shared components, then screens by module. → *Checkpoint*
6. **Build batch by batch.** Each hand-over lists the screens to check in light (and dark) mode.
7. **Update the decisions file:** theme section, dark-mode status, decision log.

## Density change (e.g. "make the app more compact" / "more spacious")
1. **Audit** how density is expressed today: spacing, row heights, control heights, font sizes, and whether these come from tokens or raw values.
2. **Target:** define the new values as tokens (e.g. row 36px → 44px, control 32px → 40px, body 13px → 14px). Mobile touch targets stay at least 44px either way.
3. **Scope:** the whole app, or chosen pages only (then record per-page overrides).
4. **Plan** in batches with `templates/batch-plan-template.md`: tokens and shared components first, then screens. → *Checkpoint*
5. **Build batch by batch** with a manual check list per batch, and update "Density" in the decisions file.
