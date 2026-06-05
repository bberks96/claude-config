# React Scan

You are orchestrating a React-specific best practices audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Error Boundaries

> You are a senior React developer. Hunt for missing React Error Boundaries. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Error Boundary existence: any defined? If none exist at all, this is a High finding.
> - Coverage: every major section rendering independently has its own boundary?
> - Route-level boundaries: placed around individual routes?
> - Fallback UI: when a boundary catches an error, what does it show?
> - Suspense boundaries: around `React.lazy()` components with meaningful fallbacks?
>
> Report every finding with file path and line number.

---

### AGENT 2 — useEffect Correctness

> You are a senior React developer. Hunt for useEffect misuse. Rate every finding High / Medium / Low.
>
> Check every file in `src/` that contains `useEffect`:
> - Missing cleanup: every useEffect setting up subscriptions/listeners/timers returns cleanup?
> - Dependency array correctness: every useEffect declares ALL values from outer scope it uses?
> - Infinite loops: effects where state setter is called unconditionally and that state is in deps?
> - Effects that compute derived state: `useEffect(() => { setState(a + b) }, [a, b])` should just be `const val = a + b`?
>
> Report every finding with file path and line number.

---

### AGENT 3 — State Management Strategy

> You are a senior React developer. Hunt for state management anti-patterns. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Server state vs client state confusion: `useState` storing data from server that should be React Query?
> - Duplicate state: same data stored in more than one place?
> - State that should be URL params: filter values, selected tabs, pagination in React state instead of URL?
> - Stale React Query data: mutations that don't invalidate relevant queries?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Form Handling

> You are a senior React developer. Hunt for inconsistent, fragile, or overly complex form handling. Rate every finding High / Medium / Low.
>
> Check every file in `src/` that contains forms or inputs:
> - Form library consistency: some forms using library and others managing state manually?
> - Manual field state: separate `useState` for every field instead of one form state object?
> - Form reset: when a modal closes and reopens, is form state properly reset?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `REACT_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# React Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.