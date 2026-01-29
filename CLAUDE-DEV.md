# Framework Development Guide

> **⚠️ SOURCE REPOSITORY ONLY**: This file exists only in the framework source repository.
> When you run `npm run create-template`, this file is automatically removed from the generated template.
> End users of the template will only see `CLAUDE.md`, which contains usage instructions.

**You are working ON the framework, improving it for future users.**

This guide is for developers working on the Playwright AI Testing Framework itself, not for QA testers using the framework to test applications. If you're a QA tester using this framework for your project, see `CLAUDE.md` instead.

---

## 👥 User Perspective

When developing framework features, refer to `CLAUDE.md` to understand:
- How end users interact with the framework
- Environment variables users configure
- Common patterns users expect
- Commands available to users:
  - `/setup` - First-time initialization (converts to template, installs deps, creates .env, initializes git)
  - `/new-screen` - Automate tests for new screen
  - `/fix-test` - Debug and fix failing tests
  - `/add-coverage` - Add more test coverage
  - `/review-changes` - AI code review (shared with framework dev)

This helps ensure backwards compatibility and good UX. You can open `CLAUDE.md` manually when needed, but this file (`CLAUDE-DEV.md`) is your primary reference for framework development.

---

## 🎯 What is Framework Development?

**Framework development** means improving the framework code itself:
- Adding new AI helpers (OTP extraction, image comparison, etc.)
- Improving existing features (self-healing, assertions, etc.)
- Fixing bugs in framework code
- Optimizing AI model selection and costs
- Adding new fixtures or utilities
- Improving architecture and patterns

**NOT framework development** (this is using the framework):
- Writing tests for your application
- Creating project-specific helpers
- Testing screens/features of your app
- Adding tests to `tests/` (except `tests/examples/`)

---

## 📋 Commands Available

Use these commands when working on framework development:

### `/improve-framework <description>`
Add new features to the framework itself.

**When to use:**
- Adding new AI helpers (e.g., PDF assertion, image comparison)
- Adding new capabilities to existing helpers
- Creating new fixtures or utilities
- Improving framework architecture

**Example:**
```
/improve-framework "Add AI-powered PDF content assertion helper"
```

**What it does:**
- Creates `framework/add-*` branch
- Guides through exploration, planning, implementation
- Ensures proper AI model selection and cost optimization
- Requires updating AI-MODEL-STRATEGY.md with costs
- Requires creating example test in `tests/examples/`

---

### `/fix-framework <bug_description>`
Fix bugs in the framework code itself.

**When to use:**
- Self-healing cache not working correctly
- AI assertions returning incorrect results
- Fixtures not cleaning up properly
- Helper methods have bugs
- Cost optimization not working

**Example:**
```
/fix-framework "Self-healing cache not invalidating when selector changes"
```

**What it does:**
- Creates `framework/fix-*` branch
- Guides through bug reproduction and root cause analysis
- Ensures minimal changes and no regressions
- Requires all framework tests to pass
- Documents fix with clear explanation

---

### `/review-changes [base_branch]`
Comprehensive AI review of changes before creating PR.

**When to use:**
- Before creating any pull request
- After implementing framework improvements or fixes
- Before merging to main/master
- To get feedback on code quality and architecture

**Example:**
```
/review-changes
/review-changes develop
```

**What it does:**
- Analyzes all files changed in your branch
- Reviews code quality, architecture, and best practices
- Checks for bugs, security issues, performance problems
- Validates documentation completeness
- Ensures tests are included and passing
- Provides actionable recommendations with severity levels
- Reports: Ready for PR / Needs Changes / Blocked

**When to run:**
- After completing all implementation work
- After all tests pass (`npm test`)
- Before pushing branch and creating PR
- After addressing previous review feedback

---

## 🔍 What is "Framework Code"?

### Framework Code (What You're Improving)

These files are part of the framework and should be improved when needed:

```
config/
└── ai-client.ts              # Claude API client (multi-model support)

fixtures/
└── ai-fixtures.ts            # AI-enhanced Playwright fixtures

utils/
├── ai-helpers/
│   ├── test-generator.ts     # Generate tests from screenshots
│   ├── test-case-planner.ts  # Generate test case documentation (NEW)
│   ├── ai-assertions.ts      # Visual, semantic, layout assertions
│   ├── test-maintainer.ts    # Analyze and refactor test code
│   └── otp-extractor.ts      # AI-powered OTP extraction
├── selectors/
│   └── self-healing.ts       # Auto-repair broken selectors
└── api/
    ├── auth-helper.ts        # Core authentication helper
    ├── otp-helper.ts         # OTP authentication helper
    └── email-providers/      # Email provider integrations
        └── mailtrap.ts

tests/examples/               # Example tests demonstrating features
└── *.spec.ts

docs/
└── AI-MODEL-STRATEGY.md      # Model selection and cost optimization

scripts/
├── create-template.ts        # Template generator
└── init-new-project.sh       # Project initializer
```

### NOT Framework Code (Created by Users)

These are created by QA testers using the framework for their projects:

```
tests/
├── login/                    # User's project tests
├── dashboard/
└── checkout/

utils/api/
├── login-helper.ts          # User's project helpers
├── dashboard-helper.ts
└── checkout-helper.ts

docs/
├── LOGIN-P2-P3-TESTS.md     # User's project docs
└── DASHBOARD-P2-P3-TESTS.md

.env                          # User's project config (never commit)
```

---

## 🔧 Git Workflow for Framework Development

### Branch Naming

Use `framework/` prefix to distinguish from user project branches:

```bash
# Framework improvements
framework/add-otp-extraction
framework/add-pdf-assertions
framework/improve-self-healing-cache

# Framework fixes
framework/fix-cache-invalidation
framework/fix-otp-timeout
framework/fix-assertion-error-handling
```

**NOT** for framework development:
```bash
# These are for user projects (QA testing apps)
feature/test-login-page
fix/login-button-selector
```

### Commit Messages

Framework development commits should start with `framework:`:

```
framework: add OTP extraction helper with AI fallback

Adds OTPHelper class that extracts verification codes from emails
using regex patterns with AI-powered fallback for complex formats.

Technical Details:
- Model: Haiku (fast and cheap for text extraction)
- Cost: ~$0.0001 per extraction
- Location: utils/api/otp-helper.ts
- Example: tests/examples/otp-auth-example.spec.ts

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Git & Review Protocol (MANDATORY)

**ALWAYS follow this sequence before pushing to remote:**

1. ✅ **Stage changes**: `git add <files>`
2. ✅ **Run tests**: `npm test` - All must pass
3. ✅ **Review with AI**: `/review-changes origin/main` (even when on main branch)
4. ✅ **Fix issues**: Address any Critical/Important findings from review
5. ✅ **Commit**: Only after review passes
6. ✅ **Push**: `git push origin <branch>`

**Why review before push (even on main)?**
- ❌ Direct commits to main = No PR review process
- ✅ Catch issues before they become public
- ✅ Validate documentation consistency across files
- ✅ Ensure code quality and architecture standards
- ✅ Prevent breaking changes from reaching users

**Exception:**
Only skip review for trivial changes (typos, single-line README formatting).

**IMPORTANT:** When working directly on main branch, the review is even MORE critical since there's no PR safety net. Always run `/review-changes origin/main` before pushing.

---

## 📦 Semantic Versioning Reminder

**ALWAYS follow semantic versioning when releasing framework changes.**

Before committing framework changes, determine the version bump needed:

### Version Types

- **PATCH (1.x.Y)**: Bug fixes, no new features, backwards compatible
  - Examples:
    - Fix broken selector in self-healing
    - Fix typo in documentation
    - Fix error handling in helper
    - Performance optimization without API changes

- **MINOR (1.X.0)**: New features, backwards compatible
  - Examples:
    - New AI helper (OTP extraction, image comparison)
    - New command (/new-screen, /fix-test)
    - New npm script (ai:plan-tests)
    - New capability added to existing helper
    - Major documentation additions

- **MAJOR (X.0.0)**: Breaking changes (rare)
  - Examples:
    - Change public API signatures
    - Remove features or helpers
    - Incompatible changes to fixtures
    - Require new environment variables
    - Change helper method signatures

### Version Bump Checklist

When releasing a new framework version:

1. **Update version in `package.json`**:
   ```bash
   # Edit package.json
   vim package.json
   # Change "version": "1.4.2" to "1.5.0" (for example)
   ```

2. **Update version badge in `README.md`**:
   ```bash
   # Edit README.md
   vim README.md
   # Change: > **Version 1.4.2** | [Changelog](CHANGELOG.md)
   # To:     > **Version 1.5.0** | [Changelog](CHANGELOG.md)
   ```

3. **Add entry to `CHANGELOG.md`**:
   ```bash
   # Edit CHANGELOG.md
   vim CHANGELOG.md
   # Add new version section with:
   # - Date
   # - Added/Changed/Fixed/Removed sections
   # - Breaking changes (if MAJOR)
   # - Migration guide (if needed)
   ```

4. **Commit the version bump**:
   ```bash
   git add package.json README.md CHANGELOG.md
   git commit -m "chore: bump version to 1.5.0"
   ```

5. **Create annotated git tag**:
   ```bash
   git tag -a v1.5.0 -m "Release v1.5.0: Brief description of main changes"
   ```

6. **Push commits and tag**:
   ```bash
   git push origin main
   git push origin v1.5.0
   ```

7. **Create GitHub Release** (optional but recommended):
   ```bash
   # Create release notes file
   cat > /tmp/release-notes.md << 'EOF'
   ## What's New

   - Feature 1
   - Feature 2

   ## Bug Fixes

   - Fix 1
   - Fix 2

   ## Documentation

   - Doc update 1

   See [CHANGELOG.md](https://github.com/gal099/playwright-ai-testing-framework/blob/main/CHANGELOG.md) for complete details.
   EOF

   # Create GitHub release
   gh release create v1.5.0 \
     --title "v1.5.0 - Brief Title" \
     --notes-file /tmp/release-notes.md
   ```

### When to Version Bump

- **Immediately after merging** a framework feature or fix to main
- **Before sharing** the template with others
- **When documenting** completed work in CHANGELOG.md

### Reference Example: v1.4.2

Successful release workflow from previous session:

```bash
# Step 1: Update version files
vim package.json  # 1.4.1 → 1.4.2
vim README.md     # Update version badge
vim CHANGELOG.md  # Add v1.4.2 entry with all changes

# Step 2: Commit version bump
git add package.json README.md CHANGELOG.md
git commit -m "chore: bump version to 1.4.2"

# Step 3: Create annotated tag
git tag -a v1.4.2 -m "Release v1.4.2: Repository rename and dual-mode documentation

- Repository renamed to playwright-ai-testing-framework
- Added comprehensive dual-mode documentation
- Implemented mandatory review protocol
- Fixed git tracking issues"

# Step 4: Push everything
git push origin main
git push origin v1.4.2

# Step 5: Create GitHub release
gh release create v1.4.2 \
  --title "v1.4.2 - Repository Rename & Dual-Mode Documentation" \
  --notes-file /tmp/release-notes.md
```

---

## 🧪 Testing Framework Changes

When you modify framework code, test it properly:

### 1. Create Example Test

Every framework feature needs an example in `tests/examples/`:

```typescript
// tests/examples/new-feature-example.spec.ts
import { test, expect } from '@playwright/test';

/**
 * Example: Using New Framework Feature
 *
 * This example demonstrates how to use the new feature.
 */

test.describe('New Feature Example', () => {
  test('should work correctly', async ({ page }) => {
    // Example usage with comments
  });
});
```

### 2. Run Existing Tests

Ensure framework changes don't break existing functionality:

```bash
# Run all tests
npm test

# Run example tests specifically
npx playwright test tests/examples/

# Run with all browsers
npx playwright test --project=chromium
npx playwright test --project=firefox
npx playwright test --project=webkit
```

### 3. Test with Real API Calls

If your change involves AI features:
- Set `ANTHROPIC_API_KEY` in `.env`
- Test with actual API calls, not mocks
- Verify costs are reasonable
- Check error handling when API fails

### 4. Test Cost Optimization

Verify that caching and cost optimization work:
- First call should hit API
- Subsequent calls should use cache (if applicable)
- Log costs to verify they match estimates

---

## 📚 Documentation Requirements

When adding or modifying framework features, update documentation:

### 1. Update AI-MODEL-STRATEGY.md

Add cost analysis for new AI features:

```markdown
### New Feature → **Haiku/Sonnet/Opus**
\`\`\`typescript
model: 'haiku'
maxTokens: 1024
\`\`\`
**Reason:** [Why this model was chosen]

**Estimated cost:** ~$X.XXX per usage
```

### 2. Update CLAUDE.md (For Users)

If feature changes how users interact with the framework:

```markdown
## AI Features

### New Feature Name

Description of what it does and when to use it.

\`\`\`typescript
// Code example
\`\`\`
```

### 3. Update README.md (Major Features Only)

Only update README for significant user-facing features:
- New major capabilities
- Breaking changes
- New setup requirements

### 4. Create Example Test

Always create example in `tests/examples/` with:
- Clear comments explaining usage
- Both success and error cases
- Cost implications noted in comments

---

## 💰 Cost Optimization Guidelines

Framework features that use AI must be cost-optimized:

### Model Selection

Choose the cheapest model that works:

| Task Type | Model | Cost | Use Case |
|-----------|-------|------|----------|
| Simple text parsing | Haiku | ~$0.001 | OTP extraction, data validation |
| Visual analysis | Sonnet | ~$0.01 | Screenshots, layout checks |
| Complex reasoning | Opus | ~$0.10 | Only as fallback |

### Caching Strategy

Implement caching where possible:

```typescript
// Example: Cache results to avoid repeated API calls
const cacheKey = generateCacheKey(selector, description);
const cached = cache.get(cacheKey);
if (cached) return cached;

const result = await callAI(prompt);
cache.set(cacheKey, result);
return result;
```

### Token Optimization

- Use appropriate `maxTokens` limits (don't over-allocate)
- Truncate large inputs when possible
- Don't send unnecessary context
- Use system prompts efficiently

### Make AI Optional

All AI features should be optional:

```typescript
const enableAI = process.env.ENABLE_SELF_HEALING === 'true';
if (!enableAI) {
  // Fall back to traditional approach
  return traditionalMethod();
}
```

### Document Costs

Always document estimated costs in:
- AI-MODEL-STRATEGY.md
- Code comments
- Example tests

---

## 🏗️ Framework Architecture

### Core Components

```
┌─────────────────────────────────────────────────────────┐
│                    User's Test Code                      │
│  tests/{feature}/{feature}-p1.spec.ts                   │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                User's Helper Methods                     │
│  utils/api/{feature}-helper.ts                          │
└────────────────────┬────────────────────────────────────┘
                     │
         ┌───────────┴───────────┐
         ▼                       ▼
┌─────────────────────┐  ┌──────────────────────────┐
│  Framework Helpers  │  │   AI Fixtures           │
│  utils/api/         │  │   fixtures/ai-fixtures  │
│  - auth-helper      │  │   - smartLocator        │
│  - otp-helper       │  │   - aiAssertions        │
└─────────┬───────────┘  └───────────┬──────────────┘
          │                          │
          └──────────┬───────────────┘
                     ▼
          ┌──────────────────────────┐
          │    AI Helpers            │
          │    utils/ai-helpers/     │
          │    - ai-assertions       │
          │    - test-generator      │
          │    - self-healing        │
          └──────────┬───────────────┘
                     ▼
          ┌──────────────────────────┐
          │    Claude API Client     │
          │    config/ai-client.ts   │
          └──────────────────────────┘
```

### Design Principles

1. **Separation of Concerns**
   - User code uses helpers
   - Helpers use framework utilities
   - Framework utilities use AI client

2. **Helper-First Approach**
   - All navigation/actions in helpers
   - Tests are declarative and clean
   - Logic is reusable and testable

3. **AI as Enhancement**
   - Framework works without AI
   - AI features are optional
   - Always provide fallbacks

4. **Cost Consciousness**
   - Choose cheapest model that works
   - Cache aggressively
   - Make AI features toggleable

---

## 🔄 When to Update the Template

After improving the framework, update the template for users:

### Run create-template Script

```bash
# This converts your project into a clean template
npm run create-template
```

**What it does:**
- Removes project-specific tests and helpers
- Keeps framework code and examples
- Copies user commands to `.claude/commands/`
- Removes framework dev files (`CLAUDE-DEV.md`, etc.)
- Updates documentation for end users

**When to run it:**
- After adding a significant new framework feature
- After fixing important framework bugs
- Before sharing template with others
- When preparing a new framework version

### What Gets Removed

The script removes:
- Project-specific tests (except `tests/examples/`)
- Project-specific helpers (except core framework helpers)
- `.claude/commands-dev/` (framework dev commands)
- `CLAUDE-DEV.md` (this file)
- `new_ideas/` (development notes)
- `TODO_framework.md`

### What Gets Kept

The script keeps:
- Framework code (`config/`, `fixtures/`, `utils/ai-helpers/`, `utils/selectors/`)
- Core helpers (`auth-helper.ts`, `otp-helper.ts`)
- Example tests (`tests/examples/`)
- Documentation (`docs/AI-MODEL-STRATEGY.md`, etc.)
- User commands (`.claude/commands/`)
- `CLAUDE.md` (for users)

---

## 🚀 Quick Reference

### Adding a New AI Helper

```bash
# 1. Use the command
/improve-framework "Add {feature} helper"

# 2. Create helper file
# utils/ai-helpers/new-helper.ts

# 3. Choose AI model (Haiku/Sonnet/Opus)

# 4. Implement with caching and error handling

# 5. Update AI-MODEL-STRATEGY.md with costs

# 6. Create example test
# tests/examples/new-helper-example.spec.ts

# 7. Test with real API calls
npm test tests/examples/new-helper-example.spec.ts

# 8. Update CLAUDE.md if user-facing

# 9. Commit with "framework:" prefix
```

### Fixing a Framework Bug

```bash
# 1. Use the command
/fix-framework "Bug description"

# 2. Reproduce the bug

# 3. Identify root cause

# 4. Fix minimally (don't refactor while fixing)

# 5. Test thoroughly
npm test

# 6. Commit with clear explanation of bug, root cause, and fix
```

### Before Sharing Template

```bash
# 1. Test everything works
npm test

# 2. Create template
npm run create-template

# 3. Test template
npm test

# 4. Review and commit template changes
```

---

## 📖 Additional Resources

### Key Files to Understand

- `config/ai-client.ts` - How AI API calls are made
- `fixtures/ai-fixtures.ts` - How fixtures extend Playwright
- `utils/selectors/self-healing.ts` - How self-healing works
- `docs/AI-MODEL-STRATEGY.md` - Model selection strategy

### Testing Best Practices

- Always test with real API calls
- Verify caching works
- Check error handling
- Test in all browsers
- Ensure backwards compatibility

### Cost Monitoring

- Check Anthropic dashboard for actual costs
- Compare with estimates in AI-MODEL-STRATEGY.md
- Optimize if costs are higher than expected
- Document any cost surprises

---

## ⚠️ Important Reminders

1. **English Only**: All code, comments, docs must be in English
2. **Test Before Commit**: Run `npm test` - all must pass
3. **Document Costs**: Update AI-MODEL-STRATEGY.md for AI features
4. **Create Examples**: Always add example test in `tests/examples/`
5. **Backwards Compatible**: Don't break existing user code
6. **Framework Branch**: Use `framework/` prefix for branches
7. **Framework Commit**: Start commit message with `framework:`

---

**You're improving the framework for QA testers around the world. Make it reliable, cost-effective, and well-documented!**
