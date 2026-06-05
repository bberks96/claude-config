# Schema Scan

You are orchestrating a database schema and migration hygiene audit. Spawn all agents simultaneously and wait for all results before compiling. If the project doesn't use Supabase migrations, report that and stop.

---

## Spawn Parallel Agents

### AGENT 1 — Migration Checklist

> You are a database engineer. Audit every migration file in `supabase/migrations/` against a strict checklist. Rate every finding High / Medium / Low.
>
> For every `CREATE TABLE`: RLS enabled? At least one policy per operation? `user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE`? `id uuid PRIMARY KEY DEFAULT gen_random_uuid()`? `created_at` and `updated_at` columns?
>
> For every `ALTER TABLE ... ADD COLUMN`: nullable OR has a DEFAULT safe for existing rows?
>
> For every `CREATE VIEW`: specifies `WITH (security_invoker=true)` unless explicitly service-role-only?
>
> For every `CREATE FUNCTION ... SECURITY DEFINER`: contains a hard `WHERE user_id = auth.uid()` check? `EXECUTE` revoked from `PUBLIC`?
>
> Report every checklist failure with migration filename, line number, and which item failed.

---

### AGENT 2 — Structural Patterns

> You are a database engineer. Audit the cumulative schema patterns. Rate every finding High / Medium / Low.
>
> - Soft-delete indexes: every table with `user_id` and `deleted_at` has a composite or partial index?
> - Foreign key indexes: every `REFERENCES other_table(id)` column has an index?
> - ON DELETE behavior: every foreign key specifies `CASCADE`, `RESTRICT`, or `SET NULL`?
> - Triggers for updated_at: every table with `updated_at` has a trigger?
> - RLS on all user-facing tables?
>
> Report every structural gap with the affected table and concrete risk.

---

### AGENT 3 — Type Drift & Documentation

> You are a database engineer. Audit whether schema, TypeScript types, and documentation are in sync. Rate every finding High / Medium / Low.
>
> Check `src/integrations/supabase/types.ts`, `supabase/migrations/`, and `CLAUDE.md`:
> - Types vs schema drift: every table in migrations present in `types.ts`?
> - Types vs documentation drift: columns in docs actually in `types.ts`?
> - Legacy columns: columns described as "legacy" or "no longer used"?
> - SECURITY DEFINER functions not documented?
>
> Report every drift finding with specific table/column names and which files disagree.

---

## Compile the Report

Compile results into `SCHEMA_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Schema Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.