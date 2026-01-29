# Context Command

Get up to speed on the current project state when returning after time away.

## Read

Read these files to understand the project:
- `CLAUDE.md` - Project instructions and patterns
- `README.md` - Project overview
- `.env.example` - Required configuration (never read `.env`)
- `package.json` - Available scripts and dependencies

## Read and Execute

Gather information about project state by running these commands:
- `git status` - Current branch and changes
- `git log -10 --oneline` - Recent commits
- `ls tests/` - Existing test areas
- `ls utils/api/` - Available helpers
- `git branch -a` - All branches

## Report

Provide a concise summary with this format:

---

## 📊 Project Context Summary

**Project**: [name from package.json]
**Branch**: [current branch]
**Status**: [clean / X modified / Y untracked files]

---

### 📝 Recent Activity (Last 10 commits)

[List recent commits in a clear format]

---

### 🧪 Test Areas

[List test directories found in tests/ excluding tests/examples/]

**Examples**: [List example tests available]

---

### 🔧 Available Helpers

[List helper files found in utils/api/ excluding example-helper.ts]

---

### 🤖 Available Commands

- **`/new-screen <screen_name>`** - Automate tests for a new screen/feature
- **`/fix-test [test_name]`** - Debug and fix failing tests
- **`/add-coverage <feature>`** - Add more test coverage
- **`/review-changes [base_branch]`** - Get AI code review before PR
- **`/context`** - Refresh project context (this command)

---

### ⚡ Quick Start

```bash
# Run all tests
npm test

# Run specific test area
npm test tests/[feature]/

# Run in headed mode
npm run test:headed

# Add new screen
/new-screen "your-screen-name"
```

---

**Ready to continue working!** 🚀

**Next**: Use `/new-screen <name>` to automate a new feature, or `/fix-test` to debug failing tests.
