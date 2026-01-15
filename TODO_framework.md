# TODO: Framework Improvements & Fixes

This file tracks improvements, bugs, and changes discovered while working on the framework that should be applied to future versions.

## 🐛 Bugs / Fixes

(No open bugs)

---

## ✨ Enhancements

### [ENHANCE-007] Review Command Improvements
**Date:** 2026-01-14
**Priority:** Low
**Status:** ⏸️ Pending

**Goal:**
Minor improvements to `/review-changes` command based on agent review feedback.

**Improvements to consider:**

1. **Add troubleshooting section**:
   - Command doesn't execute
   - No files to review
   - Agent fails to start
   - Common error messages and solutions

**Benefits:**
- More robust error handling
- Better compatibility with different git setups
- Clearer documentation for edge cases

**Note:** These are nice-to-have improvements. The command works correctly without them. Items 1-3 from original list (prompt format, fallback, file list format) were mistakenly listed in v1.5.1 CHANGELOG but not implemented. They will be implemented in a future version.

---

## 📝 Notes

- Update this file whenever you find something while working on the framework
- Review and apply changes to framework periodically (e.g., after completing important features)
- Keep the format: Date, clear description, before/after code, priority
- Completed items are moved to Archive section organized by version
- Archive entries are brief summaries - full details are in CHANGELOG.md

---

## ✅ Completed (Archive)

### v1.5.1 - 2026-01-14

#### [ENHANCE-006] Fix /review-changes Command to Use Agent
- Rewrote command file with executable workflow using Task tool
- Added `allowed-tools: ["Bash", "Task", "Read"]` in frontmatter
- Simplified from 454 to 294 lines (35% reduction)
- Benefits: 7x cheaper (~$0.25 vs ~$1.80), automated execution

#### [ENHANCE-004] Clean create-template.ts from SIMA references
- Removed all SIMA-specific references from template generation script
- Eliminated TO_DELETE array, deleteItems(), and createExampleFiles()
- Simplified from 877 to 694 lines (-183 lines, -21%)
- Framework now truly generic and reusable

#### [ENHANCE-005] Rename TODO File
- Renamed TODO_template.md → TODO_framework.md for clarity
- Updated title: "Framework Improvements & Fixes"
- Reorganized structure: pending items first, archive by version
- Updated references in README.md, CLAUDE-DEV.md, create-template.ts

---

### v1.5.0 - 2026-01-14

#### [ENHANCE-002] Semantic Versioning Reminders
- Added comprehensive "Semantic Versioning Reminder" section to CLAUDE-DEV.md
- Version types (PATCH/MINOR/MAJOR) with examples
- 7-step version bump checklist with git tagging workflow
- Updated framework commands (improve-framework.md, fix-framework.md)

---

### v1.4.2 - 2026-01-14

#### [ENHANCE-003] Git Operations Protocol
- Added "Git & Review Protocol (MANDATORY)" section to CLAUDE-DEV.md
- Mandatory `/review-changes` before commits to main
- Step-by-step checklist before pushing to remote
- Catches issues before they become public

---

### v1.4.1 - 2026-01-14

#### [FIX-002] Command Structure Issue
- Fixed command organization for Claude Code Skill tool compatibility

---

### v1.2.0 - 2026-01-13

#### [FIX-001] Hardcoded URL in auth-helper.ts
- Fixed with strict APP_URL validation
- Now throws descriptive error if APP_URL not configured

#### [ENHANCE-001] English-only language standard
- Added Code Standards section to CLAUDE.md
- Explicit requirement for all code, comments, tests in English
