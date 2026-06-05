# Debt Scan

You are orchestrating a technical debt audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Code Quality & Complexity

> You are a code quality auditor. Hunt for unnecessarily complex or likely-to-cause-bugs code. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - God components: files over 500 lines doing too many unrelated things?
> - Deep nesting: functions or JSX nested more than 4-5 levels deep?
> - Magic numbers/strings: hardcoded values without named constants?
> - Duplicated logic: same filtering, sorting, formatting repeated in multiple places?
> - Dead code: functions, variables, components, or imports defined but never used?
>
> Report every finding with file path and line number.

---

### AGENT 2 — TypeScript & Type Safety

> You are a code quality auditor. Hunt for TypeScript weaknesses that hide bugs. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - `any` type: every use is a hole in type safety.
> - Type assertions (`as X`): casts that could hide type errors?
> - Non-null assertions (`!`): on values that could genuinely be null?
> - `// @ts-ignore` / `// @ts-nocheck`: suppressing errors rather than fixing?
>
> Report every finding with file path and line number.

---

### AGENT 3 — Patterns & Architecture

> You are a code quality auditor. Hunt for architectural inconsistencies and anti-patterns. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Inconsistent patterns: similar problems solved differently in different parts?
> - Prop drilling: data passed through more than 3 levels without being used?
> - Side effects in render: API calls or localStorage reads directly in component render?
> - TODO / FIXME / HACK comments: list every one with file and line.
>
> Report every finding with file path and line number.

---

### AGENT 4 — Test Coverage Gaps

> You are a code quality auditor. Hunt for critical code paths with no test coverage. Rate every finding High / Medium / Low.
>
> - Find all test files. List them.
> - Critical paths with no tests: billing flows, auth flows, data mutation hooks, edge functions?
> - Edge function shared helpers tested?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `DEBT_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Technical Debt Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.