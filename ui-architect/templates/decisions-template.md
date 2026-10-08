# UI Decisions

Maintained by the ui-architect skill. Read before any frontend work. Update whenever a decision changes.
Record what the project **actually uses**, not the skill's defaults. Mark inferred values "(to confirm)".

## Project
- **Mode:** New | Existing
- **Frontend root:** <path>
- **Purpose:** …
- **Users / domain:** …
- **Devices:** …
- **Backend / API docs:** <repo path, Swagger URL, or "not ready: mocks in …">

## Stack (with major versions)
- Framework / build: <…>
- Styling: <e.g. Tailwind v4, where tokens live / CSS modules / …>
- Routing: <…>
- API layer: <client file, service folder, axios or fetch, mock flag>
- Forms / validation: <library or "hand-written">
- Global state: <choice + reason>
- Icons: <…>
- Dark mode: <working | not built: build only when asked>
- i18n / RTL: <none | library + where strings live>
- Tests: <convention, or "none unless asked">

## Auth and access
- Token storage: <…> · Session expiry handling: <…>
- Roles and what they can see: <…>

## Formatting
- Locale: <e.g. en-IN> · Currency: <e.g. INR ₹> · Dates: <format> · Helper: <utils/format.ts>

## Folder structure
```
<agreed or detected tree>
```

## Theme
- **Colours (light / dark):** primary, secondary, background, surface, text, muted, border, success, warning, danger
- **Typography:** font family, scale
- **Radius / spacing / shadows:** …

## Density
- **Project default:** Dense | Simple
- **Per-page overrides:**
  | Page | Density | Reason |
  |---|---|---|

## Patterns to follow
| Concern | Pattern | Reference file |
|---|---|---|
| Page layout | | |
| Dialogs | | |
| Forms | | |
| API service | | |
| Tables | | |
| Feedback (toasts) | | |
| Icons | | |
| URL state | | |

## Pages
| Page | Route | Roles | Status |
|---|---|---|---|

## Plans in progress
| Plan | File | Status |
|---|---|---|

## Decision log
| Date | Decision | Reason |
|---|---|---|
