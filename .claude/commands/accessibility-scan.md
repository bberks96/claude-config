# Accessibility Scan

You are orchestrating an accessibility audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Screen Reader & Semantic HTML

> You are an accessibility auditor. Hunt for barriers that prevent a blind user relying on a screen reader from using this app. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Images: do all `<img>` tags have a meaningful `alt` attribute?
> - Icon buttons: do buttons with only an icon have an `aria-label`?
> - Interactive `<div>` / `<span>`: `onClick` handlers on non-semantic elements without `role="button"` and `tabIndex`?
> - Landmarks: does the page use semantic HTML elements (`<nav>`, `<main>`, `<header>`, `<footer>`)?
> - Dynamic content: when content updates without a page reload, is `aria-live` used?
>
> Report every finding with file path and line number.

---

### AGENT 2 — Keyboard Navigation & Focus

> You are an accessibility auditor. Hunt for barriers that prevent keyboard-only navigation. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Focus trapping: when a modal opens, does focus move into it? When it closes, does focus return?
> - Focus visible: is the focus indicator visible?
> - Keyboard traps: any places where focus gets stuck?
> - Skip links: is there a "Skip to main content" link as the first focusable element?
>
> Report every finding with file path and line number.

---

### AGENT 3 — Visual & Color

> You are an accessibility auditor. Hunt for visual design issues. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Color contrast: text has at least 4.5:1 contrast ratio?
> - Color as the only indicator: is color the only way information is conveyed?
> - Animations: are there animations that flash more than 3 times per second? Is `prefers-reduced-motion` used?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Forms & Error Handling

> You are an accessibility auditor. Hunt for form issues that prevent users with disabilities from completing tasks. Rate every finding High / Medium / Low.
>
> Check every file in `src/` that contains forms or inputs:
> - Labels: does every form input have an associated `<label>` or `aria-label`?
> - Error messages: are errors programmatically associated with fields using `aria-describedby`?
> - Required fields: marked with both visual indicator AND `aria-required="true"` or `required`?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `ACCESSIBILITY_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Accessibility Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.