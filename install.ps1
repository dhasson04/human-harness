# human-harness installer for Windows PowerShell — zero dependencies.
#
#   irm https://raw.githubusercontent.com/dhasson04/human-harness/main/install.ps1 | iex
#
# Mirrors install.sh for the agents that run on Windows: Claude Code, Codex,
# Gemini. (OpenClaw is unix-workspace only — use install.sh under WSL for it.)
#
#   -Only <agent>   install for one agent only (claude|codex|gemini)
#   -All            install for every supported agent, present or not
#   -Uninstall      remove human-harness from every agent
#
# NOTE: drafted to mirror the tested install.sh; not yet run on a Windows host.

param(
  [string]$Only = "",
  [switch]$All,
  [switch]$Uninstall
)

$ErrorActionPreference = "Stop"
$RepoRaw   = "https://raw.githubusercontent.com/dhasson04/human-harness/main"
$SkillName = "human-harness"
$Agents    = @("claude", "codex", "gemini")

function Get-SkillSource {
  $local = Join-Path $PSScriptRoot "SKILL.md"
  if (Test-Path $local) { return (Get-Content $local -Raw) }
  return (Invoke-RestMethod -Uri "$RepoRaw/SKILL.md")
}

function Test-Agent($a) {
  switch ($a) {
    "claude" { return (Test-Path "$HOME\.claude") -or (Get-Command claude -ErrorAction SilentlyContinue) }
    "codex"  { return (Test-Path "$HOME\.codex")  -or (Get-Command codex  -ErrorAction SilentlyContinue) }
    "gemini" { return (Test-Path "$HOME\.gemini") -or (Get-Command gemini -ErrorAction SilentlyContinue) }
  }
  return $false
}

function Install-SkillMd($dir, $label, $skill) {
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  Set-Content -Path (Join-Path $dir "SKILL.md") -Value $skill -NoNewline
  Write-Host "  + $label  ->  $dir\SKILL.md"
}

function Install-Gemini($skill) {
  $dir = "$HOME\.gemini\commands"
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  # strip YAML frontmatter, map $ARGUMENTS -> {{args}}, wrap as a TOML command
  $lines = $skill -split "`n"
  $body  = New-Object System.Collections.Generic.List[string]
  $fm = 0
  foreach ($ln in $lines) {
    if ($ln -match '^---\s*$') { $fm++; continue }
    if ($fm -ge 2) { $body.Add(($ln -replace '\$ARGUMENTS', '{{args}}')) }
  }
  $toml = "description = `"A focus harness for a human with ADHD — one task at a time.`"`n" +
          "prompt = `"`"`"`n" + ($body -join "`n") + "`n`"`"`"`n"
  Set-Content -Path (Join-Path $dir "$SkillName.toml") -Value $toml -NoNewline
  Write-Host "  + gemini  ->  $dir\$SkillName.toml"
}

function Install-One($a, $skill) {
  switch ($a) {
    "claude" { Install-SkillMd "$HOME\.claude\skills\$SkillName" "claude" $skill }
    "codex"  { Install-SkillMd "$HOME\.codex\skills\$SkillName"  "codex"  $skill }
    "gemini" { Install-Gemini $skill }
  }
}

function Uninstall-One($a) {
  switch ($a) {
    "claude" { Remove-Item -Recurse -Force "$HOME\.claude\skills\$SkillName" -ErrorAction SilentlyContinue }
    "codex"  { Remove-Item -Recurse -Force "$HOME\.codex\skills\$SkillName"  -ErrorAction SilentlyContinue }
    "gemini" { Remove-Item -Force "$HOME\.gemini\commands\$SkillName.toml"    -ErrorAction SilentlyContinue }
  }
  Write-Host "  - removed $a"
}

if ($Uninstall) {
  Write-Host "uninstalling human-harness..."
  foreach ($a in $Agents) { Uninstall-One $a }
  Write-Host "done."
  exit 0
}

$skill = Get-SkillSource
Write-Host "installing human-harness..."
$count = 0
foreach ($a in $Agents) {
  if ($Only) { if ($a -ne $Only) { continue } }
  elseif (-not $All) { if (-not (Test-Agent $a)) { Write-Host "  . $a not detected"; continue } }
  Install-One $a $skill
  $count++
}

if ($count -eq 0) {
  Write-Host "`nno agents installed. pick one explicitly:  install.ps1 -Only claude"
  exit 1
}
Write-Host "`ndone. invoke with /human-harness (claude, gemini) or `$human-harness (codex)."
