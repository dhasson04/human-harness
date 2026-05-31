#!/usr/bin/env sh
# human-harness installer — pure POSIX sh, zero dependencies.
#
# Installs the human-harness skill into whichever coding agents you have.
# The skill body is one canonical file; each agent just stores/invokes it
# differently. This script knows the per-agent target path and format.
#
#   curl -fsSL https://raw.githubusercontent.com/dhasson04/human-harness/main/install.sh | sh
#
# Flags:
#   --only <agent>   install for one agent only (claude|codex|gemini|openclaw)
#   --all            install for every supported agent, present or not
#   --uninstall      remove human-harness from every agent it was installed into
#   -h, --help       show this help
#
# With no flags it auto-detects which agents are present and installs into those.

set -eu

REPO_RAW="https://raw.githubusercontent.com/dhasson04/human-harness/main"
SKILL_NAME="human-harness"

ONLY=""
ALL=0
UNINSTALL=0

while [ $# -gt 0 ]; do
  case "$1" in
    --only) ONLY="${2:-}"; shift 2 ;;
    --only=*) ONLY="${1#--only=}"; shift ;;
    --all) ALL=1; shift ;;
    --uninstall) UNINSTALL=1; shift ;;
    -h|--help)
      sed -n '2,18p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) printf 'unknown flag: %s\n' "$1" >&2; exit 2 ;;
  esac
done

say()  { printf '%s\n' "$*"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
skip() { printf '  \033[2m·\033[0m %s\n' "$*"; }

# --- locate the skill source (local clone or download) ----------------------
SKILL_SRC=""
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd 2>/dev/null || true)
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ]; then
  SKILL_SRC="$SCRIPT_DIR/SKILL.md"
else
  TMP=$(mktemp 2>/dev/null || printf '/tmp/human-harness-skill.%s' "$$")
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$REPO_RAW/SKILL.md" -o "$TMP"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TMP" "$REPO_RAW/SKILL.md"
  else
    say "need curl or wget to download SKILL.md (or run from a cloned repo)"; exit 1
  fi
  SKILL_SRC="$TMP"
fi

# --- per-agent detection ----------------------------------------------------
has() {  # has <agent>  -> 0 if that agent looks installed
  case "$1" in
    claude)   [ -d "$HOME/.claude" ]   || command -v claude   >/dev/null 2>&1 ;;
    codex)    [ -d "$HOME/.codex" ]    || command -v codex    >/dev/null 2>&1 ;;
    gemini)   [ -d "$HOME/.gemini" ]   || command -v gemini   >/dev/null 2>&1 ;;
    openclaw) [ -d "$HOME/.openclaw" ] || command -v openclaw >/dev/null 2>&1 ;;
    *) return 1 ;;
  esac
}

# --- per-agent install (the PROVIDERS table) --------------------------------
# Claude Code, Codex and OpenClaw consume SKILL.md verbatim. Gemini has no
# SKILL.md concept, so we render a custom-command .toml from the same body.

install_skillmd() {  # install_skillmd <dest-dir> <label>
  dest="$1"; label="$2"
  mkdir -p "$dest"
  cp "$SKILL_SRC" "$dest/SKILL.md"
  ok "$label  ->  $dest/SKILL.md"
}

install_gemini() {
  dir="$HOME/.gemini/commands"
  mkdir -p "$dir"
  # strip YAML frontmatter, map $ARGUMENTS -> {{args}}, wrap as a TOML command
  {
    printf 'description = "%s"\n' "A focus harness for a human with ADHD — one task at a time."
    printf 'prompt = """\n'
    awk 'BEGIN{fm=0} /^---[[:space:]]*$/{fm++; next} fm>=2{print}' "$SKILL_SRC" \
      | sed 's/\$ARGUMENTS/{{args}}/g'
    printf '"""\n'
  } > "$dir/$SKILL_NAME.toml"
  ok "gemini  ->  $dir/$SKILL_NAME.toml"
}

install_one() {
  case "$1" in
    claude)   install_skillmd "$HOME/.claude/skills/$SKILL_NAME" claude ;;
    codex)    install_skillmd "$HOME/.codex/skills/$SKILL_NAME" codex ;;
    openclaw) install_skillmd "$HOME/.openclaw/workspace/skills/$SKILL_NAME" openclaw ;;
    gemini)   install_gemini ;;
  esac
}

uninstall_one() {
  case "$1" in
    claude)   rm -rf "$HOME/.claude/skills/$SKILL_NAME" ;;
    codex)    rm -rf "$HOME/.codex/skills/$SKILL_NAME" ;;
    openclaw) rm -rf "$HOME/.openclaw/workspace/skills/$SKILL_NAME" ;;
    gemini)   rm -f  "$HOME/.gemini/commands/$SKILL_NAME.toml" ;;
  esac
  ok "removed $1"
}

AGENTS="claude codex gemini openclaw"

# --- run --------------------------------------------------------------------
if [ "$UNINSTALL" = 1 ]; then
  say "uninstalling human-harness…"
  for a in $AGENTS; do uninstall_one "$a"; done
  say "done."
  exit 0
fi

say "installing human-harness…"
installed=0
for a in $AGENTS; do
  if [ -n "$ONLY" ]; then
    [ "$a" = "$ONLY" ] || continue
  elif [ "$ALL" != 1 ]; then
    if ! has "$a"; then skip "$a not detected"; continue; fi
  fi
  install_one "$a"
  installed=$((installed + 1))
done

if [ "$installed" = 0 ]; then
  say ""
  say "no agents installed. pick one explicitly:  install.sh --only claude"
  exit 1
fi

say ""
say "done. invoke it:"
say "  claude code   /human-harness <task>"
say "  codex         \$human-harness <task>"
say "  gemini        /human-harness <task>"
say "  openclaw      auto-discovered from the workspace skills dir"
