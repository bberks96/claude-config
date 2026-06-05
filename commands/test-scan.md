# Test Scan

You are orchestrating a test coverage audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Test Infrastructure

> You are a senior developer. Audit the test infrastructure. Rate every finding High / Medium / Low.
>
> Check `package.json`, config files, and the project root:
> - Test runner: `vitest`, `jest`, `playwright`, or equivalent present? If not, one HIGH finding.
> - Test scripts: `"test"`, `"test:watch"`, or `"test:ci"` in `package.json`?
> - Test files exist: search for `*.test.ts`, `*.test.tsx`, `*.spec.ts`. If zero exist, one HIGH finding.
> - CI wiring: does any CI config run the test suite?

---

### AGENT 2 — Critical Path Coverage

> You are a senior developer. Audit test coverage of the highest-stakes code paths. Rate every finding High / Medium / Low.
>
> Money & billing paths (HIGH if untested):
> - Stripe webhook handler — signature verification tested? Idempotency tested?
> - Checkout session creation — URL allowlist tested?
>
> Auth & identity paths (HIGH if untested):
> - Auth hook — sign-in tested? Sign-up tested?
> - Protected route — unauthenticated users redirected?
> - Entitlement gating — admin-only features inaccessible to regular users?
>
> Cross-tenant safety (HIGH if untested):
> - Any test verifying User A cannot read or write User B's data?

---

### AGENT 3 — Component & Edge Function Coverage

> You are a senior developer. Audit coverage of UI interactions and backend edge functions. Rate every finding High / Medium / Low.
>
> - Pure utility functions in `src/lib/` with complex logic — tested?
> - Edge function helpers (status normalization, CORS, rate limiter math) tested?
> - Recently changed files without tests: `git log --since='30 days ago'` — files from critical paths recently changed AND no tests?
> - pgTAP / SQL function coverage: if no `supabase/tests/` directory exists, one MEDIUM finding.

---

## Compile the Report

Compile results into `TEST_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Test Coverage Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.