# pj - Multi-Project Git Manager

A lightweight CLI tool for developers and tech leads who manage multiple git repositories. Switch all repos to their default branch and pull the latest code with a single command.

## Features

- **`pj sync`** -- Switch all repos to default branch (`main`/`master`) and pull latest
- **`pj status`** -- Color-coded dashboard showing branch, dirty/clean, ahead/behind for every repo
- **`pj branches`** -- View all branches across all repos at once
- **`pj cleanup`** -- Delete merged branches across repos (with confirmation)
- **Group filtering** -- Organize repos into groups and operate on specific groups
- **Parallel mode** -- Speed up sync with `--parallel` flag
- **Zero dependencies** -- Pure Zsh script, works on macOS out of the box

## Quick Start

```bash
# Install
git clone https://github.com/Jiraphat-DEV/pj-cli.git
cd pj-cli
./install.sh

# Initialize (scan for git repos)
pj init --root ~/projects

# See the status of all your repos
pj status

# Sync everything to default branch
pj sync
```

## Installation

### Option 1: Install script (recommended)

```bash
git clone https://github.com/Jiraphat-DEV/pj-cli.git
cd pj-cli
./install.sh
```

This copies `pj` to `~/.local/bin/` and ensures it's on your PATH.

### Option 2: Manual

```bash
# Copy the script
cp pj ~/.local/bin/pj
chmod +x ~/.local/bin/pj

# Make sure ~/.local/bin is on your PATH
# Add to ~/.zshrc if needed:
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

### Initialize config

Scan a directory tree for git repos and generate `~/.pjconfig`:

```bash
pj init --root ~/projects
```

Options:
- `--root <path>` -- Root directory to scan (default: current directory)
- `--force` -- Overwrite existing config
- `--dry-run` -- Preview discovered repos without writing config

### Sync repos

Switch all repos to their default branch and pull latest:

```bash
pj sync                  # Sync all repos
pj sync backend          # Sync only the "backend" group
pj sync -p               # Sync all repos in parallel (faster)
```

Dirty repos (with uncommitted changes) are automatically skipped with a warning.

### Status dashboard

See the state of all repos at a glance:

```bash
pj status                # All repos
pj status frontend       # Only "frontend" group
```

Output shows:
- Current branch (green = default branch, yellow = feature branch)
- Status (green CLEAN / red DIRTY with file count)
- Ahead/behind remote

### View branches

See all branches across repos:

```bash
pj branches              # All repos
pj branches backend      # Filter by group or repo name
pj branches --local      # Local branches only
pj branches --remote     # Remote branches only
```

### Cleanup merged branches

Delete local branches that have been merged into the default branch:

```bash
pj cleanup --dry-run     # Preview what would be deleted
pj cleanup               # Delete with confirmation prompt
pj cleanup --force       # Delete without confirmation
pj cleanup backend       # Only cleanup "backend" group
```

Protected branches (`develop`, `staging`, `release`, `hotfix`) are never deleted.

### Manage repos

```bash
pj list                  # List all repos grouped
pj list --paths          # Show full paths
pj list --groups         # List group names only

pj add ~/projects/new-repo backend    # Add a repo to a group
pj remove old-repo                    # Remove by name
```

## Configuration

The config file is at `~/.pjconfig` (or set `PJ_CONFIG` env var). Format:

```ini
# Comments start with #
# Format: /absolute/path/to/repo = group-name

# backend
/home/user/projects/api-server = backend
/home/user/projects/worker = backend

# frontend
/home/user/projects/webapp = frontend
/home/user/projects/mobile-app = frontend
```

### Command shortcuts

| Long | Short |
|------|-------|
| `pj status` | `pj st` |
| `pj branches` | `pj br` |
| `pj list` | `pj ls` |
| `pj remove` | `pj rm` |

## Requirements

- **macOS** or **Linux** with Zsh installed
- Git

## How it works

1. `pj init` scans for `.git` directories and generates `~/.pjconfig`
2. Commands read the config and operate on each repo using `git -C <path>`
3. Default branch is auto-detected via `origin/HEAD` (handles `main`, `master`, or any custom default)
4. Colors are auto-disabled when output is piped

## License

MIT License. See [LICENSE](LICENSE).
