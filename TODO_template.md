# TODO: Template Improvements & Fixes

This file tracks improvements, bugs, and changes discovered while working on projects that should be applied back to the base template.

## 🐛 Bugs / Fixes

(No open bugs)

---

## ✨ Enhancements

### [ENHANCE-002] Semantic Versioning Reminders
**Date:** 2026-01-14
**Priority:** Medium
**Status:** Pending

**Goal:**
Add clear reminders about semantic versioning in framework development docs.

**Where:**
- `CLAUDE-DEV.md` - Framework development guide
- `.claude/commands/` - Framework command files

**Content:**
```markdown
## Semantic Versioning Reminder

Before committing framework changes:

- **PATCH (1.x.Y)**: Bug fixes, no new features
  - Example: Fix broken selector, fix typo in docs

- **MINOR (1.X.0)**: New features, backwards compatible
  - Example: New AI helper, new command, new script

- **MAJOR (X.0.0)**: Breaking changes (rare)
  - Example: Change API, remove features, incompatible changes

**Checklist:**
1. Update `package.json` version
2. Add entry to `CHANGELOG.md`
3. Update `README.md` version badge
4. Ask user before committing/pushing
```

**Benefit:**
- Consistent versioning across releases
- Clear guidance for framework developers

---

### [ENHANCE-003] Git Operations Protocol
**Date:** 2026-01-14
**Priority:** High
**Status:** ✅ IMPLEMENTED

**Goal:**
Add mandatory review protocol before pushing to remote.

**What was implemented:**
Added "Git & Review Protocol (MANDATORY)" section to `CLAUDE-DEV.md` with:
- Step-by-step checklist before pushing
- Mandatory `/review-changes` before commits to main
- Clear explanation of why review is critical
- Exception rules for trivial changes

**Location:**
- `CLAUDE-DEV.md` - Section "Git & Review Protocol (MANDATORY)"

**Benefit:**
- Catches issues before they become public
- Validates documentation consistency
- Ensures code quality standards
- No PR safety net when committing to main directly

---

### [ENHANCE-004] Update create-template.ts
**Date:** 2026-01-14
**Priority:** Medium
**Status:** Pending (depends on FIX-002)

**Goal:**
Update template generation script to correctly filter commands.

**Details:**
- Ensure only user-facing commands go to template
- Exclude framework development commands
- Handle new command structure (after FIX-002 is resolved)

**Location:**
- `scripts/create-template.ts`

**Benefit:**
- Clean template for end users
- No confusion with framework dev commands

---

### [ENHANCE-005] Rename TODO File
**Date:** 2026-01-14
**Priority:** Low
**Status:** Pending

**Goal:**
Rename `TODO_template.md` to `TODO_framework.md` for clarity.

**Reason:**
- Current name "template" is ambiguous
- "framework" better describes it's for framework development TODOs
- Consistent with other naming (CLAUDE-DEV.md, framework/* branches)

**Action:**
```bash
git mv TODO_template.md TODO_framework.md
```

**Files to update:**
- `.gitignore` (update reference if exists)
- Any docs mentioning this file

**Benefit:**
- Clearer purpose
- Better naming consistency

---

## 📝 Notes

- Update this file whenever you find something while working on projects
- Review and apply changes to template periodically (e.g., after completing important features)
- Keep the format: Date, clear description, before/after code, priority
- Completed items are removed after being implemented and released

## ✅ Completed (Archive)

### v1.4.1 - 2026-01-14

- **[FIX-002]** Command Structure Issue - Fixed command organization for Claude Code Skill tool compatibility

### v1.2.0 - 2026-01-13

- **[FIX-001]** Hardcoded URL in auth-helper.ts - Fixed with strict APP_URL validation
- **[ENHANCE-001]** English-only language standard - Added Code Standards section to CLAUDE.md
