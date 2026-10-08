# Testing ui-architect

How to check the skill works in your tool (Antigravity, Gemini CLI, Codex, Claude Code). Each test is one prompt in a **new conversation**, opened at the project root. Compare what the agent does with **Expect**.

Run the read-only tests on a real project. Run the new-project test in an empty folder.

**Tip:** for tests on a real project, add *"This is a test: don't change any files, show what you would change instead."* to the prompt.

---

## 0. Is the skill installed and loaded?
**Prompt:** "What skills do you have available? What version is ui-architect?"
**Expect:** it lists `ui-architect` and reports the version from the top of SKILL.md (e.g. 2.2.0).

## 1. Existing project, first analysis
**Prompt:** "Use the ui-architect skill and analyse this project."
**Expect:**
- [ ] One line with the mode (Existing) and the frontend root
- [ ] 8 areas, each as current → problem → improvement → High/Medium/Low, with real file paths
- [ ] A top 5 to fix first
- [ ] **Asks** before creating `docs/ui-decisions.md` (doesn't just create it)
- [ ] One stop, with at most 3 questions

## 2. Flow loading (the most important check for non-Claude tools)
**Prompt:** after test 1, ask: "Which ui-architect files did you read for that?"
**Expect:** `SKILL.md`, `flows/existing-project.md` and `templates/analysis-template.md`. **Not** all the flows.
If it only read SKILL.md, the tool isn't following the routing table. Tell it: "Read flows/existing-project.md from the skill folder."

## 3. Feature with a form
**Prompt:** "Use ui-architect to add an Add Customer form with Name, Email, Mobile, PAN, GSTIN, Pincode, Date of birth."
**Expect:**
- [ ] Restates the request, asks only what's missing, and gives a UX recommendation
- [ ] Plans **custom** components (no native date, select or checkbox), and asks before building missing shared ones
- [ ] The validation table has a **Source** column, with web links for PAN, GSTIN, mobile and pincode (or "unverified – please confirm")
- [ ] Acceptance criteria, an ASCII wireframe, edge data, and a mock if there's no backend
- [ ] Doesn't write code until you approve the plan

## 4. Small change
**Prompt:** "Use ui-architect to add a 'Created date' column to the products table."
**Expect:** a short path (no full plan, no checkpoint unless it's ambiguous). It follows the existing table and date patterns, and the hand-over has a manual check list.

## 5. Bug fix
**Prompt:** "Use ui-architect: the Add Stock popup doesn't close when I click outside."
**Expect:**
- [ ] States the root cause before fixing
- [ ] Minimal fix in existing patterns, no refactor
- [ ] Reports the same bug elsewhere without fixing it
- [ ] Hand-over with a manual check list and affected screens

## 6. Hotfix
**Prompt:** "Use ui-architect, URGENT: production is broken, the Add Stock popup can't be closed."
**Expect:** no analysis and no questions before the fix. Smallest fix. A follow-up note on the proper fix.

## 7. Match a design
**Prompt:** "Use ui-architect: this page doesn't match the design, fix it." + attach the design image.
**Expect:**
- [ ] Treats the image as the spec to match
- [ ] Lists the differences as current → expected, using your tokens
- [ ] Applies the visual-only differences and asks about the behaviour or content changes
- [ ] Doesn't copy logos or brands

## 8. Batch improvements
**Prompt:** "Use ui-architect to fix the High items from the analysis, one batch at a time."
**Expect:** a batch plan ordered by risk, at most about 6 files per batch, a manual check per batch, and an affected-screens table. Stops before Batch 1.

## 9. Dark mode
**Prompt:** "Use ui-architect to add dark mode."
**Expect:**
- [ ] Reads your Tailwind version and config
- [ ] Audit with counts
- [ ] Tokens as CSS variables (`:root` / `.dark`)
- [ ] A mapping table
- [ ] Asks before writing a preview into `docs/`
- [ ] A batch plan

## 10. New project (empty folder)
**Prompt:** "Use ui-architect. I want to build a CRM for small sales teams in India."
**Expect:** this order, with a stop after each step:
1. idea + decisions question
2. folder structure
3. density + theme format
4. theme
5. state, auth, formatting, pages and build order

Setup lists env, alias, lint, error pages, mocks, `/dev/ui`, README, the custom controls and validators, and lazy routes.

## 11. Should NOT trigger
**Prompts:** "Write the Express endpoint for /api/leads" · "Fix the failing Jest test" · "Build a landing page in Vue"
**Expect:** the skill isn't used, or it says the request is out of scope.

---

## Scoring
- **Pass:** every box ticked.
- **Partial:** the main behaviour is right but 1–2 boxes are missing. Note which ones.
- **Fail:** wrong mode, code written before approval, files created without asking, or the skill not used.

Report failures with the prompt, what happened, and which file the agent read. That's enough to fix the skill.
