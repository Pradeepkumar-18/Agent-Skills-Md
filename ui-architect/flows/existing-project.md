# Flow: Existing project

**Golden rule: the existing codebase wins.** Apply this skill's preferences only when the user asks you to change something.

## First use (no decisions file yet)

Match the response to the first request:

| First request | Do this |
|---|---|
| "Analyse this project", or no specific task | Full **Analysis**, then checkpoint |
| A small change | Do it (`flows/feature.md` → Small change), then offer the analysis in one line |
| A feature | **Short analysis** (top 5 + only the inconsistencies that affect this feature), offer the full one, and continue into feature step 1 in the same message |
| A bug | Fix it (`flows/bug-fix.md`), then offer the analysis in one line |

Ask the decisions-file question at that first checkpoint. Everything goes in one message, so there is only one stop. If there's no checkpoint (a small change or a local bug fix), ask it in the hand-over.

## Inconsistent patterns

Scope the check to the module you're working in first, then the rest of the repo.

- **Ask only when both are true:**
  - the variants are real alternatives in current code
  - the choice changes this feature's architecture or UX
- **Otherwise,** follow the newest or documented-canonical pattern in the same module, and mention it in one line.
- **One checkpoint for all questions,** each with a recommendation.
- **Record each answer** in the decisions file.

## Density and dark mode
- **Density:** keep the current density until the user asks to change it.
- **Dark mode:** if the project has no working dark mode, don't build it. Flag it in the analysis and build it only when asked (`flows/design-system.md`).

## Analysis

Use `templates/analysis-template.md`. Present it **in chat**. Save it to a file only if the user asks.

For every finding give **current state → problem → improvement → priority (High / Medium / Low)**. Areas:
1. Folder structure
2. Component reuse and duplication
3. Styling usage (tokens vs hard-coded values)
4. TypeScript quality
5. Accessibility
6. Responsiveness
7. Performance
8. Consistency between screens

Rules:
- Base every point on real files and cite paths as evidence.
- An area with no issues gets one line: "No issues found."
- End with the top 5 to fix first.
- Offer the next step: "Want me to plan fixes for these?" → `flows/improvements.md`.

## When to re-analyse
Suggest a fresh analysis (one line, never automatically) when:
- a large feature or migration has finished
- about 5 features have been added since the last one
- the decisions file looks clearly out of date compared with the code
