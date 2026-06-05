# Refactor Scan

You are orchestrating a refactoring opportunities audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Library Underutilization

> You are a senior developer doing a refactoring review. Hunt for places where code manually implements something an installed library handles better. Rate every finding High / Medium / Low.
>
> Check every file in `src/` alongside `package.json`:
> - React Query underuse: components manually managing `isLoading/error/data` state instead of `useQuery`?
> - Manual debounce/throttle: `setTimeout` for debouncing when a utility is available?
> - Date library underuse: manual date calculations instead of `date-fns` functions?
>
> For each finding: file path, line number, what the code does manually, and what library feature replaces it.

---

### AGENT 2 — Modern JavaScript & TypeScript Patterns

> You are a senior developer. Hunt for outdated code patterns with cleaner modern equivalents. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Promise chains vs async/await: `.then().catch()` chains that would be cleaner as `async/await`?
> - `var` usage: should be `const` or `let`.
> - Manual null checks vs optional chaining: `if (obj && obj.prop)` → `obj?.prop`?
> - Manual defaults vs nullish coalescing: `value !== null ? value : default` → `value ?? default`?
>
> For each finding: file path, line number, current pattern, what it should be.

---

### AGENT 3 — Complexity Reduction

> You are a senior developer. Hunt for code solving a simple problem in a complicated way. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Overcomplicated conditionals: long `if/else if` chains that could use a lookup object?
> - State that should be derived: `useState` variables always computed from other state or props?
> - Overly defensive code: null checks or try/catch for situations that genuinely cannot happen?
>
> For each finding: file path, line number, description of complexity, and simpler approach.

---

### AGENT 4 — Date, Time & Timezone Handling

> You are a senior developer. Hunt for inconsistent, fragile, or incorrect date and time handling. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/functions/`:
> - Timezone strategy: dates stored in UTC and converted to local only for display?
> - Raw Date arithmetic: manual date calculations (adding days by multiplying milliseconds)?
> - `new Date()` for "today": called in multiple places instead of a single utility?
> - String-to-date parsing: date strings parsed with `new Date(string)` directly?
>
> For each finding: file path, line number, the problem, and correct approach.

---

## Compile the Report

Compile results into `REFACTOR_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Refactoring Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.