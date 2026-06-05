# UX & Reliability Scan

You are orchestrating a UX and reliability audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Loading & Empty States

> You are a UX auditor. Hunt for places where the app leaves users looking at nothing. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Loading states: does every data-fetching component show a loading indicator?
> - Empty states: what does a new user see when they have no data?
> - First-load experience: meaningful loading while the app initializes?
>
> Report every finding with file path and line number.

---

### AGENT 2 — Error States & User Feedback

> You are a UX auditor. Hunt for places where errors are invisible or shown as raw technical messages. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Silent failures: mutations where an error is caught but user receives no feedback?
> - Raw error messages: technical errors shown directly to users?
> - Toast consistency: success and error notifications consistent?
> - Form errors: shown inline next to relevant field?
>
> Report every finding with file path and line number.

---

### AGENT 3 — Destructive Actions & Data Safety

> You are a UX auditor. Hunt for places where users can accidentally lose data. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Delete confirmations: does every delete action show a confirmation dialog?
> - Unsaved changes: if user has unsaved changes and navigates away, are they warned?
> - Double-submission: are forms and action buttons disabled after first click?
> - Destructive button styling: are destructive actions styled in red?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Offline, Resilience & Edge Conditions

> You are a UX auditor. Hunt for places where the app breaks under non-ideal conditions. Rate every finding High / Medium / Low.
>
> Check every file in `src/`, the service worker, and PWA config:
> - Offline detection: does the app detect when the user goes offline?
> - Session expiry: when auth session expires mid-use, are users gracefully prompted to re-authenticate?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `UX_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# UX & Reliability Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.