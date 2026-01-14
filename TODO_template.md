# TODO: Template Improvements & Fixes

This file tracks improvements, bugs, and changes discovered while working on projects that should be applied back to the base template.

## 🐛 Bugs / Fixes

(No open bugs)

---

## ✨ Enhancements

### [ENHANCE-006] Fix /review-changes Command to Use Agent
**Date:** 2026-01-14
**Priority:** High
**Status:** Pending

**Goal:**
Fix `/review-changes` command to automatically launch a Task agent instead of just showing documentation.

**Problem:**
Currently `/review-changes` only displays instructions but doesn't execute the review. User must wait indefinitely without feedback.

**Solution:**
Update `.claude/commands/review-changes.md` to use Task tool with general-purpose agent:
- Compare branches automatically
- Read changed files
- Analyze code quality, bugs, security, testing
- Generate structured report with verdict

**Benefits:**
- 7x cheaper than doing review in main conversation (~$0.25 vs ~$1.80)
- Isolated context (doesn't pollute main conversation)
- Automated execution (no waiting for me to do it manually)
- Progress visibility

**Reference:**
- Official command example: `~/.claude/plugins/.../pr-review-toolkit/commands/review-pr.md`
- Uses Task tool for code review

---

### [ENHANCE-002] Semantic Versioning Reminders
**Date:** 2026-01-14
**Priority:** Medium
**Status:** ✅ IMPLEMENTED

**Goal:**
Add clear reminders about semantic versioning in framework development docs.

**What was implemented:**
Added comprehensive "Semantic Versioning Reminder" section to `CLAUDE-DEV.md` with:
- Version types (PATCH/MINOR/MAJOR) with examples
- Version bump checklist (7 steps)
- Git tagging workflow
- GitHub Release creation workflow
- Reference example from v1.4.2 release

Updated framework commands (`.claude/commands/`):
- `improve-framework.md` - Added versioning steps in Phase 5
- `fix-framework.md` - Added versioning steps in Phase 5

**Location:**
- `CLAUDE-DEV.md` - Section "Semantic Versioning Reminder" (lines 258-401)
- `.claude/commands/improve-framework.md` - Phase 5 steps 3-4, 8
- `.claude/commands/fix-framework.md` - Phase 5 steps 3-4, 8

**Benefit:**
- Consistent versioning across releases
- Clear guidance for framework developers
- Automated workflow for tagging and releases
- Reference example for future releases

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

### [ENHANCE-004] Clean create-template.ts from SIMA references
**Date:** 2026-01-14
**Priority:** Medium
**Status:** ✅ IMPLEMENTED

**Goal:**
Remove SIMA-specific references and simplify template generation script.

**What was implemented:**
1. Removed all SIMA references from comments and code
2. Eliminated TO_DELETE array with SIMA-specific file paths
3. Removed deleteItems() function (no longer needed)
4. Removed createExampleFiles() function (files already exist in repo)
5. Updated .gitignore to ignore .selector-cache.json in framework source

**Impact:**
- Script reduced from 877 to 694 lines (-183 lines, -21%)
- Now truly generic and reusable
- No more SIMA-specific logic
- Users generate their own selector cache when working WITH template

**Testing:**
- TypeScript compilation verified
- Framework tests pass: 3/3
- No SIMA references remain

**Location:**
- `scripts/create-template.ts` - Complete cleanup
- `.gitignore` - Updated to ignore .selector-cache.json

**Benefit:**
- Truly reusable template generation script
- No confusion about SIMA project
- Simplified maintenance

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
