# Installing human-harness

`human-harness` is one file — `SKILL.md`, a system-prompt-style instruction set
with no code and no dependencies. Every agent runs the *same* body; they only
differ in **where the file lives** and **how you invoke it**. That's the whole
porting surface, and the installer knows it per agent.

## One-liner (auto-detects your agents)

**macOS / Linux / WSL**

```bash
curl -fsSL https://raw.githubusercontent.com/dhasson04/human-harness/main/install.sh | sh
```

**Windows PowerShell** *(claude / codex / gemini; untested draft — prefer WSL + the sh installer)*

```powershell
irm https://raw.githubusercontent.com/dhasson04/human-harness/main/install.ps1 | iex
```

The script installs into every agent it detects and skips the rest. Flags:

| flag | effect |
|---|---|
| `--only <agent>` | install for one agent (`claude` \| `codex` \| `gemini` \| `openclaw`) |
| `--all` | install for every supported agent, detected or not |
| `--uninstall` | remove human-harness from every agent |

## Per-agent matrix

Each agent stores and triggers the skill its own way. This is the concrete map
the installer follows — and what to do by hand if you'd rather not run a script.

| Agent | Where it goes | How to invoke | Format |
|---|---|---|---|
| **Claude Code** | `~/.claude/skills/human-harness/SKILL.md` | `/human-harness <task>` | `SKILL.md` verbatim |
| **Codex CLI** | `~/.codex/skills/human-harness/SKILL.md` | `$human-harness <task>` | `SKILL.md` verbatim |
| **Gemini CLI** | `~/.gemini/commands/human-harness.toml` | `/human-harness <task>` | TOML command (rendered from `SKILL.md`; `$ARGUMENTS` → `{{args}}`) |
| **OpenClaw** | `~/.openclaw/workspace/skills/human-harness/SKILL.md` | auto-discovered from the workspace skills dir | `SKILL.md` verbatim |

The only runtime difference inside the skill is the Done/Stuck/Not-now control:
Claude Code uses the `AskUserQuestion` picker; every other agent prints
`[d] done · [s] stuck · [n] not now` and reads your reply. Typed `d`/`s`/`n`
works everywhere.

## Manual install (no script)

Claude Code, Codex and OpenClaw take `SKILL.md` as-is:

```bash
git clone https://github.com/dhasson04/human-harness
# Claude Code
mkdir -p ~/.claude/skills/human-harness && cp human-harness/SKILL.md ~/.claude/skills/human-harness/
# Codex
mkdir -p ~/.codex/skills/human-harness  && cp human-harness/SKILL.md ~/.codex/skills/human-harness/
# OpenClaw
mkdir -p ~/.openclaw/workspace/skills/human-harness && cp human-harness/SKILL.md ~/.openclaw/workspace/skills/human-harness/
```

Gemini needs the TOML wrapper instead of a raw `SKILL.md` — run
`install.sh --only gemini`, which renders it from the same body.

## Notes

- **Zero dependencies.** The installer is POSIX `sh`; no Node, no npm, no API key.
- Agent install paths reflect each tool's docs as of May 2026
  ([Codex skills](https://developers.openai.com/codex/skills),
  [Gemini custom commands](https://geminicli.com/docs/cli/custom-commands/)).
  If an agent moves its skills directory, open an issue — the per-agent map is
  the only thing that needs updating.
