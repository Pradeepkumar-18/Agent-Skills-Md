<#
.SYNOPSIS
  Installs or updates skills from this repo into your projects (and optionally your personal skill folders).

.DESCRIPTION
  For each project and each skill:
    1. (optional) git pull this repo
    2. delete the old copy of the skill in the project, so moved or removed files don't linger
    3. copy the fresh skill folder, including subfolders
    4. report the installed version
  Only the skill's own folder inside the tool's skills directory is ever deleted.

.EXAMPLE
  # Update all projects listed in sync-projects.txt (Antigravity):
  .\scripts\sync-skills.ps1

.EXAMPLE
  # Specific projects, for both Antigravity and Gemini CLI:
  .\scripts\sync-skills.ps1 -Projects "D:\work\crm-ui","D:\work\shop-ui" -Tool both

.EXAMPLE
  # Preview without changing anything:
  .\scripts\sync-skills.ps1 -DryRun

.EXAMPLE
  # Install into your personal skill folders (all projects) for Codex and Gemini CLI:
  .\scripts\sync-skills.ps1 -Personal codex,gemini
#>
[CmdletBinding()]
param(
    # Project root folders. If omitted, they're read from sync-projects.txt in the repo root.
    [string[]]$Projects,

    # Which skills to sync. Default: every folder in the repo that contains a SKILL.md.
    [string[]]$Skills,

    # Where skills go inside each project.
    [ValidateSet('antigravity', 'gemini', 'both')]
    [string]$Tool = 'antigravity',

    # Also (or only) install into personal skill folders for these tools.
    [ValidateSet('antigravity', 'gemini', 'codex', 'claude')]
    [string[]]$Personal,

    # Don't run "git pull" on this repo first.
    [switch]$NoPull,

    # Show what would happen without changing anything.
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

function Write-Step($text) { Write-Host "==> $text" -ForegroundColor Cyan }
function Write-Ok($text) { Write-Host "    OK   $text" -ForegroundColor Green }
function Write-Warn2($text) { Write-Host "    WARN $text" -ForegroundColor Yellow }

function Get-SkillVersion($skillDir) {
    $skillFile = Join-Path $skillDir 'SKILL.md'
    if (-not (Test-Path $skillFile)) { return 'unknown' }
    $line = Select-String -Path $skillFile -Pattern 'Skill version:\s*\**([0-9][0-9A-Za-z.\-]*)' | Select-Object -First 1
    if ($line) { return $line.Matches[0].Groups[1].Value }
    return 'unknown'
}

# 1. Update this repo
if (-not $NoPull) {
    Write-Step "Updating skills repo ($repoRoot)"
    if (Get-Command git -ErrorAction SilentlyContinue) {
        if ($DryRun) { Write-Ok 'would run: git pull' }
        else {
            git -C $repoRoot pull --ff-only
            if ($LASTEXITCODE -ne 0) { throw 'git pull failed. Fix the repo (or use -NoPull) and try again.' }
        }
    }
    else { Write-Warn2 'git not found; skipping pull' }
}

# 2. Find skills
$allSkills = Get-ChildItem -Path $repoRoot -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
    Select-Object -ExpandProperty Name
if (-not $Skills -or $Skills.Count -eq 0) { $Skills = $allSkills }
foreach ($s in $Skills) {
    if ($allSkills -notcontains $s) { throw "Skill '$s' not found in $repoRoot. Available: $($allSkills -join ', ')" }
}

# 3. Work out the target skills folders
$targets = @()

if (-not $Projects -or $Projects.Count -eq 0) {
    $listFile = Join-Path $repoRoot 'sync-projects.txt'
    if (Test-Path $listFile) {
        $Projects = Get-Content $listFile |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ -and -not $_.StartsWith('#') }
    }
}

$projectSubdirs = @()
if ($Tool -eq 'antigravity' -or $Tool -eq 'both') { $projectSubdirs += '.agent\skills' }
if ($Tool -eq 'gemini' -or $Tool -eq 'both') { $projectSubdirs += '.agents\skills' }

foreach ($p in $Projects) {
    if (-not (Test-Path $p -PathType Container)) { Write-Warn2 "Project not found, skipped: $p"; continue }
    if (-not (Test-Path (Join-Path $p 'package.json'))) { Write-Warn2 "No package.json in $p (is this the project root?) - installing anyway" }
    foreach ($sub in $projectSubdirs) { $targets += (Join-Path $p $sub) }
}

$personalDirs = @{
    'antigravity' = Join-Path $HOME '.gemini\config\skills'
    'gemini'      = Join-Path $HOME '.gemini\skills'
    'codex'       = Join-Path $HOME '.codex\skills'
    'claude'      = Join-Path $HOME '.claude\skills'
}
foreach ($t in $Personal) { $targets += $personalDirs[$t] }

if ($targets.Count -eq 0) {
    Write-Warn2 'Nothing to do. Pass -Projects, create sync-projects.txt in the repo root, or use -Personal.'
    exit 1
}

# 4. Sync
$results = @()
foreach ($target in $targets) {
    Write-Step $target
    foreach ($skill in $Skills) {
        $src = Join-Path $repoRoot $skill
        $dest = Join-Path $target $skill
        $oldVersion = if (Test-Path $dest) { Get-SkillVersion $dest } else { '-' }
        $newVersion = Get-SkillVersion $src

        if ($DryRun) {
            Write-Ok "would install $skill $oldVersion -> $newVersion"
        }
        else {
            # robocopy /MIR makes $dest an exact copy of $src: new files added, changed files updated,
            # files that no longer exist in the repo removed. It also handles long Windows paths.
            robocopy $src $dest /MIR /R:1 /W:1 /NFL /NDL /NJH /NJS /NP | Out-Null
            if ($LASTEXITCODE -ge 8) { throw "robocopy failed for $dest (exit code $LASTEXITCODE)" }
            $global:LASTEXITCODE = 0
            if (-not (Test-Path (Join-Path $dest 'SKILL.md'))) { throw "Copy failed: $dest\SKILL.md missing" }
            Write-Ok "$skill $oldVersion -> $newVersion"
        }
        $results += [pscustomobject]@{ Skill = $skill; Before = $oldVersion; After = $newVersion; Target = $target }
    }
}

Write-Host ''
Write-Host 'Summary:'
foreach ($r in $results) { Write-Host ("  {0,-14} {1,-9} -> {2,-9} {3}" -f $r.Skill, $r.Before, $r.After, $r.Target) }
if ($DryRun) { Write-Host 'Dry run: nothing was changed.' -ForegroundColor Yellow }
else { Write-Host 'Done. Start a NEW conversation in your tool so it picks up the updated skills.' -ForegroundColor Green }
