# Recommended folder structure (new projects)

Starting point only. Adapt it to the project, explain the changes, and let the user modify it.

```
src/
├── main.tsx                 # entry: providers + router
├── App.tsx                  # root layout / router outlet
├── routes/                  # route definitions, guards
├── layouts/                 # app shell: sidebar, header, auth layout
├── pages/
│   └── <module>/            # one folder per module
│       ├── <Module>Page.tsx
│       └── components/      # components used only by this module
├── components/
│   ├── ui/                  # built-from-scratch primitives: Button, Input, Select, Dialog, Table, Badge…
│   └── common/              # shared composites: PageHeader, EmptyState, ErrorState, ConfirmDialog…
├── services/
│   ├── apiClient.ts         # single axios instance: base URL, interceptors, error normalising
│   └── <module>.service.ts
├── types/
│   └── <module>.types.ts
├── schemas/
│   └── <module>.schema.ts   # Zod schemas
├── hooks/                   # shared hooks (useDebounce, useDisclosure, useAsync…)
├── store/                   # only if global state is chosen
├── utils/                   # pure helpers (formatting, dates)
├── constants/
├── styles/
│   └── index.css            # Tailwind entry + theme tokens (light + dark)
└── assets/
```

## Principles
- **Module-first:** anything used by one module stays inside `pages/<module>/`. Move it to `components/` only once a second module needs it.
- **`ui/` holds no business logic.** Primitives take props only and never call APIs.
- **Pages don't call axios directly.** They always go through `services/`.
- **One naming style:** PascalCase for components, camelCase for everything else, `<module>.<kind>.ts` for services, types and schemas.
