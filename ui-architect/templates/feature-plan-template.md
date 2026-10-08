# Feature Plan: <feature name> <(slice N of M, if sliced)>

## 1. Understanding
<the feature in 2-3 lines, plus who uses it and why>

## 2. Acceptance criteria
Done when:
- [ ] …
- [ ] …

## 3. UX flow
- **Entry point:** <where the user starts>
- **Steps:** 1 → 2 → 3
- **Success path:** …
- **Error paths:** …
- **UX recommendation:** <placement (page / tab / dialog / panel) and why>

## 4. Wireframe
```
<low-fidelity ASCII layout: regions, key controls; plus the mobile layout>
```

## 5. Density
Using: <project default or recorded override>

## 6. Screens and components
| Item | New / Reuse | File path | Notes |
|---|---|---|---|

## 7. API
| Function | Method + endpoint | Request type | Response type | Source of contract |
|---|---|---|---|---|
- Loading / error handling: …
- Mock needed (backend not ready): <no / yes: file>
- **New backend endpoints needed:** <none, or the spec. Backend code is changed only if approved.>

## 8. Forms and validation
| Field | Type | Rules | Error message |
|---|---|---|---|
- Schema: <file, only if the project uses a schema library>
- Unsaved changes: <how leaving a dirty form is handled>

## 9. States and edge data
- Loading / Empty / Error / Success / No permission: …
- Long text / 0, 1, many items / large numbers / slow network: …

## 10. URL state and navigation
- In the URL: <filters, tabs, sort, page, selected id>
- Navigation updates: <sidebar entry, breadcrumbs, page title, role visibility>

## 11. Text
| Place | Wording |
|---|---|
| Primary button | |
| Empty state | |
| Error | |
| Confirmation | |

## 12. Quality checks
- Responsive (360 / 768 / 1280, 44px touch targets): …
- Dark mode: <tokens / not applicable: project has none>
- Accessibility: …

## 13. Patterns followed (Existing mode)
<which existing files and patterns this copies>

## 14. Reference → implementation (only when a reference image was given)
| Element in image | How it's built | Intentional difference |
|---|---|---|

## 15. Impact
Screens and components this touches or could affect: …

## 16. Risks / UX concerns
- …

## 17. Build order
types → schemas (if used) → API service / mock → shared components → page/dialog → route/nav
