# Flow: New project

Go in this order. Steps 1–5 each end with a **checkpoint**: present it, recommend, and wait for the user's OK. Steps 6–7 run without stopping, except for the feature-flow checkpoints.

## 1. Understand the idea
- Ask about purpose, target users, domain, main screens and flows, devices, brand, and products they like the look of. Also ask whether there is a backend/API yet, and whether it has docs.
- If their first message already answers some of these, don't re-ask.
- Summarise your understanding, give your recommended UI direction, and ask the decisions-file question in the same message. → *Checkpoint*

## 2. Folder structure
Propose a structure based on `templates/folder-structure.md`, adapted to this project. Explain the key choices. → *Checkpoint*

## 3. Density and theme format
- Ask: **dense** (data-heavy, compact) or **simple** (spacious, focused)? Recommend one. This becomes the project default.
- In the same message ask **how many theme options** and **in what form**: a written description, tokens, or a **visual preview**. → *Checkpoint*

## 4. Theme
Present the options: colours (light + dark), typography, radius, spacing, shadows, with your recommendation.

**Visual preview:** if chosen, generate one self-contained HTML file (`docs/theme-preview.html`), with no build step. Show each option side by side in light and dark:
- the palette swatches
- the type scale
- buttons (all variants and states)
- an input with an error
- a table row, a card, a badge and a toast

Tell the user to open it in a browser, or open it yourself if your tool has a browser. → *Checkpoint*

## 5. App foundations, pages and flows
Recommend each of these, all in one message:
- **Global state:** Context, Zustand or Redux Toolkit, with the reason.
- **Auth and access:**
  - login and logout
  - where the token lives (recommend an httpOnly cookie if the backend supports it, otherwise memory + refresh token; avoid localStorage for long-lived tokens)
  - protected routes and role guards
  - an expired session (401) clears the session and redirects to login with a "session expired" message
- **Formatting:** locale, currency, and date and number formats (e.g. `en-IN`, ₹), decided once and used through `utils/format.ts`.
- **Pages:** the list of pages, the layout shell and the main user flows.
- **Page build order:** shell and auth first, then the most-used page, then the rest. Settings and rarely used pages come last.

→ *Checkpoint*

## 6. Set up
Scaffold and confirm each of these:
- **Base:**
  - Vite + React + TS (strict)
  - path alias `@/` → `src/`
  - ESLint + Prettier
  - `.env.example` with `VITE_API_BASE_URL` (never commit real `.env` values)
- **Theme:** tokens with light and dark values, and a class-based dark mode toggle.
- **API layer:**
  - `services/apiClient.ts` (axios) with the base URL, an auth header and the 401 interceptor
  - error normalising into one `ApiError` type
- **Backend not ready:** build services against a **mock layer** (`services/mocks/`) that returns data typed with the real types. One flag switches mock vs real (`VITE_USE_MOCKS`). Mark each mock with the endpoint it stands in for.
- **App safety:**
  - an error boundary around routes
  - 404 and 403 pages
  - a global toast
  - a shared confirm dialog
- **Layout shell:** navigation, header and the responsive drawer on mobile.
- **Base shared components** in `components/ui/`, including the full custom form-control set from `SKILL.md` (no native or library controls), plus shared validators in `utils/validators.ts` for official formats.
- **UI showcase page** at `/dev/ui`, dev builds only: every shared component in every state, with a light/dark toggle. Update it whenever a shared component is added.
- **Project README:** how to install, run and build; the env variables; a folder guide; and the main conventions (or a link to `docs/ui-decisions.md`).

Summarise the files created, update the decisions file, and continue.

## 7. Pages
Build each page in the agreed order using `flows/feature.md`.

## Default stack (new projects only)

| Area | Choice |
|---|---|
| Base | React + TypeScript (strict) + Vite |
| Styling | Tailwind CSS latest (v4: tokens with `@theme`), class-based dark mode |
| Routing | React Router |
| API | `axios`: one configured client plus one service file per module. **No TanStack Query.** Loading and error state live in components or small hooks |
| Forms | React Hook Form + Zod; schemas in `src/schemas/<module>.schema.ts` |
| Icons | `lucide-react` |
| Components | **Built yourself.** No component library |
| Global state | Decided at step 5 |
| Tests | None unless the user asks |

**Mobile:** whatever the density, small screens get 44px touch targets and stacked or card layouts where tables don't fit.
