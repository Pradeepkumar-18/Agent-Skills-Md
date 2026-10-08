# ui-architect

A senior **UI/UX lead and UI architect** skill for **React + TypeScript + Tailwind CSS** projects. It plans, advises, and writes the code once you approve the plan.

Works with **Antigravity**, **Gemini CLI**, **Codex CLI** and **Claude Code** (Agent Skills `SKILL.md` format).

---

## What it covers

| Area | What it does | Flow file |
|---|---|---|
| **Existing projects** | Follows your codebase, analyses it (8 areas, High/Medium/Low), asks about inconsistent patterns only when they matter | `flows/existing-project.md` |
| **New projects** | Idea → structure → density + theme (optional HTML preview) → state, auth, formatting, pages → setup (env, aliases, lint, error pages, mocks, `/dev/ui` showcase, README) | `flows/new-project.md` |
| **Features** | Understand → context (API contract, impact) → slices for large features → plan with acceptance criteria and a wireframe → build → hand-over | `flows/feature.md` |
| **Small changes** | Short path for changes that touch 2 files or fewer, with no new component, route or API call | `flows/feature.md` |
| **Reference images** | Reads a screenshot or mock-up, confirms what it sees, maps it to your tokens and icons, compares the result | `flows/reference-image.md` |
| **Bug fixes** | Root cause → minimal fix → report the same bug elsewhere → verify. Extra checks per bug type, "fix this" with an image, hotfix mode | `flows/bug-fix.md` |
| **Improvements** | Acts on the analysis in safe batches, refactors without changing behaviour, fixes a pattern everywhere (pilot → rollout) | `flows/improvements.md` |
| **UI/UX review** | Reviews a screen or PR for UX, consistency, states, accessibility and text. Report only | `flows/review.md` |
| **Design system** | Shared components (API, variants, states, accessibility), theme change, rebrand, adding dark mode, density change, as token migrations | `flows/design-system.md` |
| **Migrations** | Old → new screen cut-overs, library or Tailwind upgrades in batches | `flows/migration.md` |

### How it behaves
- Gives **one recommendation with the reason**, and **pushes back** on choices that hurt UX or architecture.
- Points out **UX problems you didn't ask about**.
- Stops for approval only at **major decisions**.
- **You stay in control:** "skip the checkpoints", reject any step, go back to an earlier decision.
- **Never commits** or pushes unless you ask. **Never writes tests** unless you ask.

### Rules it always follows
- **Your existing code wins.** It never adds Tailwind, TypeScript or libraries unasked, and writes code for your installed versions.
- **Custom components only:** no browser-default controls (date picker, checkbox, select…) and no UI libraries. Every control is a custom, reusable component: `Input, Textarea, NumberInput, Select, MultiSelect, Checkbox, Radio, Switch, DatePicker, DateRangePicker, TimePicker, FileUpload`. In existing projects, a missing one is built first, with your OK.
- **Basic form validation for every field:** required, type, length, value range, allowed characters and format, each with a clear error message. **Official formats** (PAN, GSTIN, IFSC, phone, pincode, email…) are **checked on the web**, not assumed. Without web access, a rule is marked "unverified – please confirm".
- **Reuse first.** New code goes in new components or hooks, so giant files don't keep growing.
- **Touched-code rule:** it fixes small problems only in lines it's already changing, and reports the rest.
- **Every hand-over includes:** files changed, assumptions, a **manual check list** ("open X → do Y → expect Z"), **affected screens**, and open decisions.

---

## Flows at a glance

### Existing project: first use
| Your first request | What it does |
|---|---|
| "Analyse this project", or no specific task | Full analysis |
| A feature | Short analysis (top 5 + relevant inconsistencies), then the feature |
| A small change or a bug | Does it, then offers the analysis |

### New project
```
Idea ─► Structure ─► Density + theme format ─► Theme (+ HTML preview)
  ─► State, auth, formatting, pages, build order ─► Setup ─► Pages (feature flow)
```

### Feature
```
Understand (OK) ─► Context ─► Size check (slices) ─► Plan (OK) ─► Build ─► Self-review ─► Hand-over
```
The plan includes:
- acceptance criteria
- an ASCII wireframe
- the API contract (from types, docs or the backend repo; never guessed)
- edge data handling
- URL state
- an unsaved-changes guard
- navigation updates
- the final wording
- the impact list

Large features are split into slices and saved to `docs/plans/` so another session can continue.

### Bug fix
```
Understand ─► Root cause ─► Classify (UI / API / backend) ─► Minimal fix ─► Same bug elsewhere? ─► Verify
```
- **Extra checks by bug type:** mobile layout (360/768/1280), slowness (measure first), accessibility, forms, popups.
- **"Fix this" with an image:** first works out whether the image shows **the bug**, **the target design**, or **the spec to match**. For the spec, it runs a *current → expected* mismatch fix.
- **Hotfix mode** ("urgent", "production is broken"): smallest safe fix, no checkpoints, plus a follow-up note.

### Improvements
```
Findings ─► Batch plan (OK) ─► Batch 1 ─► hand-over ─► Batch 2 ─► …
```
- Fixing a pattern everywhere: shared component → pilot on one screen → roll out in batches.

### Theme change or dark mode (existing projects, only when you ask)
```
Audit ─► Semantic tokens (CSS variables, :root/.dark) ─► Mapping table ─► Preview ─► Batches
```

---

## Quality bar (every screen it builds or changes)
- **Responsive** from 360px to desktop, with 44px touch targets on mobile
- **Accessible:** keyboard, focus, labels, contrast, focus-trapped dialogs
- **States:** loading, empty, error, success and no permission are designed
- **Edge data:** long text, 0 / 1 / many items, large numbers, slow network
- **Forms:** basic per-field validation (official formats verified on the web), inline errors, a loading submit button, server errors, an unsaved-changes warning
- **Text:** clear and specific; goes through i18n if the project has it; RTL-safe
- **Typed:** no new `any`
- **Dark mode:** included in new projects. In existing projects that already have it, new colours get dark values; in projects without it, it's built only when you ask.

## Default stack (new projects only)
React + TS (strict) + Vite · Tailwind v4 (`@theme` tokens) · React Router · axios (no TanStack Query) · React Hook Form + Zod · lucide-react · custom components (no library) · global state chosen per project · no tests unless asked.

In existing projects, **your stack always wins**.

---

## Files

```
ui-architect/
├── SKILL.md                       # core: role, mode detection, rules, quality bar, routing table
├── README.md                      # this file (for humans)
├── flows/                         # loaded only when that task comes up
│   ├── existing-project.md
│   ├── new-project.md
│   ├── feature.md
│   ├── reference-image.md
│   ├── bug-fix.md
│   ├── improvements.md
│   ├── review.md
│   ├── design-system.md
│   └── migration.md
└── templates/                     # loaded only when a flow needs them
    ├── analysis-template.md
    ├── batch-plan-template.md
    ├── decisions-template.md
    ├── feature-plan-template.md
    └── folder-structure.md
```

## Token cost

| Part | Approx. tokens | Loaded |
|---|---|---|
| Name + description | ~170 | Always |
| `SKILL.md` core | ~2,700 | When the skill triggers |
| One flow | ~350–1,150 | Only the flow for the current task |
| One template | ~200–750 | Only when the flow needs it |
| **Typical run** (core + one flow + one template) | **~3,000–5,000** | |

Most of the cost in real use is reading your code, not the skill.

---

## Installation (per project, Antigravity)

From your **project root** (the folder with `package.json`):

```powershell
# 1. Get the skill (once)
git clone https://github.com/Pradeepkumar-18/Agent-Skills-Md.git "$env:USERPROFILE\Agent-Skills-Md"

# 2. Copy it into the project, including subfolders
New-Item -ItemType Directory -Force ".agent\skills" | Out-Null
Copy-Item "$env:USERPROFILE\Agent-Skills-Md\ui-architect" ".agent\skills\" -Recurse -Force
```

Result:
```
your-project/
└── .agent/skills/ui-architect/
    ├── SKILL.md
    ├── README.md
    ├── flows/      (9 files)
    └── templates/  (5 files)
```

- **Gemini CLI:** same, but into `.agents\skills\`.
- **Personal install for all projects:** see the [repo README](../README.md).

### Updating
```powershell
cd "$env:USERPROFILE\Agent-Skills-Md"; git pull; cd -
Remove-Item ".agent\skills\ui-architect" -Recurse -Force
Copy-Item "$env:USERPROFILE\Agent-Skills-Md\ui-architect" ".agent\skills\" -Recurse -Force
```
Delete the old folder before copying, so files that were moved or removed don't linger.

## Usage

Open the project root in Antigravity, start a **new conversation**, then:

| Goal | Prompt |
|---|---|
| Analyse a project | *"Use the ui-architect skill and analyse this project."* |
| Fix the analysis findings | *"Use ui-architect to fix the High items, one batch at a time."* |
| New project | *"Use ui-architect. I want to build a CRM for small sales teams."* |
| Feature | *"Use ui-architect to add a follow-up calls feature for leads."* |
| Small change | *"Use ui-architect to add a status column to the leads table."* |
| From an image | *"Use ui-architect to build a sidebar like this"* + image |
| Bug | *"Use ui-architect: the Add Stock popup doesn't close when I click outside."* |
| Bug + screenshot | *"Use ui-architect to fix this"* + screenshot |
| Match a design | *"Use ui-architect: this popup doesn't match the design, fix it"* + design |
| Hotfix | *"Use ui-architect, urgent: checkout button does nothing in production."* |
| Review | *"Use ui-architect to review the products page for UX."* |
| Shared component | *"Use ui-architect to create a shared Modal and move the popups to it."* |
| Dark mode | *"Use ui-architect to add dark mode."* |
| Density | *"Use ui-architect to make the app more compact."* |
| Migration | *"Use ui-architect to plan the Tailwind v3 → v4 upgrade."* |

It also triggers automatically when your request matches. Naming it makes sure it's used.
