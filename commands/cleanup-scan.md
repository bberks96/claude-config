# Cleanup Scan

You are orchestrating a cleanup audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Dead Code

> You are a cleanup auditor. Hunt exhaustively for code that exists but is never used. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Unused imports, variables, functions, components, hooks, types?
> - Unreachable code: code after a `return` statement or inside `if (false)`?
>
> For each finding: file path, line number, what specifically is unused.

---

### AGENT 2 — Duplicate & Copy-Paste Code

> You are a cleanup auditor. Hunt for logic written more than once when it should be written once and reused. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Identical or near-identical functions across different files?
> - Repeated fetch patterns: multiple hooks fetching the same data?
> - Repeated formatting logic: date display, currency, duration written ad-hoc in multiple components?
>
> For each finding: all file paths where duplication exists.

---

### AGENT 3 — Redundant & Obsolete Code

> You are a cleanup auditor. Hunt for code that once served a purpose but no longer does. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/`:
> - Commented-out code: blocks commented out rather than deleted?
> - TODO / FIXME / HACK / XXX comments: list every one.
> - Feature flag remnants: `if (false)` or hardcoded disabled flags?
> - Debug/development artifacts: hardcoded test user IDs, `alert()` calls?
>
> For each finding: file path, line number, what specifically is obsolete.

---

## Compile the Report

Compile results into `CLEANUP_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Cleanup Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.