#!/usr/bin/env bash
# content-kit installer
#
# One-command install. Run from your project root for in-project install,
# or run from anywhere with --user for user-wide install.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh | bash -s -- --user
#   curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh | bash -s -- --submodule
#
# What it does:
#   1. Clones the kit (or refreshes existing clone)
#   2. Symlinks skills + commands into .claude/
#   3. Copies the four guideline templates into content-kit/
#   4. Prints next steps
#
# Idempotent: safe to re-run.

set -euo pipefail

REPO_URL="https://github.com/RelatoHQ/content-kit.git"
MODE="in-project"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user)       MODE="user"; shift ;;
    --submodule)  MODE="submodule"; shift ;;
    --in-project) MODE="in-project"; shift ;;
    --help|-h)
      sed -n '2,17p' "$0" | sed 's/^# *//'
      exit 0 ;;
    *)
      echo "unknown flag: $1" >&2
      echo "valid: --user | --in-project (default) | --submodule | --help" >&2
      exit 1 ;;
  esac
done

color() { printf '\033[%sm%s\033[0m\n' "$1" "$2"; }
green() { color '32' "$1"; }
yellow() { color '33' "$1"; }
red() { color '31' "$1"; }
gray() { color '90' "$1"; }

case "$MODE" in
  user)
    KIT_PARENT="$HOME/.claude"
    SKILLS_PARENT="$HOME/.claude/skills"
    COMMANDS_PARENT="$HOME/.claude/commands"
    GUIDELINES_PARENT="$HOME"
    SYMLINK_TARGET_REL="../content-kit"
    ;;
  in-project|submodule)
    if [[ ! -d ".git" ]] && [[ ! -f ".git" ]]; then
      red "✗ Not a git repo. Run from your project root, or use --user for a user-wide install."
      exit 1
    fi
    KIT_PARENT=".claude"
    SKILLS_PARENT=".claude/skills"
    COMMANDS_PARENT=".claude/commands"
    GUIDELINES_PARENT="."
    SYMLINK_TARGET_REL="../content-kit"
    ;;
esac

KIT_DIR="$KIT_PARENT/content-kit"

mkdir -p "$KIT_PARENT" "$SKILLS_PARENT" "$COMMANDS_PARENT"

# 1. Get the kit
if [[ -d "$KIT_DIR/.git" ]]; then
  yellow "↻ Refreshing existing clone at $KIT_DIR"
  git -C "$KIT_DIR" pull --ff-only --quiet
elif [[ "$MODE" == "submodule" ]]; then
  yellow "+ Adding $KIT_DIR as a git submodule"
  git submodule add "$REPO_URL" "$KIT_DIR" 2>&1 | grep -v "already exists" || true
else
  yellow "+ Cloning kit into $KIT_DIR"
  git clone --quiet "$REPO_URL" "$KIT_DIR"
fi

# 2. Symlink skills and commands
make_symlink() {
  local src="$1" dst="$2"
  if [[ -L "$dst" ]]; then
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    yellow "  ⚠ $dst exists and is not a symlink — backing up to ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
}

make_symlink "$SYMLINK_TARGET_REL/skills"   "$SKILLS_PARENT/content-kit"
make_symlink "$SYMLINK_TARGET_REL/commands" "$COMMANDS_PARENT/content-kit"
green "✓ Skills and commands symlinked under $SKILLS_PARENT/ and $COMMANDS_PARENT/"

# 3. Guideline templates
mkdir -p "$GUIDELINES_PARENT/content-kit"

copy_template() {
  local name="$1"
  local dst="$GUIDELINES_PARENT/content-kit/$name"
  if [[ -f "$dst" ]]; then
    gray "  ◦ content-kit/$name already exists — kept as is"
  else
    cp "$KIT_DIR/templates/$name" "$dst"
    green "  + content-kit/$name (template — edit before drafting)"
  fi
}

copy_template "voice.md"
copy_template "forbidden-words.md"
copy_template "taxonomy.md"
copy_template "experts.md"

# 4. Optional: gitignore the cloned kit if in-project (keeps the symlinks
#    but doesn't commit the kit's own history into your repo)
if [[ "$MODE" == "in-project" ]] && [[ -f ".gitignore" ]]; then
  if ! grep -qE '^\.claude/content-kit/?$' .gitignore; then
    echo ".claude/content-kit/" >> .gitignore
    gray "  ◦ Added .claude/content-kit/ to .gitignore"
  fi
fi

# 5. Done
echo
green "═══════════════════════════════════════════════════════"
green " content-kit installed (mode: $MODE)"
green "═══════════════════════════════════════════════════════"
echo
echo "Next:"
echo "  1. Edit $GUIDELINES_PARENT/content-kit/voice.md — your brand voice"
echo "  2. (Optional) Edit forbidden-words.md, taxonomy.md, experts.md"
echo "  3. Open Claude Code and run: /draft \"<a topic>\""
echo
echo "Docs:"
echo "  - Getting started:  $KIT_DIR/docs/getting-started.md"
echo "  - Customization:    $KIT_DIR/docs/customization.md"
echo "  - Relato setup:     $KIT_DIR/docs/relato-setup.md"
echo
gray "To update later: $KIT_DIR is a regular git clone — git -C $KIT_DIR pull"
