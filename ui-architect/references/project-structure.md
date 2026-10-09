# Project structure

## Existing projects
Follow what exists. Before creating a file, find where similar files live and put it there. If two patterns compete (e.g. flat `pages/X.tsx` vs `pages/x/` folders), ask once which to use for new work, then record it in `docs/ui-decisions.md`.

## New projects: recommended layout
Adapt it to the project, explain the choices, and get the user's OK.

```
src/
├── main.tsx / App.tsx      # entry, providers, routes
├── routes/                 # route definitions, guards
├── layouts/                # app shell: sidebar, header, page wrappers
├── pages/
│   └── <module>/           # one folder per module/screen
│       ├── <Module>Page.tsx
│       └── components/     # UI used ONLY by this module
├── components/
│   ├── ui/                 # shared primitives: Button, Input, Select, Checkbox, DatePicker, Dialog, Table, Badge…
│   └── common/             # shared composites: PageHeader, EmptyState, ConfirmDialog, DataTable, FormField…
├── hooks/                  # shared hooks
├── services/               # API client + one service per module (pages never call the API directly)
├── types/                  # shared types, <module>.types.ts
├── utils/                  # pure helpers (cn, format, validators)
├── constants/              # routes, navigation, options
└── styles/                 # global CSS + theme tokens
```

## Component folder pattern (shared components)
Simple components are a single file: `components/ui/Button.tsx`.
Bigger ones get a folder:
```
components/ui/DatePicker/
├── DatePicker.tsx
├── CalendarGrid.tsx      # sub-parts
├── useDatePicker.ts      # logic hook
└── index.ts              # public export
```

## Placement rules
1. Used by **one** screen → `pages/<module>/components/`.
2. Used by a **second** screen → move it to `components/ui` (primitive) or `components/common` (composite), and update both imports.
3. **Primitives** (`ui/`) have no business logic and no data fetching.
4. **Composites** (`common/`) combine primitives into reusable patterns.
5. Pages compose components and call services. They don't contain big inline UI blocks that could be components.

## Naming
- Components: `PascalCase.tsx`
- Hooks: `useThing.ts`
- Everything else: `camelCase.ts`
- Per-module files: `<module>.service.ts` and `<module>.types.ts`
