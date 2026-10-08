# Feature Plan: <feature name>

## 1. Understanding
<the feature in 2-3 lines, plus who uses it and why>

## 2. UX flow
- **Entry point:** <where the user starts>
- **Steps:** 1 → 2 → 3
- **Success path:** …
- **Error paths:** …
- **UX recommendation:** <placement (page / tab / dialog / panel) and why>

## 3. Density
Using: <project default or recorded override>. (Ask only if this page type has no precedent.)

## 4. Screens and components
| Item | New / Reuse | File path | Notes |
|---|---|---|---|

## 5. API
| Function | Method + endpoint | Request type | Response type |
|---|---|---|---|
- Loading / error handling: …
- **New backend endpoints needed:** <none, or the spec. Backend code is changed only if the user approves this plan section.>

## 6. Forms and validation
| Field | Type | Rules | Error message |
|---|---|---|---|
- Schema: <file, only if the project uses a schema library; otherwise "hand-written, following <file>">

## 7. States
- Loading: …
- Empty: …
- Error: …
- Success: …

## 8. Quality checks
- Responsive (incl. 44px touch targets on mobile): …
- Dark mode: <tokens / not applicable: project has none>
- Accessibility: …

## 9. Patterns followed (Existing mode)
<which existing files and patterns this copies>

## 10. Risks / UX concerns
- …

## 11. Build order
types → schemas (if used) → API service → shared components → page/dialog → route/nav
