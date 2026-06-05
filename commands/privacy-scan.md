# Privacy Scan

You are orchestrating a privacy audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Logging & Data Leakage

> You are a privacy auditor. Hunt for places where personal data is logged or leaked. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and `supabase/functions/`:
> - `console.log/error/warn`: is any personal data being logged?
> - Error tracking services: are full user objects or PII being sent?
> - URLs containing personal data?
> - API error responses returning user data the caller didn't need?
>
> Report every finding with file path and line number.

---

### AGENT 2 — Client-Side Data Storage

> You are a privacy auditor. Hunt for personal data stored client-side inappropriately. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - `localStorage`: what keys are set? Is any PII stored there?
> - `sessionStorage`: what is stored and is any of it personal data?
> - Cookies: are auth cookies marked `HttpOnly` and `Secure`?
>
> Report every finding with file path and line number.

---

### AGENT 3 — Database & Data Retention

> You are a privacy auditor. Hunt for data retention and minimization issues. Rate every finding High / Medium / Low.
>
> Check `supabase/migrations/` and `src/`:
> - Data minimization: columns collecting data that features don't clearly need?
> - Retention: any mechanism to delete or anonymize old user data?
> - Soft deletes: rows with `deleted_at` are not truly deleted — is there a hard-delete path?
> - Account deletion: when a user deletes their account, is ALL their data deleted?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Third-Party Data Sharing

> You are a privacy auditor. Hunt for data shared with third parties beyond what users expect. Rate every finding High / Medium / Low.
>
> Check `index.html`, `src/`, `package.json`:
> - Third-party scripts: what domains are contacted on page load? Do users consent?
> - Analytics packages: what user data is sent? Is it anonymized?
> - Pixels, beacons, or tracking scripts that fire without explicit user consent?
>
> Report every finding with file path and line number.

---

### AGENT 5 — Consent & User Rights

> You are a privacy auditor. Hunt for gaps in user consent and rights implementation. Rate every finding High / Medium / Low.
>
> Check `src/`, legal pages, and the signup flow:
> - Cookie consent: are non-essential cookies set before user consents?
> - Privacy policy: does one exist? Is it linked from signup, settings, footer?
> - Data export: can users download all their data? (GDPR Article 20)
> - Account deletion: is there a clear, self-serve way to delete account and all data?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `PRIVACY_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Privacy Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.