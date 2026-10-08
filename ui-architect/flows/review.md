# Flow: UI/UX review

Use this for "review this screen", "review this PR for UX" or "is this UI OK?". It is **not** a bug hunt; it covers UX quality and consistency.

## Scope
- **The target:** a screen, a component, changed files, or a PR diff.
- **Compare against:** the decisions file (if any), the existing patterns, and this skill's quality bar.

## What to check
1. **UX:** clear purpose, sensible flow, number of clicks, obvious primary action, feedback after actions, how destructive actions are confirmed.
2. **Consistency:** same patterns, components, spacing, density, icons and wording as similar screens.
3. **States:** loading, empty, error, success and no permission are all designed.
4. **Edge data:** long text, 0 / 1 / many items, large numbers.
5. **Responsive:** 360 / 768 / 1280px.
6. **Accessibility:** keyboard, labels, contrast, focus, dialogs.
7. **Text:** clear, specific, consistent terms.
8. **Code shape (UI-relevant only):** reuse vs duplication, giant files, raw colours, `any`.

## Output
- **Verdict line:** Ready / Ready with small fixes / Needs changes.
- **Findings,** most important first. Each one has:
  - **severity** (High / Medium / Low)
  - the **file:line** or screen area
  - **the problem**
  - **the suggested fix**
- **What's done well:** 2–3 bullets, so good patterns are kept.
- **Don't change code** unless the user asks. Then use `flows/improvements.md` or `flows/bug-fix.md`.
