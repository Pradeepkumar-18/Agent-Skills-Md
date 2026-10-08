# Agent Skills

Reusable **Agent Skills** (`SKILL.md` format) for AI coding agents. They work with **Antigravity**, **Gemini CLI**, **Codex CLI** and **Claude Code**.

A skill is a folder with a `SKILL.md` file (instructions plus a `name` and `description`) and optional supporting files. The agent reads the description and loads the skill when your request matches it, or when you name the skill in your prompt.

## Skills in this repo

| Skill | What it does |
|---|---|
| [ui-architect](ui-architect/) | Senior frontend lead, UI/UX lead and UI architect for **React + TypeScript + Tailwind CSS** projects |

---

## ui-architect

Acts as the most senior UI/UX lead and UI architect on your project. It plans, advises and writes the code once you approve the plan.

### What it does

- **Detects the mode automatically**
  - **Existing project** (`package.json` + `src/` present): follows your codebase's existing patterns and changes them only when you ask.
  - **New project:** sets everything up from scratch.
- **Analyses existing code** on first use, and whenever you ask. The result is a pointed list covering folder structure, component reuse, Tailwind usage, TypeScript quality, accessibility, responsiveness, performance and consistency. Every point gets a **High / Medium / Low** priority.
- **Guides new projects step by step:** understand the idea → folder structure → UI density (dense or simple) → theme → global state → page list → build.
- **Builds features** with a plan-first flow: understand → check context → plan (needs your approval) → code → self-review → summary.
- **Remembers decisions** in `docs/ui-decisions.md` inside your project, so later sessions don't ask again.
- **Holds every screen to a quality bar:** responsive, dark mode, accessibility, and loading/empty/error states.

### Default stack (new projects)

React + TypeScript + Vite · Tailwind CSS · React Router · axios (no TanStack Query) · React Hook Form + Zod · lucide-react · custom-built components (no component library) · global state chosen per project.

In existing projects, the project's own stack and patterns always win.

### Files

```
ui-architect/
├── SKILL.md                   # main instructions (required)
├── analysis-template.md       # format of the codebase analysis
├── decisions-template.md      # template for docs/ui-decisions.md
├── feature-plan-template.md   # plan shown for approval before coding
└── folder-structure.md        # recommended structure for new projects
```

---

## Installation

Clone the repo once:

```powershell
git clone https://github.com/Pradeepkumar-18/Agent-Skills-Md.git "$env:USERPROFILE\Agent-Skills-Md"
```

Then copy the skill folder to where your tool looks for skills. Keep the folder name `ui-architect`, and keep all files directly inside it.

### Per project (shared with your team through the repo)

From your **project root** (the folder with `package.json`):

```powershell
$src = "$env:USERPROFILE\Agent-Skills-Md\ui-architect"

# Antigravity: .agent\skills (no "s" after agent)
New-Item -ItemType Directory -Force ".agent\skills\ui-architect" | Out-Null
Copy-Item "$src\*" ".agent\skills\ui-architect\" -Force

# Gemini CLI: .agents\skills
New-Item -ItemType Directory -Force ".agents\skills\ui-architect" | Out-Null
Copy-Item "$src\*" ".agents\skills\ui-architect\" -Force
```

Result:

```
your-project/
├── .agent/skills/ui-architect/SKILL.md    ← Antigravity
├── .agents/skills/ui-architect/SKILL.md   ← Gemini CLI
├── src/
└── package.json
```

### Personal (available in all your projects)

| Tool | Folder |
|---|---|
| Antigravity | `%USERPROFILE%\.gemini\config\skills\ui-architect\` (older versions: `.gemini\antigravity\skills\`) |
| Gemini CLI | `%USERPROFILE%\.gemini\skills\ui-architect\` |
| Codex CLI | `%USERPROFILE%\.codex\skills\ui-architect\` |
| Claude Code | `%USERPROFILE%\.claude\skills\ui-architect\` |

No environment variables are needed. `$env:USERPROFILE` is Windows' built-in path to your user folder. On macOS/Linux, use `~` instead.

---

## Usage

1. **Open the project root** as your workspace (the folder that contains `.agent/` or `.agents/`).
2. **Start a new conversation**, so the agent picks up newly added skills.
3. **Check it's loaded:** ask *"What skills do you have available?"* The list should include `ui-architect`.
4. **Use it.** The skill loads automatically when your request matches. To be sure, name it:

| Goal | Prompt |
|---|---|
| Analyse an existing project | *"Use the ui-architect skill and analyse this project."* |
| Start a new project | *"Use the ui-architect skill. I want to build a CRM for small sales teams."* |
| Build a feature | *"Use ui-architect to add a follow-up calls feature for leads."* |
| Small change | *"Use ui-architect to add a status column to the leads table."* |

The skill **stops for your approval** at major decisions: the idea summary, folder structure, density and theme, the page list, and every feature plan. Between those points it works on its own.

### Troubleshooting

| Problem | Fix |
|---|---|
| Skill not listed | Check the path. Antigravity needs `.agent`, Gemini CLI needs `.agents`, and the folder must be named `ui-architect` |
| Still not listed | The file must be named exactly `SKILL.md`, and line 1 must be `---` |
| Not picked up after copying | Start a new conversation or reload the window |
| Wrong project detected | Open the project root as the workspace, not a parent or child folder |

---

## Updating

```powershell
cd "$env:USERPROFILE\Agent-Skills-Md"
git pull
```

Then run the copy commands again for each project or tool you use.
