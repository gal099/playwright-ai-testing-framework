# Context Command - Framework Development

Get framework development context when returning after time away.

## Read

Read these files to understand the framework development state:
- `CLAUDE-DEV.md` - Framework development guide (primary reference)
- `TODO_framework.md` - Pending framework improvements and tasks
- `README.md` - Project overview
- `.env.example` - Configuration reference (never read `.env`)
- `package.json` - Available scripts and dependencies
- `docs/AI-MODEL-STRATEGY.md` - AI cost optimization strategy

## Read and Execute

Gather information about framework development state by running these commands:
- `git status` - Current branch and changes
- `git log -10 --oneline` - Recent framework commits
- `git branch -a | grep framework/` - Framework development branches
- `ls tests/examples/` - Framework example tests (one per feature)
- `ls utils/ai-helpers/` - AI helpers (framework core)
- `cat TODO_framework.md` - Pending framework tasks

## Report

Provide a concise summary with this format:

---

## 🔧 Framework Development Context

**Project**: [name from package.json]
**Mode**: Framework Development
**Branch**: [current branch]
**Status**: [clean / X modified / Y untracked files]

---

### 📝 Recent Framework Activity (Last 10 commits)

[List recent commits - highlight framework/* branches and feature additions]

---

### 📋 Pending Framework Tasks

[Read and list items from TODO_framework.md if it exists]

**Priority tasks**:
- [List any critical or high-priority tasks]

[If no TODO_framework.md: "No pending tasks documented"]

---

### 🧪 Framework Examples (tests/examples/)

[List test files in tests/examples/ - these demonstrate framework features]

**Examples by feature**:
- [Group by feature type: AI assertions, selector extraction, OTP, etc.]

---

### 🤖 AI Helpers (utils/ai-helpers/)

[List files in utils/ai-helpers/ - these are the framework's AI capabilities]

**Core helpers**:
- [List with brief description of each]

---

### 🌿 Framework Branches

[List branches matching 'framework/*' pattern]

**Active development**:
- [Highlight branches with recent activity]

---

### 🛠️ Framework Development Commands

- **`/start-dev`** - Show this context (framework developer entry point)
- **`/improve-framework <description>`** - Add new framework features
- **`/fix-framework <bug_description>`** - Fix framework bugs
- **`/review-changes [base_branch]`** - AI code review before PR
- **`/context`** - Refresh framework development context (this command)

**User commands** (for reference):
- `/start-user` - Initialize template for end users
- `/new-screen` - Automate tests for new screen
- `/fix-test` - Debug failing tests
- `/add-coverage` - Add more test coverage

---

### ⚡ Quick Start

```bash
# Run all tests (including examples)
npm test

# Run only example tests (framework features)
npm test tests/examples/

# Check AI model versions
npm run check-models

# Create new framework feature branch
git checkout -b framework/add-your-feature

# After implementing feature
/review-changes main
```

---

### 📖 Key Framework Files

**Core Infrastructure**:
- `config/ai-client.ts` - Claude API client (multi-model support)
- `fixtures/ai-fixtures.ts` - AI-enhanced Playwright fixtures
- `utils/selectors/self-healing.ts` - Self-healing selector logic

**AI Helpers** (add new features here):
- `utils/ai-helpers/test-generator.ts` - Generate tests from screenshots
- `utils/ai-helpers/selector-extractor.ts` - Extract selectors from pages
- `utils/ai-helpers/ai-assertions.ts` - AI-powered assertions
- `utils/ai-helpers/test-maintainer.ts` - Code analysis and refactoring
- `utils/ai-helpers/otp-extractor.ts` - OTP extraction from emails
- `utils/ai-helpers/site-explorer.ts` - Interactive site exploration
- `utils/ai-helpers/test-case-planner.ts` - Generate test documentation

**Documentation**:
- `CLAUDE-DEV.md` - Your primary development guide
- `docs/AI-MODEL-STRATEGY.md` - Cost optimization decisions
- `TODO_framework.md` - Improvement tracking

---

### 💡 Framework Development Workflow

1. **Pick a task** from TODO_framework.md or propose new improvement
2. **Create branch**: `git checkout -b framework/add-feature-name`
3. **Implement** following patterns in CLAUDE-DEV.md
4. **Add example** in `tests/examples/feature-example.spec.ts`
5. **Update docs**:
   - AI-MODEL-STRATEGY.md (if AI feature)
   - CLAUDE-DEV.md (if behavior changes)
   - CHANGELOG.md (document changes)
6. **Run tests**: `npm test`
7. **Review**: `/review-changes main`
8. **Commit** with `framework:` prefix
9. **Push** and create PR

---

**Ready to improve the framework!** 🚀

**Next steps**:
- Check TODO_framework.md for pending tasks
- Use `/improve-framework <description>` to add new features
- Use `/fix-framework <bug>` to fix bugs
- See CLAUDE-DEV.md for detailed workflow
