# Improvement Specification: Automatic /new-screen Command

> **Status:** Planning
> **Created:** 2026-01-21
> **Type:** Enhancement to existing command
> **Priority:** High (UX blocker)

---

## 📋 Problem Statement

The current `/new-screen` command has a **manual, interactive workflow** that requires users to:

1. Launch Playwright codegen manually
2. Explore the UI by clicking elements
3. Observe and copy selectors
4. Report back findings to Claude
5. Answer follow-up questions

**User Feedback:**
> "I don't want to participate in the codegen exploration process. The AI should do the work automatically."

**Current Workflow (Too Manual):**
```bash
User: /new-screen login

Claude:
  1. Launches codegen → npm run test:codegen
  2. Waits for user to explore manually
  3. Asks: "What selectors did you find?"
  4. User must copy/paste selectors
  5. Claude then generates code

Problem: Steps 2-4 are manual and time-consuming
```

---

## 🎯 Desired Solution

**Fully automatic workflow** where AI does all the exploration:

```bash
User: /new-screen login

Claude:
  1. ✅ Reads docs/LOGIN-TEST-CASES.md (already works)
  2. ✅ Automatically captures screenshot from APP_URL
  3. ✅ Uses AI vision to identify selectors
  4. ✅ Generates helper + tests automatically
  5. ✅ No user interaction needed (except approval)

Result: Helper and tests generated in seconds, not minutes
```

**Key Improvement:** Replace manual codegen exploration with AI vision analysis.

---

## 🏗️ Technical Design

### Architecture

```
┌─────────────────────────────────────────────────────────┐
│  /new-screen login (Command Entry Point)               │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Phase 0: Setup & Validation                            │
│  - Create feature branch                                │
│  - Read docs/LOGIN-TEST-CASES.md                        │
│  - Extract P1 test cases                                │
│  - Get APP_URL from .env                                │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Phase 1: Automatic UI Analysis (NEW!)                  │
│  - Capture screenshot from URL                          │
│  - Use AI vision to identify elements                   │
│  - Extract selectors automatically                      │
│  - Identify login flow patterns                         │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Phase 2: Plan Tests by Priority                        │
│  - Map P1 test cases to identified elements             │
│  - Determine which tests are automatable                │
│  - Plan helper methods needed                           │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Phase 3: Generate Code                                 │
│  - Create utils/api/{screen}-helper.ts                  │
│  - Create tests/{screen}/{screen}-p1.spec.ts            │
│  - Create docs/{SCREEN}-P2-P3-TESTS.md                  │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Phase 4: Test & Validate                               │
│  - Run generated tests                                  │
│  - Fix any issues                                       │
│  - Ensure all P1 tests pass                             │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Phase 5: Document & Commit                             │
│  - Update documentation                                 │
│  - Create commit with changes                           │
└─────────────────────────────────────────────────────────┘
```

---

## 🔧 Implementation Details

### Phase 1 Redesign: Automatic UI Analysis

**Current implementation (manual):**
```markdown
# In .claude/commands-user/new-screen.md

Now I need to explore the {screen} page using Playwright codegen...

<tool>
  <name>Bash</name>
  <params>
    <command>npm run test:codegen</command>
    <run_in_background>true</run_in_background>
  </params>
</tool>

Please let me know when you've finished exploring...
```

**New implementation (automatic):**
```markdown
# In .claude/commands-user/new-screen.md

Now I'll automatically analyze the {screen} page using AI vision to identify selectors.

First, let me capture a screenshot and analyze the UI:

<tool>
  <name>Task</name>
  <params>
    <subagent_type>general-purpose</subagent_type>
    <prompt>
      Analyze the {screen} page and extract selectors automatically.

      URL: {APP_URL}/login (from .env)

      Steps:
      1. Use captureScreenshotFromUrl() from test-case-planner.ts
      2. Use AI vision (Sonnet) to identify:
         - Input fields (email, password, etc.)
         - Buttons (submit, forgot password, etc.)
         - Links (register, help, etc.)
         - Error message locations
         - Success redirect patterns
      3. Return structured selector data

      Output format:
      {
        "selectors": {
          "emailInput": "input[name='email']",
          "passwordInput": "input[name='password']",
          "submitButton": "button[type='submit']",
          ...
        },
        "redirectAfterLogin": "/dashboard",
        "errorMessageSelector": ".error-message"
      }
    </prompt>
  </params>
</tool>
```

---

## 📁 Files to Modify

### 1. `.claude/commands-user/new-screen.md` (Main Changes)

**Section to Replace:** Phase 1 (Explore UI)

**Before (lines ~50-100):**
```markdown
## Phase 1: Explore UI

Now I need to explore the {screen} page using Playwright codegen...

<Bash run_in_background>npm run test:codegen</Bash>

Please let me know when you've finished exploring the login UI with codegen...
[Manual wait for user input]
```

**After:**
```markdown
## Phase 1: Automatic UI Analysis

Now I'll automatically analyze the {screen} page using AI vision.

Let me capture and analyze the UI:

<Task subagent_type="general-purpose">
Analyze the {screen} page at {APP_URL}{path} and extract selectors.

Use these utilities:
- `utils/ai-helpers/test-case-planner.ts` → captureScreenshotFromUrl()
- `config/ai-client.ts` → askWithImage() for AI vision

Steps:
1. Capture screenshot from URL
2. Use AI vision (Sonnet) to identify:
   - All input fields (with their purpose: email, password, etc.)
   - All buttons (submit, cancel, etc.)
   - All links (navigation, forgot password, etc.)
   - Error message locations
   - Success indicators
   - Post-action redirect URL

3. Extract Playwright selectors (prefer data-testid, then name, then role, then text)

4. Return JSON with:
   - selectors: { fieldName: "selector", ... }
   - redirectUrl: "/path/after/success"
   - errorSelectors: ["selector1", "selector2"]
   - timing: { loadTime: "networkidle", asyncOperations: true/false }

Output the JSON so I can use it to generate the helper and tests.
</Task>

[Continue with code generation using the extracted selector data]
```

---

### 2. New Utility Function (Optional but Recommended)

Create `utils/ai-helpers/selector-extractor.ts`:

```typescript
import { chromium } from '@playwright/test';
import { aiClient } from '../../config/ai-client';
import * as fs from 'fs';

interface SelectorExtractionResult {
  selectors: Record<string, string>;
  redirectUrl: string;
  errorSelectors: string[];
  timing: {
    loadTime: 'load' | 'networkidle' | 'domcontentloaded';
    asyncOperations: boolean;
  };
}

export class SelectorExtractor {
  /**
   * Automatically extract selectors from a page using AI vision
   */
  async extractSelectors(url: string, pageType: string): Promise<SelectorExtractionResult> {
    // 1. Capture screenshot
    const browser = await chromium.launch({ headless: true });
    const page = await browser.newPage();

    try {
      await page.goto(url);
      await page.waitForLoadState('networkidle');

      const screenshot = await page.screenshot({ fullPage: true });
      const screenshotBase64 = screenshot.toString('base64');

      // 2. Extract DOM structure
      const domStructure = await page.evaluate(() => {
        const elements: any[] = [];

        // Inputs
        document.querySelectorAll('input').forEach((el) => {
          elements.push({
            type: 'input',
            inputType: el.type,
            name: el.name,
            id: el.id,
            placeholder: el.placeholder,
            'data-testid': el.getAttribute('data-testid'),
            role: el.getAttribute('role'),
            ariaLabel: el.getAttribute('aria-label'),
          });
        });

        // Buttons
        document.querySelectorAll('button').forEach((el) => {
          elements.push({
            type: 'button',
            text: el.textContent?.trim(),
            buttonType: el.type,
            id: el.id,
            'data-testid': el.getAttribute('data-testid'),
            role: el.getAttribute('role'),
          });
        });

        // Links
        document.querySelectorAll('a').forEach((el) => {
          elements.push({
            type: 'link',
            text: el.textContent?.trim(),
            href: el.href,
            id: el.id,
            'data-testid': el.getAttribute('data-testid'),
          });
        });

        return elements;
      });

      // 3. Use AI vision to identify elements and generate selectors
      const prompt = `
Analyze this ${pageType} page screenshot and the DOM structure to identify elements and generate Playwright selectors.

DOM Structure:
${JSON.stringify(domStructure, null, 2)}

For a ${pageType} page, identify:
1. All input fields with their purpose (email, password, username, etc.)
2. Primary action button (submit/login button)
3. Secondary actions (forgot password, register, cancel, etc.)
4. Error message locations
5. Success indicators
6. Where the page redirects after successful action

For each element, provide the BEST Playwright selector following this priority:
1. [data-testid="..."] (preferred)
2. [name="..."] (for inputs)
3. [role="..."] (for accessibility)
4. text="..." (for buttons/links with unique text)
5. CSS selector (last resort)

Return ONLY a JSON object with this structure:
{
  "selectors": {
    "fieldName": "playwright-selector",
    "submitButton": "button[type='submit']",
    ...
  },
  "redirectUrl": "/expected/redirect/path",
  "errorSelectors": ["selector-for-error-messages"],
  "timing": {
    "loadTime": "networkidle",
    "asyncOperations": false
  }
}

IMPORTANT:
- Use camelCase for field names
- Return ONLY the JSON, no explanation
- Be specific and accurate with selectors
`;

      const response = await aiClient.askWithImage(
        prompt,
        screenshotBase64,
        'image/png',
        { model: 'sonnet', maxTokens: 2048 }
      );

      await browser.close();

      // 4. Parse AI response
      try {
        const result = JSON.parse(response);
        return result;
      } catch (error) {
        console.error('Failed to parse AI response:', error);
        throw new Error('AI vision selector extraction failed');
      }

    } catch (error) {
      await browser.close();
      throw error;
    }
  }
}
```

---

## 📚 Files to Reference/Reuse

| File | What to Reuse | How |
|------|---------------|-----|
| `utils/ai-helpers/test-case-planner.ts` | `captureScreenshotFromUrl()` | Screenshot capture logic |
| `utils/ai-helpers/test-case-planner.ts` | `extractInteractiveElements()` | DOM element extraction |
| `utils/ai-helpers/test-generator.ts` | AI vision prompt patterns | How to ask AI to identify elements |
| `config/ai-client.ts` | `askWithImage()` | Send screenshot to Claude with Sonnet |
| `.claude/commands-user/new-screen.md` | Current workflow structure | Keep phases 2-6, only change phase 1 |

---

## ✅ Acceptance Criteria

### Must Have

- [ ] `/new-screen login` command runs without requiring manual codegen exploration
- [ ] Automatically captures screenshot from `{APP_URL}/login` (or path specified)
- [ ] Uses AI vision (Sonnet) to identify selectors automatically
- [ ] Extracts at minimum:
  - Input field selectors (email, password, etc.)
  - Submit button selector
  - Expected redirect URL after success
  - Error message selector
- [ ] Generates `login-helper.ts` with correct selectors
- [ ] Generates `login-p1.spec.ts` with passing tests
- [ ] No user interaction required except initial command and final approval
- [ ] Works for common page types (login, register, dashboard, etc.)

### Should Have

- [ ] Handles pages that require authentication (skip screenshot if needed)
- [ ] Detects timing/async requirements automatically
- [ ] Provides confidence score for extracted selectors
- [ ] Falls back gracefully if AI vision fails

### Nice to Have (Future)

- [ ] Interactive mode flag: `--interactive` to use old manual workflow
- [ ] Validate selectors by actually navigating and checking they exist
- [ ] Screenshot annotation showing which elements were identified

---

## 🧪 Testing Strategy

### Test Cases

1. **Basic login page** (email + password + submit)
   - URL: Any standard login page
   - Expected: Correctly identifies 3 main elements

2. **Complex login page** (with OAuth, forgot password, register links)
   - URL: Page with 10+ interactive elements
   - Expected: Identifies all correctly, prioritizes main flow

3. **Login page with OTP/2FA**
   - URL: Multi-step login
   - Expected: Identifies first step, mentions additional steps needed

4. **Page requiring authentication**
   - URL: /dashboard (requires login first)
   - Expected: Graceful error or automatic login using credentials

5. **Page with no clear form**
   - URL: Static content page
   - Expected: Clear error message about unsuitability

---

## 💰 Cost Analysis

### Current Manual Workflow
- **User time:** ~5-10 minutes (exploring, copying selectors)
- **AI cost:** ~$0.02-0.05 (only for code generation)
- **Total:** 5-10 minutes + $0.02-0.05

### New Automatic Workflow
- **User time:** ~30 seconds (just running command)
- **AI cost:** ~$0.10-0.15 (screenshot analysis + code generation)
  - Screenshot capture: Free (Playwright)
  - AI vision analysis (Sonnet): ~$0.05-0.10
  - Code generation: ~$0.02-0.05
- **Total:** 30 seconds + $0.10-0.15

**Trade-off:** Spend ~$0.08 more in AI costs to save 5-10 minutes of manual work. **Worth it!**

---

## 🚀 Implementation Steps

### Phase 1: Create Selector Extractor Utility (Optional)
- [ ] Create `utils/ai-helpers/selector-extractor.ts`
- [ ] Implement `extractSelectors()` method
- [ ] Add tests for selector extraction
- [ ] Document usage

### Phase 2: Modify /new-screen Command (Required)
- [ ] Read `.claude/commands-user/new-screen.md`
- [ ] Identify Phase 1 section (Explore UI)
- [ ] Replace manual codegen workflow with automatic AI vision analysis
- [ ] Update prompt to use Task tool with general-purpose agent
- [ ] Ensure extracted selectors are passed to subsequent phases

### Phase 3: Test End-to-End
- [ ] Test with real login page
- [ ] Verify selectors are extracted correctly
- [ ] Verify helper is generated with correct selectors
- [ ] Verify tests are generated and pass
- [ ] Test error cases (page not found, invalid URL, etc.)

### Phase 4: Documentation
- [ ] Update `.claude/commands-user/new-screen.md` inline docs
- [ ] Update `CLAUDE.md` with new workflow description
- [ ] Update `docs/PROJECT-OVERVIEW.md` to reflect automatic workflow
- [ ] Add examples to `GETTING-STARTED.md`

---

## 🎯 Success Criteria

The improvement is successful when:

1. ✅ User runs `/new-screen login` and gets generated code **without any manual exploration**
2. ✅ Generated helper has accurate selectors that work on the target page
3. ✅ Generated tests pass on first run (or require minimal fixes)
4. ✅ Workflow takes <2 minutes end-to-end (vs 10+ minutes currently)
5. ✅ User feedback: "This is exactly what I expected - fully automatic!"

---

## 📝 Example Session (After Improvement)

```bash
User: /new-screen login

Claude:
  ✅ Phase 0: Setup
     - Created branch: feature/test-login-page
     - Read docs/LOGIN-TEST-CASES.md (found 8 test cases, 3 P1)

  ✅ Phase 1: Automatic UI Analysis
     - Captured screenshot from https://nexo360-portal.vercel.app/login
     - AI vision identified 5 elements:
       • emailInput: input[name="email"]
       • passwordInput: input[name="password"]
       • submitButton: button[type="submit"]
       • forgotPasswordLink: a:has-text("Forgot password?")
       • errorMessage: .error-message
     - Detected redirect: /dashboard

  ✅ Phase 2: Test Planning
     - P1-001: Valid login → Automatable ✓
     - P1-002: Invalid credentials → Automatable ✓
     - P1-003: Empty fields → Automatable ✓

  ✅ Phase 3: Code Generation
     - Created: utils/api/login-helper.ts
     - Created: tests/login/login-p1.spec.ts
     - Created: docs/LOGIN-P2-P3-TESTS.md

  ✅ Phase 4: Testing
     - Running tests... ✓ 3/3 passed

  ✅ Phase 5: Documentation & Commit
     - Ready to commit!

  Total time: 45 seconds
```

---

## 🔗 Related Documentation

- Current command: `.claude/commands-user/new-screen.md`
- Selector extraction reference: `utils/ai-helpers/test-case-planner.ts`
- AI vision reference: `utils/ai-helpers/test-generator.ts`
- Project overview: `docs/PROJECT-OVERVIEW.md`

---

**Last Updated:** 2026-01-21
**Author:** Juan (with Claude Code assistance)
**Status:** Ready for implementation
**Estimated Effort:** 2-3 hours
**Priority:** High (blocking user workflow)
