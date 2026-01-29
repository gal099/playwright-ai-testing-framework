# Start Dev Command

Get started with framework development (working ON the framework).

---

📦 **TWO-REPO STRUCTURE**

This framework has two separate repositories:
- **Dev Repo** (for framework developers): `playwright-ai-testing-framework` - Framework development
- **Template Repo** (for end users): `playwright-ai-testing-template` - Use for YOUR tests

**Make sure you cloned the DEV repo**:
```bash
git clone git@github.com:gal099/playwright-ai-testing-framework.git
```

---

⚠️ **FOR FRAMEWORK DEVELOPERS ONLY**

This command is for people working ON the framework itself (adding features, fixing bugs, improving architecture). If you're a QA tester using this framework to test YOUR application, clone the template repo and use `/start-user` instead.

**✅ Use this command if:**
- You cloned the **dev repo** to improve the framework
- You want to add new AI helpers or features
- You're fixing bugs in framework code
- You're a framework contributor

**❌ DO NOT use this command if:**
- You want to test YOUR application (clone template repo, use `/start-user`)
- You're a QA tester using the template
- You cloned the **template repo** by mistake (clone dev repo instead)

---

## Read

Read these files to understand framework development:
- `CLAUDE-DEV.md` - Framework development guide (primary reference)
- `README.md` - Project overview
- `TODO_framework.md` - Pending framework improvements
- `docs/AI-MODEL-STRATEGY.md` - AI cost optimization strategy
- `.env.example` - Configuration reference (never read `.env`)

## Read and Execute

Gather framework development context by running these commands:
- `git status` - Current branch and changes
- `git log -10 --oneline` - Recent framework commits
- `git branch -a` - All branches (look for framework/* branches)
- `ls tests/examples/` - Example tests (one per framework feature)
- `ls utils/ai-helpers/` - AI helpers (framework core)
- `cat TODO_framework.md` - Pending framework tasks

## Report

Provide a concise summary with this format:

---

## 🔧 Framework Development Context

**Mode**: Framework Development (working ON the framework)
**Branch**: [current branch]
**Status**: [clean / X modified / Y untracked files]

---

### 📝 Recent Framework Activity (Last 10 commits)

[List recent commits - focus on framework/* branches and feature additions]

---

### 📋 Pending Framework Tasks

[List items from TODO_framework.md if it exists, otherwise state "No pending tasks documented"]

---

### 🧪 Framework Examples

[List test files in tests/examples/ - these demonstrate framework features]

---

### 🤖 AI Helpers (Framework Core)

[List files in utils/ai-helpers/ - these are the framework's AI capabilities]

---

### 🛠️ Framework Development Commands

- **`/improve-framework <description>`** - Add new framework features
- **`/fix-framework <bug_description>`** - Fix framework bugs
- **`/review-changes [base_branch]`** - AI code review before PR
- **`/context`** - Refresh context when returning to work
- **`/start-dev`** - Show this context (this command)

**Publishing to Template Repo:**
```bash
# After merging to main and tagging release
./scripts/publish-template.sh X.Y.Z
```

**User commands** (available in template repo only, for reference):
- `/start-user` - Initialize template for end users (template repo)
- `/new-screen` - Automate tests for new screen (template repo)
- `/fix-test` - Debug failing tests (template repo)
- `/add-coverage` - Add more test coverage (template repo)

---

### ⚡ Quick Start for Framework Development

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

**Core Infrastructure:**
- `config/ai-client.ts` - Claude API client (multi-model support)
- `fixtures/ai-fixtures.ts` - AI-enhanced Playwright fixtures
- `utils/selectors/self-healing.ts` - Self-healing selector logic

**AI Helpers (Add new features here):**
- `utils/ai-helpers/test-generator.ts` - Generate tests from screenshots
- `utils/ai-helpers/selector-extractor.ts` - Extract selectors from pages
- `utils/ai-helpers/ai-assertions.ts` - AI-powered assertions
- `utils/ai-helpers/test-maintainer.ts` - Code analysis and refactoring
- `utils/ai-helpers/otp-extractor.ts` - OTP extraction from emails
- `utils/ai-helpers/site-explorer.ts` - Interactive site exploration
- `utils/ai-helpers/test-case-planner.ts` - Generate test documentation

**Documentation:**
- `CLAUDE-DEV.md` - Your primary guide
- `docs/AI-MODEL-STRATEGY.md` - Cost optimization decisions
- `TODO_framework.md` - Improvement tracking

---

### 🎯 Framework Development Workflow

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
10. **Publish to template**: After merging to main and tagging release:
    ```bash
    ./scripts/publish-template.sh X.Y.Z
    ```

---

### 💡 Framework Development Best Practices

1. **English only**: All code, comments, docs in English
2. **Cost conscious**: Document AI costs in AI-MODEL-STRATEGY.md
3. **Examples first**: Create example test before considering feature "done"
4. **Helper-first**: Logic in helpers, tests stay declarative
5. **Backwards compatible**: Don't break existing user code
6. **Test thoroughly**: Run full test suite before committing
7. **Review before push**: Use `/review-changes` to catch issues early

---

**Ready to improve the framework!** 🚀

**Next steps:**
- Read `CLAUDE-DEV.md` for detailed workflow
- Check `TODO_framework.md` for pending tasks
- Use `/improve-framework <description>` to add new features
- Use `/fix-framework <bug>` to fix bugs
- Use `/context` when returning after a break
