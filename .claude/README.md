# Claude Code Configuration

This directory contains configuration files for Claude Code CLI.

## Files

### `settings.local.json` (Personal, not tracked)

Your personal Claude Code settings. This file contains permissions and preferences specific to your workflow.

**Setup:**
```bash
# Copy the example file to create your local settings
cp .claude/settings.local.json.example .claude/settings.local.json
```

**Note:** This file is in `.gitignore` and will not be committed. Each team member should create their own based on the example.

### `settings.local.json.example` (Template, tracked)

Example configuration showing recommended permissions for this project. Use this as a starting point for your personal `settings.local.json`.

## Permissions Explained

The example configuration includes permissions for:

- **npm/playwright**: Install dependencies and run tests
- **git commands**: Version control operations
- **gh commands**: GitHub CLI operations (PR, releases)
- **Web tools**: Research and documentation lookup

Modify your local settings to match your workflow preferences.

## Commands

This directory also contains custom Claude Code commands:

- `commands-dev/`: Commands for framework development (working ON the framework)
- `commands-user/`: Commands for using the framework (working WITH the framework)

See `CLAUDE.md` in the root directory for command documentation.
