# Recommended folder structure (new projects)

Starting point only. Adapt it to the project, explain the changes, and let the user modify it.

```
<frontend-root>/
├── .env.example              # VITE_API_BASE_URL, VITE_USE_MOCKS (never commit real .env)
├── README.md                 # install, run, build, env, folder guide, conventions
├── docs/
│   ├── ui-decisions.md       # decisions file (if allowed)
│   ├── plans/                # multi-session feature plans
│   └── theme-preview.html    # optional theme preview
└── src/
    ├── main.tsx              # entry: providers + router
    ├── App.tsx               # root layout / router outlet
    ├── routes/               # route tree, auth guard, role guard
    ├── layouts/              # app shell (sidebar, header, mobile drawer), auth layout
    ├── pages/
    │   ├── <module>/         # one folder per module
    │   │   ├── <Module>Page.tsx
    │   │   └── components/   # used only by this module
    │   ├── errors/           # NotFoundPage (404), ForbiddenPage (403)
    │   └── dev/              # UiShowcasePage (/dev/ui, dev builds only)
    ├── components/
    │   ├── ui/               # primitives: Button, Input, Select, Dialog, Table, Badge, Toast…
    │   └── common/           # composites: PageHeader, EmptyState, ErrorState, ConfirmDialog, ErrorBoundary…
    ├── features/auth/        # login/logout, session store, useAuth, token handling
    ├── services/
    │   ├── apiClient.ts      # single axios instance: base URL, auth header, 401 interceptor, ApiError
    │   ├── <module>.service.ts
    │   └── mocks/            # typed mocks while the backend isn't ready
    ├── types/                # <module>.types.ts
    ├── schemas/              # <module>.schema.ts (Zod)
    ├── hooks/                # useDebounce, useDisclosure, useUnsavedChangesGuard, useUrlState…
    ├── store/                # only if global state is chosen
    ├── utils/                # format.ts (dates, numbers, currency), helpers
    ├── constants/            # routes, roles, navigation config
    ├── styles/
    │   └── index.css         # Tailwind entry + theme tokens (light + dark)
    └── assets/
```

## Principles
- **Module-first:** anything used by one module stays inside `pages/<module>/`. Move it to `components/` only once a second module needs it.
- **`ui/` holds no business logic.** Primitives take props only and never call APIs.
- **Pages never call axios directly.** They always go through `services/`.
- **Navigation is config-driven** (`constants/navigation.ts`), including role visibility.
- **One naming style:** PascalCase for components, camelCase for everything else, `<module>.<kind>.ts` for services, types and schemas.
- **Path alias:** `@/` → `src/`.
