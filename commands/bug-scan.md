# Bug Scan

You are orchestrating a correctness bug audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Hooks & Effects Bugs

> You are a senior React developer doing a bug hunt. Hunt for runtime bugs caused by incorrect React hook usage. Rate every finding High / Medium / Low.
>
> Check every file in `src/` that uses `useEffect`, `useCallback`, `useMemo`, `useRef`, or custom hooks:
> - Stale closure bugs: `useEffect`/`useCallback`/`useMemo` referencing a prop or state variable NOT in its dep array?
> - Missing cleanup: `useEffect` setting up timers, listeners, or realtime channels without cleanup?
> - Infinite render loops: effect unconditionally calling a state setter where that state is in the dep array?
> - Object/array literal deps: `useEffect` or `useCallback` given an object/array literal as a dep?
>
> For each finding: trigger, observable effect, confidence level, file path and line.

---

### AGENT 2 — State & Async Bugs

> You are a senior React developer doing a bug hunt. Hunt for runtime bugs in async code and state management. Rate every finding High / Medium / Low.
>
> Check every file in `src/` performing async operations:
> - Unhandled Promise rejections: `.then()` without `.catch()`? Fire-and-forget failing silently?
> - Optimistic update without rollback: UI updated before server confirms?
> - Race conditions: two async operations landing out of order?
> - `JSON.parse` without try/catch?
> - Null/undefined crashes: `.` access on maybe-null values?
> - Double-submission: form submit or button action can fire twice?
>
> For each finding: trigger, observable effect, confidence level, file path and line.

---

### AGENT 3 — UI & Interaction Bugs

> You are a senior React developer doing a bug hunt. Hunt for runtime bugs in the UI layer. Rate every finding High / Medium / Low.
>
> Check every file in `src/` managing drag-and-drop, forms, modals, or list rendering:
> - List key bugs: `key={index}` instead of stable unique ID?
> - Form state not reset on close?
> - Drag-and-drop state leak: global `document.addEventListener` without cleanup?
> - Missing loading/empty/error states: `data.map(...)` where `data` is undefined?
>
> For each finding: trigger, observable effect, confidence level, file path and line.

---

### AGENT 4 — Data & Type Bugs

> You are a senior React developer doing a bug hunt. Hunt for bugs caused by incorrect data handling. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - `new Date(string)` on date-only strings (midnight UTC off-by-one)?
> - `.setHours()` mutations?
> - Date equality with `===`?
> - `parseInt` / `parseFloat` on undefined returning NaN?
> - Type lies via `as any` or JSONB fields accessed without type guards?
>
> For each finding: trigger, observable effect, confidence level, file path and line.

---

## Compile the Report

Compile results into `BUG_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Bug Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.