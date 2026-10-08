# Changelog: ui-architect

The version is also shown at the top of `SKILL.md`. To check which version a project has, open `.agent/skills/ui-architect/SKILL.md` there.

## 2.2.0 (2026-10-08)
- **Rule conflicts settled:**
  - Projects that already use a UI library follow it.
  - Charts, rich-text editors, maps and logic-only helpers are allowed exceptions (ask first, theme-styled).
- **Data loading rules:** stale responses, cancelling, debouncing, refresh after save, server vs client paging, loading vs refreshing.
- **Frontend security rules:** public env variables, no unsanitised HTML, no logging of secrets, upload checks, safe links.
- **Reading code efficiently:** search first, partial reads of large files, no re-reading.
- **Performance by default:** lazy routes, heavy imports where used, pagination or virtualisation, image sizes.
- **Table standard** (`templates/table-standard.md`).
- **Fixes from validation tests:**
  - `existing-project.md` is read only on a true first use (not after an earlier analysis, not for hotfixes).
  - Hotfix skips all first-use steps.
  - Mismatch fix applies visual-only differences and asks about behaviour or content changes; states missing from the design are marked "(guessed)".
  - Batches have at most about 6 files.
  - Checkpoints have at most 3 questions.
  - Decisions-file timing is consistent.
  - New projects get status and category tokens.
  - The description triggers on Tailwind/tooling upgrades and form validation.
- Version and changelog added.

## 2.1.0
- Custom components only: no native controls and no UI libraries.
- Basic per-field validation, with official formats checked on the web.

## 2.0.0
- Split into a core `SKILL.md` plus `flows/` and `templates/`.
- Added: auth, setup, mocks, showcase, acceptance criteria, slices, wireframes, URL state, improvements, review, design-system and migration flows, hotfix mode.

## 1.x
- Initial skill: two modes, analysis, new-project and feature flows, decisions file, reference images, bug-fix flow, "fix this" with an image.
