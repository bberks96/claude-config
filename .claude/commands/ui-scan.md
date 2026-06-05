# UI Consistency Scan

You are orchestrating a UI consistency and design system audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Design Tokens & Theming Architecture

> You are a UI/design systems engineer. Evaluate whether colors, spacing, and typography are centralized as tokens. Rate every finding High / Medium / Low.
>
> Check `tailwind.config.ts`, CSS files, and every file in `src/`:
> - Color tokens: colors defined as named semantic tokens in `tailwind.config.ts`?
> - Hardcoded colors: grep for hex values (`#`) and `rgb(` / `hsl(` in component files.
> - Inline styles: `style={{ color: '...', fontSize: '...' }}` scattered through components?
>
> Report every finding with file path and line number.

---

### AGENT 2 — Component Consistency

> You are a UI/design systems engineer. Hunt for the same UI element built multiple different ways. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Button variants: one shared Button component, or multiple different implementations?
> - Modal/dialog patterns: one Modal component used everywhere, or multiple implementations?
> - Loading indicators: same spinner/skeleton everywhere, or multiple different patterns?
> - Toast/notification patterns: one notification system, or multiple?
>
> Report every finding with file path and specific examples.

---

### AGENT 3 — Spacing, Typography & Visual Rhythm

> You are a UI/design systems engineer. Evaluate whether spacing and typography are consistent. Rate every finding High / Medium / Low.
>
> - Spacing scale: padding and margin from Tailwind scale, or arbitrary values (`p-[13px]`)?
> - Typography scale: font sizes from Tailwind type scale, or arbitrary sizes (`text-[13px]`)?
> - Z-index chaos: z-index values arbitrary numbers (`z-[999]`, `z-[9999]`)?
>
> Report every finding with file path and inconsistent values found.

---

### AGENT 4 — Redesign Readiness Audit

> You are a UI/design systems engineer. Answer: if we changed the brand color, border radius, and font — how many files would need to change?
>
> - Color change blast radius: how many files contain hardcoded color values not in `tailwind.config.ts`?
> - Dark mode readiness: color tokens support dark mode?
>
> Produce a "Redesign Cost Estimate" at the end.

---

## Compile the Report

Compile results into `UI_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# UI Consistency Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.