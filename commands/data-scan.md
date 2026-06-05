# Data Scan

You are orchestrating a data integrity audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Impossible & Inconsistent Record States

> You are a senior backend engineer doing a data integrity audit. Hunt for code patterns that produce records in logically impossible or inconsistent states. Rate every finding High / Medium / Low.
>
> Check every file in `src/` that writes to the database:
> - Timestamp consistency: can a record have `completed_at` null but `completed` true?
> - Required-by-logic but not by schema: fields always required in practice but nullable in the database?
> - Status / state machine violations: does the code allow transitions to invalid states?
> - Partial writes on failure: if a mutation writes to multiple tables and the second fails, is the first rolled back?
> - Missing CHECK constraints: business rules enforced only in application code?
>
> For each finding: the exact code path, what the resulting record looks like, and what breaks when the app reads it.

---

### AGENT 2 — Calculated Value Drift

> You are a senior backend engineer doing a data integrity audit. Hunt for denormalized or cached values that can drift out of sync. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/` maintaining calculated or denormalized values:
> - Streak / count fields: can they drift if increment logic has an off-by-one, or decrement on delete is missing?
> - Progress / percentage fields: what happens if an intermediate update fails?
> - Denormalized display fields: if source is renamed or deleted, does the copy update?
> - `updated_at` not updated: code paths that modify a record's data but forget to update `updated_at`?
>
> For each finding: what causes the drift, how long it persists, what the user sees.

---

### AGENT 3 — Orphan Detection

> You are a senior backend engineer doing a data integrity audit. Hunt for code patterns that create orphaned records. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/` that deletes records or files:
> - Storage files without row cleanup?
> - Child records without cascade?
> - Parent deleted but children not cleaned up?
>
> For each finding: the delete path that creates the orphan, how many could accumulate, and what breaks.

---

### AGENT 4 — Constraint & Uniqueness Coverage

> You are a senior backend engineer doing a data integrity audit. Audit whether the database enforces uniqueness and constraints the application assumes. Rate every finding High / Medium / Low.
>
> Read migration files and compare against business rules in `src/`:
> - Missing UNIQUE constraints: fields the app treats as unique but DB doesn't enforce?
> - Missing CHECK constraints: value ranges enforced only in application code?
> - Race condition in upsert: check-then-insert pattern without DB-level UNIQUE constraint?
> - Idempotency without DB constraint: webhook handlers deduplicating in app code without UNIQUE constraint?
>
> For each finding: the business rule assumed, the code that assumes it, and the scenario where it breaks.

---

## Compile the Report

Compile results into `DATA_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Data Integrity Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.