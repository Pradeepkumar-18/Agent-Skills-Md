# Changelog: ui-architect

The version is also shown at the top of `SKILL.md`. To check a project's version, open `.agent/skills/ui-architect/SKILL.md` there.

## 3.0.1 (2026-10-09)
- The hand-over now ends with a **self-check**: a score out of 10 each for reuse, approval of new shared components, structure, tokens and no invented patterns, plus one line on what to do differently.

## 3.0.0 (2026-10-09): refocus
The skill is rebuilt around its original purpose: **consistency, reuse, reusable customisable components, project structure and user control**.

**Why:** 2.x grew into an "everything" skill (10 flows: security, data loading, migrations, hotfix, review, auth setup and more). In real use it over-designed: it split one list into several tables, hid actions behind hover, and invented new visual patterns. Reuse, the main goal, was a single line.

**New**
- **Reuse ladder:** use → configure → extend → compose → extract on second use → local only if unique. Never copy-paste.
- **Component inventory** (`docs/components.md`), checked before any UI is written. If it isn't saved, it's built by searching the components folder.
- **Component standard** (`references/component-standard.md`):
  - prioritised rules with wrong/right examples
  - variants instead of boolean props
  - `className` + `...rest` + `ref`
  - children/slots/compound parts
  - tokens only
  - backward-compatible extension
  - complete custom form controls (including date limits)
- **Checkpoints only for:** structure, theme/density, **a new shared component's API**, breaking changes to shared components, and the first analysis.
- **Focused analysis:** duplication, missing shared components, non-customisable components, structure, consistency, plus the current inventory.
- **Red-flags list:** copy-pasted components, boolean piles, raw colours, split tables, hover-only actions, invented patterns.
- The role is now "architect, not visual designer": follow the project's design and use conventional patterns.

**Removed** (out of scope for this skill): the separate flows for new project setup (auth, mocks, showcase), feature slices and wireframes, bug fix and hotfix, improvements batches, review, design-system migrations, Tailwind/library migrations, plus the data-loading, security and performance rule sets. These can return later as separate, focused skills if needed.

**Kept:** two modes (new/existing), "existing code wins", project memory files (asked once), custom form controls, basic per-field validation with web-checked official formats, the sync script and versioning.

**Size:** core `SKILL.md` ~1,950 tokens (2.2.0 was ~3,300), plus 3 small references loaded only when needed.

## 2.2.0
Data-loading, security, performance, reading-efficiency rules; table standard; fixes from validation tests.

## 2.1.0
Custom components only; basic per-field validation.

## 2.0.0
Split into core + flows + templates; many flows added.

## 1.x
Initial skill.
