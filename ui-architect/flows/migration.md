# Flow: Migrations

Use this for moving from old screens to new ones (e.g. v1 → v2 products), or for upgrading a library or tool (e.g. Tailwind v3 → v4, React Router v6 → v7).

## Screen or module cut-over (old → new)
1. **Inventory:** list the old and new routes, pages, services, and links pointing to the old screens (menus, buttons, redirects, bookmarks).
2. **Gap check:** list what the old version does that the new one doesn't yet. Each gap is resolved (built or explicitly dropped) before cut-over.
3. **Plan:**
   - redirects from old routes to new ones
   - menu and link updates
   - removal of the old code
   - the order of these steps
   - → *Checkpoint*
4. **Cut over in batches:**
   - routes and links first
   - remove old code only after the user confirms the new screens work
   - hand over and wait for the user's OK after each batch
5. **Update** the decisions file "Pages" table and decision log.

## Library or tool upgrade
1. **Read the official migration guide** for the exact versions (current → target). List the breaking changes that affect this codebase, with file counts.
2. **Prefer the official codemod or upgrade tool** if one exists. Then fix what's left by hand.
3. **Plan** in batches (`templates/batch-plan-template.md`), with config first, then shared components, then screens. → *Checkpoint*
4. **No mixed changes:** the upgrade only, with no feature or refactor work in the same batches. Hand over and wait for the user's OK after each batch.
5. **Each hand-over:** a manual check list over the most-used screens, plus anything visual (spacing, colours, focus rings) that the upgrade could shift.
6. **Update** the versions in the decisions file.
