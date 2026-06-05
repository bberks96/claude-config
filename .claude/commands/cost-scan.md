# Cost Scan

You are orchestrating a cost and data efficiency audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Database & Egress Costs

> You are a senior backend engineer focused on cost optimization. Rate every finding High / Medium / Low. Include a back-of-envelope scale estimate for Medium/High findings.
>
> Check every file in `src/` and `supabase/functions/` that runs database queries:
> - SELECT *: returns all columns including large unused ones.
> - Unbounded queries: any query without `.limit()`?
> - N+1 queries: loops containing database calls?
> - React Query without `staleTime`: refetches on every component mount.
> - `refetchOnWindowFocus: true` (the default): refetches every query when user alt-tabs back.

---

### AGENT 2 — Edge Function Costs

> You are a senior backend engineer focused on cost optimization. Rate every finding High / Medium / Low.
>
> Check every file in `supabase/functions/`:
> - External API fan-out: how many external API calls does one invocation make?
> - Cron frequency vs. work done: scanning all users every minute when every 5 minutes would do?
> - Client initialization inside the request handler (re-initialized every invocation)?

---

### AGENT 3 — Client Bundle & Rendering Costs

> You are a senior frontend engineer focused on performance cost. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `package.json`:
> - Full icon library imports: pulling entire icon library into bundle?
> - Missing React.memo on list row components?
> - Lists over 200 items without virtualization?

---

### AGENT 4 — Storage & Data Growth

> You are a senior backend engineer focused on cost optimization. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/`:
> - File uploads without size limits?
> - No cleanup on row delete: storage files deleted when their rows are deleted?
> - Soft-deleted rows never purged: tables with `deleted_at` growing forever?

---

## Compile the Report

Compile results into `COST_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Cost Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.