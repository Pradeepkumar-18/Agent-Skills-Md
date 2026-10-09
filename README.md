# Agent Skills

A collection of reusable **Agent Skills** (`SKILL.md` format) for AI coding agents. They work with **Antigravity**, **Gemini CLI**, **Codex CLI** and **Claude Code**.

A skill is a folder with a `SKILL.md` file (instructions plus a `name` and `description`) and optional supporting files. The agent reads the description and loads the skill when your request matches it, or when you name the skill in your prompt.

## Skills

| Skill | What it does | Docs |
|---|---|---|
| [ui-architect](ui-architect/) (v3.0.1) | Keeps a **React + TypeScript + Tailwind** frontend consistent: reuses components first, extracts repeated UI into **customisable shared components**, keeps a component inventory, follows an agreed **project structure**, and asks you before structural decisions | [README](ui-architect/README.md) |

Each skill has its own README with its full behaviour, flows and usage examples.

---

## Installation

Clone the repo once:

```powershell
git clone https://github.com/Pradeepkumar-18/Agent-Skills-Md.git "$env:USERPROFILE\Agent-Skills-Md"
```

Then copy the skill folder you want to where your tool looks for skills. Copy the **whole folder, including its subfolders** (e.g. `references/`, `templates/`), and keep the folder name the same as the skill name. In the commands below, replace `<skill-name>` with a folder from the table above, e.g. `ui-architect`.

### Per project (shared with your team through git)

From your **project root**:

```powershell
$skill = "<skill-name>"
$src = "$env:USERPROFILE\Agent-Skills-Md\$skill"

# Antigravity: .agent\skills (no "s" after agent)
New-Item -ItemType Directory -Force ".agent\skills" | Out-Null
Copy-Item $src ".agent\skills\" -Recurse -Force

# Gemini CLI: .agents\skills
New-Item -ItemType Directory -Force ".agents\skills" | Out-Null
Copy-Item $src ".agents\skills\" -Recurse -Force
```

Result:

```
your-project/
├── .agent/skills/<skill-name>/SKILL.md    ← Antigravity
├── .agents/skills/<skill-name>/SKILL.md   ← Gemini CLI
└── ...
```

### Personal (available in all your projects)

| Tool | Folder |
|---|---|
| Antigravity | `%USERPROFILE%\.gemini\config\skills\<skill-name>\` (older versions: `.gemini\antigravity\skills\`) |
| Gemini CLI | `%USERPROFILE%\.gemini\skills\<skill-name>\` |
| Codex CLI | `%USERPROFILE%\.codex\skills\<skill-name>\` |
| Claude Code | `%USERPROFILE%\.claude\skills\<skill-name>\` |

No environment variables are needed. `$env:USERPROFILE` is Windows' built-in path to your user folder. On macOS/Linux, use `~` instead.

---

## Usage

1. **Open the project root** as your workspace.
2. **Start a new conversation**, so the agent picks up newly added skills.
3. **Check it's loaded:** ask *"What skills do you have available?"*
4. **Use it.** Skills load automatically when your request matches. To be sure, name the skill: *"Use the ui-architect skill to …"*

### Troubleshooting

| Problem | Fix |
|---|---|
| Skill not listed | Check the path. Antigravity needs `.agent`, Gemini CLI needs `.agents`, and the folder name must match the skill name |
| Still not listed | The file must be named exactly `SKILL.md`, and line 1 must be `---` |
| Not picked up after copying | Start a new conversation or reload the window |
| Wrong project detected | Open the project root as the workspace, not a parent or child folder |

## Sync script

`scripts/sync-skills.ps1` installs or updates skills in **all your projects at once**. It runs on Windows PowerShell 5.1+.

For each project it:
1. runs `git pull` on this repo
2. mirrors each skill into the project (new files added, changed files updated, removed files deleted)
3. prints the installed version

It only ever touches `<project>\.agent\skills\<skill>` (and `.agents\skills\<skill>` for Gemini CLI).

**One-time setup:** copy `sync-projects.example.txt` to `sync-projects.txt` and list your project root folders, one per line. `sync-projects.txt` is git-ignored.

```powershell
cd "$env:USERPROFILE\Agent-Skills-Md"

.\scripts\sync-skills.ps1                                   # all projects in sync-projects.txt (Antigravity)
.\scripts\sync-skills.ps1 -DryRun                           # preview only, changes nothing
.\scripts\sync-skills.ps1 -Tool both                        # Antigravity (.agent) + Gemini CLI (.agents)
.\scripts\sync-skills.ps1 -Projects "D:\work\crm-ui"        # specific project(s)
.\scripts\sync-skills.ps1 -Skills ui-architect              # specific skill(s)
.\scripts\sync-skills.ps1 -Personal codex,gemini            # personal folders (all projects) for those tools
.\scripts\sync-skills.ps1 -NoPull                           # skip git pull
```

If PowerShell blocks the script, run it once with `powershell -ExecutionPolicy Bypass -File .\scripts\sync-skills.ps1`.

After syncing, start a **new conversation** in your tool so it loads the updated skill.

## Updating by hand

```powershell
cd "$env:USERPROFILE\Agent-Skills-Md"
git pull
```

Then, for each project or tool, **delete the old skill folder** and run the copy commands again. Deleting first makes sure files that were moved or removed don't linger.

---

## Adding a new skill

Each skill is a top-level folder:

```
<skill-name>/
├── SKILL.md      # required: frontmatter (name, description) + instructions for the agent
├── README.md     # for humans: what it does, flows, usage
└── *.md          # optional templates/reference files linked from SKILL.md
```

Conventions:
- The folder name must equal `name:` in `SKILL.md`. Use lowercase-kebab-case.
- `description` says **what** the skill does and **when** to use it (and when not to). It's the only part the agent sees before loading the skill.
- Keep `SKILL.md` focused. Move long reference material into separate files that it links to.
- Keep wording tool-neutral, with no tool-specific commands, so it works in every agent.
- Add a row to the **Skills** table above.
