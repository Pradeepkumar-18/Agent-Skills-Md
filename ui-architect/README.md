# ui-architect

Keeps a **React + TypeScript + Tailwind** frontend **consistent, reusable and well-structured**. Works with **Antigravity**, **Gemini CLI**, **Codex CLI** and **Claude Code** (Agent Skills `SKILL.md` format).

**Version 3.0.0** (see [CHANGELOG.md](CHANGELOG.md))

## The idea: 5 pillars

| Pillar | What the skill does |
|---|---|
| **Consistency** | Theme tokens, density and "one way to do each thing" (one dialog pattern, one table pattern…) followed everywhere |
| **Reuse** | Checks the **component inventory** before writing any UI and climbs the **reuse ladder**. Never copy-pastes |
| **Reusable, customisable components** | Repeated UI becomes one shared component with a flexible API: variants, sizes, `className`, slots/children, tokens only |
| **Project structure** | Every file goes in the agreed place; components move to the shared folder on their second use |
| **User control** | You approve the structure, theme/density and **every new shared component's API**. Everything else follows your decisions |

It acts as the frontend's **architect, not a visual designer**. It follows your design and uses conventional patterns (one table for a list, visible action buttons) rather than inventing new ones.

## The reuse ladder
Before writing any UI, it stops at the first step that fits:
1. **Use** an existing shared component
2. **Configure** it with its props and variants
3. **Extend** it with a new variant, size, slot or prop (backward-compatible)
4. **Compose** existing components
5. **Extract** a new shared component on the second use, and replace the first copy too
6. **Local UI** only when it's truly unique to one screen

## Component standard (short version)
- **Critical:** extend, don't copy · tokens only · backward-compatible changes
- **High:**
  - variants instead of boolean piles
  - `className` + `...rest` + `ref`
  - children, slots or compound parts for custom content
  - accessible by default (visible actions, focus, labels)
  - complete custom form controls (label/hint/error, min/max, date limits)
- **Medium:** sensible defaults · one job per component (about 200 lines or fewer) · no data fetching in shared UI · recorded in the inventory

See [references/component-standard.md](references/component-standard.md) for the full rules with wrong/right examples.

## When it stops for your OK
- Project structure (new project or reorganising)
- Theme and density
- **A new shared component**: you see its name, location, props, variants, slots and which copies it replaces
- A breaking change to an existing shared component
- The first analysis of an existing project

## Project memory (asked once per project)
- `docs/ui-decisions.md`: stack, structure, theme, density, "one way to do each thing"
- `docs/components.md`: the **component inventory** (name, purpose, props, variants, slots)

If you decline them, the skill rebuilds the inventory by searching your components folder, and lists decisions in each hand-over.

## Other rules
- **Existing code wins:** your styling approach, API layer, state and UI library (if you use one, it builds on it).
- **Custom form controls** in projects without a UI library: no browser-default date picker, checkbox or select.
- **Basic validation** per field; official formats (PAN, GSTIN, IFSC, phone, pincode…) are checked on the web.
- **Red flags** it fixes before handing over: copy-pasted components, boolean piles, raw colours, split tables, hover-only actions, invented patterns.
- It never commits, writes tests, or changes the backend unless you ask.

## Files
```
ui-architect/
├── SKILL.md                         # core (~1,950 tokens)
├── README.md · CHANGELOG.md · TESTING.md
├── references/                      # loaded only when needed
│   ├── component-standard.md        # how shared components are built/extended (with examples)
│   ├── project-structure.md         # structure + placement rules
│   └── analysis.md                  # focused analysis format
└── templates/                       # used to create the project memory files
    ├── components.md                # → docs/components.md
    └── ui-decisions.md              # → docs/ui-decisions.md
```

## Install / update
Use the sync script from the repo root (see the [repo README](../README.md#sync-script)):
```powershell
.\scripts\sync-skills.ps1            # updates every project in sync-projects.txt
.\scripts\sync-skills.ps1 -DryRun    # preview
```
Or copy the whole `ui-architect` folder into `<project>\.agent\skills\` (Antigravity) or `.agents\skills\` (Gemini CLI). Delete the old folder first.

## Usage
| Goal | Prompt |
|---|---|
| Analyse | *"Use the ui-architect skill and analyse this project."* |
| Build UI | *"Use ui-architect: show my tasks in a table with edit and delete."* |
| New shared component | *"Use ui-architect to create a reusable DatePicker."* |
| Clean up duplication | *"Use ui-architect: these pages repeat the same card markup, make it one component."* |
| Structure | *"Use ui-architect: where should this new hook go?"* |
| New project | *"Use ui-architect. New expense tracker app."* |

See [TESTING.md](TESTING.md) for test prompts with expected behaviour.
