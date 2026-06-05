# Observability Scan

You are orchestrating an observability audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Error Monitoring & Alerting

> You are an observability auditor. Hunt for gaps in error visibility. Rate every finding High / Medium / Low.
>
> Check every file in `src/`, `supabase/functions/`, and config files:
> - Error monitoring setup: a service (Sentry, Datadog, etc.) configured and capturing unhandled exceptions?
> - Silent catch blocks: try/catch blocks that catch an error and continue as if nothing happened?
> - Critical path coverage: errors on Stripe webhook processing, edge function crashes, auth failures guaranteed to surface somewhere?

---

### AGENT 2 — Logging Quality & Usefulness

> You are an observability auditor. Evaluate whether logging would help diagnose production issues. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/functions/`:
> - Structured logging: logs structured (JSON with timestamp, level, request_id, operation) or unstructured strings?
> - Request correlation: request ID generated and threaded through all log lines?
> - PII in logs: names, emails, or sensitive data appearing in logs?

---

### AGENT 3 — Health, Metrics & Debugging Tooling

> You are an observability auditor. Check operational visibility. Rate every finding High / Medium / Low.
>
> - Health checks: is there a health check endpoint?
> - Dead letter queues: are failed integration events surfaced to anyone, or accumulating silently?
> - Cron job monitoring: are scheduled jobs monitored? If a cron stops firing, would anyone know?

---

## Compile the Report

Compile results into `OBSERVABILITY_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Observability Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.