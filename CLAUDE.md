# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal bash configuration (`bashrc`) tracked in git. Intended to be symlinked from `~/.bashrc`.

## File Structure

| File | Tracked | Purpose |
|------|---------|---------|
| `bashrc` | Yes | Main portable bash config |
| `.env.example` | Yes | Template for required secrets |
| `.env` | No (gitignored) | Actual API keys — copy from `.env.example` |
| `bashrc.local.example` | Yes | Template for machine-specific overrides |
| `bashrc.local` | No (gitignored) | Per-machine overrides (Java, machine-specific paths) |

## Setup on a New Machine

```bash
# 1. Clone and symlink
git clone <repo> ~/.config/bash
ln -sf ~/.config/bash/bashrc ~/.bashrc

# 2. Create secrets file
cp ~/.config/bash/.env.example ~/.config/bash/.env
# Edit .env and fill in API keys

# 3. Create machine-specific overrides (optional)
cp ~/.config/bash/bashrc.local.example ~/.config/bash/bashrc.local
# Edit bashrc.local and fill in paths for this machine
```

## Architecture

`bashrc` is organized in sections:
1. **Interactive guard** — exits early for non-interactive shells
2. **Secrets** — sources `.env` if present
3. **History** — `HISTSIZE=10000`, append mode
4. **Prompt** — custom `PS1` with bold white on black `[\u@\W]\$`
5. **Colors & aliases** — ls/grep coloring, ll/la/l/vim/vi shortcuts
6. **Completion** — bash-completion, loaded from `/usr/share` or `/etc`
7. **Tool managers** — nvm, conda, Deno, CUDA, Cargo, ghcup, asdf (all guarded)
8. **Angular completion** — guarded with `command -v ng`
9. **Machine overrides** — sources `~/.config/bash/bashrc.local` if present

## Portability Pattern

Every optional tool uses an existence guard before sourcing or adding to PATH:

```bash
# Commands: command -v <tool> &>/dev/null && ...
# Files:    [ -f "$HOME/.tool/env" ] && . "$HOME/.tool/env"
# Dirs:     [ -d "$HOME/.tool" ] && export PATH="$HOME/.tool/bin:$PATH"
```

This ensures a fresh clone silently skips uninstalled tools without crashing the shell.

## Machine-specific Settings

Put these in the gitignored `bashrc.local` (in this repo directory), not in `bashrc`:
- `JAVA_HOME` (version varies per machine)
- Gremlin Console path
- Any machine-specific PATH additions
