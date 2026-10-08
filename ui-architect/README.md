# ui-architect

A senior **UI/UX lead and UI architect** skill for **React + TypeScript + Tailwind CSS** projects. It plans, advises, and writes the code once you approve the plan.

Works with **Antigravity**, **Gemini CLI**, **Codex CLI** and **Claude Code** (Agent Skills `SKILL.md` format).

---

## What it does

| Capability | Summary |
|---|---|
| **Two modes** | Detects whether the project is **new** or **existing**. It finds the frontend by looking for the `package.json` that lists React, so monorepos work too |
| **Existing projects** | Follows your codebase's patterns and tools. It never adds Tailwind, TypeScript or libraries unless you ask |
| **Analysis** | A pointed list of findings in 8 areas: current state → problem → improvement → **High / Medium / Low** |
| **New projects** | Step by step: idea → folder structure → density + theme format → theme → state, pages and flows → build |
| **Features** | Plan-first: understand → context → plan (your approval) → build → self-review → summary |
| **Small changes** | Short path for changes that touch 2 files or fewer, with no new component, route or API call |
| **Reference images** | Reads a screenshot or mock-up, confirms what it sees, maps it to your tokens and icons, and compares the result |
| **Bug fixes** | Finds the root cause, fixes it minimally, reports the same bug elsewhere, and verifies |
| **Memory** | Keeps `docs/ui-decisions.md` in your project, after **asking once per project** |

### How it behaves
- Gives **one recommendation with the reason**, not a menu of options.
- **Pushes back** on choices that hurt UX or architecture, then does what you decide.
- Points out **UX problems you didn't ask about**.
- Stops for approval only at **major decisions**.
- **You stay in control.** Say "skip the checkpoints", reject any step, or go back to an earlier decision.

---

## Flows

### Existing project: first use
| Your first request | What it does |
|---|---|
| "Analyse this project", or no specific task | Full 8-area analysis |
| A feature | Short analysis (top 5 + relevant inconsistencies), then straight into the feature |
| A small change | Does the change, then offers the analysis |

The decisions-file question and any inconsistent-pattern questions come in **the same message**.

**Inconsistent patterns:** it asks only when the choice affects the feature. Otherwise it follows the newest or documented pattern and tells you.

### Analysis areas
1. Folder structure
2. Component reuse and duplication
3. Styling usage (tokens vs hard-coded values)
4. TypeScript quality
5. Accessibility
6. Responsiveness
7. Performance
8. Consistency between screens

Each finding is backed by real file paths, and the analysis ends with the **top 5 to fix first**.

### New project
```
Idea + recommendation ─► Folder structure ─► Density + theme format ─► Theme
   ─► State + pages + flows ─► Set up ─► Pages (feature flow)
```
Each arrow is a checkpoint where it waits for your OK.

### Feature
```
Understand ─► Context ─► Plan ─► Build ─► Self-review ─► Hand-over
   (OK)                  (OK)
```
- The plan follows `feature-plan-template.md`: UX flow, components (new vs reuse), API, forms, states, quality checks, patterns followed, risks, build order.
- Missing backend endpoints are **specified in the plan** and built only if you approve.
- Build order: types → schemas (if used) → service → shared components → page → route/nav.

### Reference image
```
Read image ─► "What I see" (OK) ─► What the image can't show ─► Map to project ─► Plan ─► Build ─► Compare
```
- Colours map to your **existing tokens**. If they differ a lot, it asks "match exactly or adapt?" and recommends adapting.
- Icons are redrawn in your icon set, and spacing follows your density.
- **Logos and other brands' content are never copied**, only layout and style.
- After building, it compares a screenshot with the reference if the tool can take one.

### Bug fix
```
Understand ─► Root cause ─► Classify (UI / API / backend) ─► Minimal fix ─► Same bug elsewhere? ─► Verify ─► Summary
```
- It explains *why* the bug happens before fixing it.
- It **reports** the same bug in other places and the real fix (e.g. a shared component), without changing them.
- A local fix goes straight through. It stops only if the fix changes behaviour, touches a shared component, or needs backend changes.

---

## Quality bar (every screen it builds or changes)
- **Responsive** from mobile to desktop, with 44px touch targets on mobile
- **Accessible:** semantic HTML, keyboard reachable, visible focus, labels, contrast, focus-trapped dialogs
- **States:** loading, empty, error and success are designed
- **Forms:** inline validation, a loading submit button, server errors shown
- **Typed:** no new `any`
- **Dark mode:** included in new projects; in existing projects only **when you ask**

## Default stack (new projects only)
| Area | Choice |
|---|---|
| Base | React + TypeScript (strict) + Vite |
| Styling | Tailwind CSS (v4 `@theme` tokens), class-based dark mode |
| Routing | React Router |
| API | axios client + one service per module (no TanStack Query) |
| Forms | React Hook Form + Zod (`src/schemas/`) |
| Icons | lucide-react |
| Components | Built from scratch, no component library |
| Global state | Chosen per project |
| Tests | None unless asked |

In existing projects, **the project's own stack always wins**.

---

## Files

```
ui-architect/
├── SKILL.md                   # main instructions (what the agent loads)
├── README.md                  # this file (for humans)
├── analysis-template.md       # analysis format (full + short)
├── decisions-template.md      # template for docs/ui-decisions.md
├── feature-plan-template.md   # plan shown for approval before coding
└── folder-structure.md        # recommended structure for new projects
```

## Token cost
| Part | Approx. tokens | Loaded |
|---|---|---|
| Name + description | ~170 | Always |
| `SKILL.md` | ~4,000 | Only when the skill triggers |
| Each template | ~350–500 | Only when that step needs it |

Most of the cost in real use is reading your code, not the skill.

---

## Installation

Install it per project (shared with your team through git) from your **project root**:

```powershell
git clone https://github.com/Pradeepkumar-18/Agent-Skills-Md.git "$env:USERPROFILE\Agent-Skills-Md"

# Antigravity
New-Item -ItemType Directory -Force ".agent\skills\ui-architect" | Out-Null
Copy-Item "$env:USERPROFILE\Agent-Skills-Md\ui-architect\*" ".agent\skills\ui-architect\" -Force

# Gemini CLI
New-Item -ItemType Directory -Force ".agents\skills\ui-architect" | Out-Null
Copy-Item "$env:USERPROFILE\Agent-Skills-Md\ui-architect\*" ".agents\skills\ui-architect\" -Force
```

See the [repo README](../README.md) for personal (all-projects) install paths for each tool.

## Usage

| Goal | Prompt |
|---|---|
| Analyse a project | *"Use the ui-architect skill and analyse this project."* |
| New project | *"Use ui-architect. I want to build a CRM for small sales teams."* |
| Feature | *"Use ui-architect to add a follow-up calls feature for leads."* |
| Small change | *"Use ui-architect to add a status column to the leads table."* |
| From an image | *"Use ui-architect to build a sidebar like this"* + attach the image |
| Bug | *"Use ui-architect: the Add Stock popup doesn't close when I click outside."* |

It also triggers automatically when your request matches. Naming it makes sure it's used.
