# Red Team Scan

You are orchestrating an adversarial red team audit. This is NOT a checklist scan — it is a simulated attack. The goal is to find **complete attack paths**: sequences of steps a real attacker would take to crash the app, steal another user's data, or bypass payment. Spawn all agents simultaneously and wait for all results before compiling.

Every finding must be written as an **attack narrative**:
> "Starting as [attacker role], I [specific action with exact payload/method], which [intermediate effect], which allows me to [final damage]."

Attacker roles: Unauthenticated, Free user, Pro user.

---

## Spawn Parallel Agents

### AGENT 1 — Cross-Tenant Data Breach

> You are a world-class attacker with a free account. Goal: read or modify another user's private data. Rate every finding High / Medium / Low.
>
> Read every file in `src/hooks/`, `src/components/`, and `supabase/functions/` making database queries or calling edge functions:
> - Do any edge functions accept a `user_id` in the request body without verifying it matches the caller's JWT?
> - Do any Supabase queries fetch rows by an ID from props/URL params without `.eq('user_id', authUser.id)`?
> - Are there RPC functions that accept a user_id argument without ownership verification?
> - Can shared/public feature query paths return more data than intended?
>
> For each finding: exact starting point, exact action, what data comes back, blast radius.

---

### AGENT 2 — Subscription & Entitlement Bypass

> You are a world-class attacker. Goal: Pro features for free, permanently. Rate every finding High / Medium / Low.
>
> Read webhook handler, checkout session creation, subscription details, and entitlement checks:
> - Can I replay an old `checkout.session.completed` event?
> - Can I grant myself entitlements via the manage-entitlement function?
> - Is there a client-side subscription status cache that doesn't refresh?
>
> For each finding: exact steps, what I gain, ongoing cost to the business.

---

### AGENT 3 — App Crash & Availability Destruction

> You are a world-class attacker. Goal: crash the app or make it unusably slow. Rate every finding High / Medium / Low.
>
> Read every file in `src/hooks/`, `supabase/functions/`, and `supabase/migrations/`:
> - What happens with malformed/extreme inputs (interval: 0, max_occurrences: 2147483647)?
> - Can I create circular references in self-referential tables?
> - Can I overflow storage or trigger expensive operations at scale?
> - Can I flood a webhook queue?
>
> For each finding: exact input, what breaks, how long it stays broken, whether it affects one account or all users.

---

### AGENT 4 — Data Exfiltration & Enumeration

> You are a world-class attacker starting unauthenticated. Goal: map the user base and extract data. Rate every finding High / Medium / Low.
>
> Read auth pages, edge functions, and error handling:
> - Can I enumerate whether a specific email address has an account?
> - Can I access another user's uploaded files by guessing URLs?
> - Do any catch blocks return raw Postgres errors, Stripe messages, or stack traces?
>
> For each finding: how much data I can extract per hour, what I learn about real users.

---

## Compile the Report

Compile results into `RED_TEAM_FINDINGS.md` at the project root. Diff against existing file.

### Findings format
```
### [ID] — [Severity]
**Attack:** [Narrative]
**Payload / Steps:** [Specific enough to reproduce]
**Blast radius:** [How many users affected? Reversible?]
**File:** `path/to/file.ts:[line]`
**Direction:** [One-line fix]
**Status:** Open | First found: [today's date]
```

### File format
```
# Red Team Findings
**Last scan:** [date]
**Agents run:** Cross-Tenant Breach, Subscription Bypass, Crash & Availability, Exfiltration & Enumeration

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update the `Red Team` section of `AUDIT_DASHBOARD.md`.