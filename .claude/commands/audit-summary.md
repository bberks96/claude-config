# Audit Summary

Read every `*_FINDINGS.md` file that exists at the project root, then generate `AUDIT_DASHBOARD.md` — a single, plain-English dashboard that gives a complete picture of the app's health and tells you exactly what to fix first.

This command does NOT run any new scans. It compiles whatever findings files already exist. Run your scan commands first, then run this to see everything in one place.

---

## Step 1 — Read All Findings Files

Check the project root for any of these files that exist and read them fully:

- `SECURITY_FINDINGS.md`
- `RED_TEAM_FINDINGS.md`
- `PRIVACY_FINDINGS.md`
- `ACCESSIBILITY_FINDINGS.md`
- `PERFORMANCE_FINDINGS.md`
- `DEBT_FINDINGS.md`
- `DEPENDENCY_FINDINGS.md`
- `UX_FINDINGS.md`
- `OBSERVABILITY_FINDINGS.md`
- `MOBILE_FINDINGS.md`
- `ARCHITECTURE_FINDINGS.md`
- `CLEANUP_FINDINGS.md`
- `REFACTOR_FINDINGS.md`
- `REACT_FINDINGS.md`
- `UI_FINDINGS.md`
- `BUG_FINDINGS.md`
- `COST_FINDINGS.md`
- `SCHEMA_FINDINGS.md`
- `TEST_FINDINGS.md`
- `DATA_FINDINGS.md`

For each file that doesn't exist yet, note it as "Not yet scanned."

---

## Step 2 — Generate AUDIT_DASHBOARD.md

Write `AUDIT_DASHBOARD.md` at the project root. Overwrite it completely each time.

```markdown
# App Health Dashboard
**Generated:** [today's date]
**Scans run:** [list only scans that have findings files]
**Not yet scanned:** [list scans with no findings file]

---

## Health Overview

| Category | 🔴 High | 🟡 Medium | 🟢 Low | ⏳ Pending | ✅ Fixed | Last Scanned |
|---|---|---|---|---|---|---|
| Security | X | X | X | X | X | date or Never |
| Red Team | X | X | X | X | X | date or Never |
| Privacy | X | X | X | X | X | date or Never |
| Accessibility | X | X | X | X | X | date or Never |
| Performance | X | X | X | X | X | date or Never |
| Technical Debt | X | X | X | X | X | date or Never |
| Dependencies | X | X | X | X | X | date or Never |
| UX & Reliability | X | X | X | X | X | date or Never |
| Observability | X | X | X | X | X | date or Never |
| Mobile & PWA | X | X | X | X | X | date or Never |
| Architecture | X | X | X | X | X | date or Never |
| Cleanup | X | X | X | X | X | date or Never |
| Refactoring | X | X | X | X | X | date or Never |
| React | X | X | X | X | X | date or Never |
| UI Consistency | X | X | X | X | X | date or Never |
| Bugs | X | X | X | X | X | date or Never |
| Cost & Efficiency | X | X | X | X | X | date or Never |
| Schema & Migrations | X | X | X | X | X | date or Never |
| Test Coverage | X | X | X | X | X | date or Never |
| Data Integrity | X | X | X | X | X | date or Never |
| **TOTAL** | **X** | **X** | **X** | **X** | **X** | |

---

## ⚠️ Regressions — Highest Priority

> These were fixed and came back.

[For each regression: **[ID] — [Category]** / plain English / Fix direction / File]

[If none: "No regressions detected."]

---

## 🚨 Fix First — High Severity

> Most likely to affect real users right now. Address in this order.

[ALL High severity Open findings, security first, then privacy, then UX, then everything else]

**[ID] — [Category]**
**What's happening:** [plain English]
**Real-world impact:** [what does a user actually experience?]
**File:** `[path:line]`
**How to fix it:** [one or two plain sentences]

---

## 🟡 Fix Next — Medium Severity

> Important but not urgent.

[Same format for Medium severity Open findings. Group by category.]

---

## 🟢 When You Have Time — Low Severity

> Won't hurt users today but will slow down development later.

[ID] — [Category] — [one plain English sentence] — `[file:line]`

---

## ⏳ Pending Verification

> Not detected in latest scan. May be fixed — confirm before closing.

[ID] — [Category] — [one sentence] — Last seen: [date]

---

## ✅ Recently Fixed

> Resolved in the last 30 days.

[ID] — [Category] — [one sentence] — Fixed: [date]

---

## 📚 What Each Category Means

**Security** — ways an attacker could break in, access other users' data, or bypass payment.
**Red Team** — simulates an actual attacker trying to breach the app — complete attack paths from "free account" to "I can read another user's data."
**Privacy** — how user data is collected, stored, and shared. Relevant to GDPR and CCPA.
**Accessibility** — whether the app works for people with disabilities: screen readers, keyboard-only users, visual impairments.
**Performance** — slow database queries, unnecessary React re-renders, oversized bundles.
**Technical Debt** — code that works today but will cause problems as the app grows.
**Dependencies** — vulnerable, abandoned, or non-compliant third-party packages.
**UX & Reliability** — loading states, error handling, confirmation dialogs, offline behavior.
**Observability** — whether you can see what's happening in production. Would you know if users are hitting errors right now?
**Mobile & PWA** — install experience, touch targets, responsive layout, push notifications.
**Architecture** — code organization, coupling, naming, separation of concerns.
**Cleanup** — dead code, duplicate logic, TODO comments, debug artifacts.
**Refactoring** — code that works but could be written much more simply.
**React** — Error Boundaries, useEffect correctness, state management, form handling.
**UI Consistency** — design tokens, component consistency, redesign readiness.
**Bugs** — stale closures, race conditions, null crashes, date bugs, type mismatches.
**Cost & Efficiency** — database egress, Stripe API waste, bundle size, storage growth.
**Schema & Migrations** — RLS, FK indexes, soft-delete indexes, type drift.
**Test Coverage** — billing/auth/mutation coverage, cross-tenant safety, critical path tests.
**Data Integrity** — impossible record states, calculated value drift, orphaned records, missing DB constraints.

---

## 🎯 Suggested Fix Order

1. Fix all Regressions first
2. Fix all High Security and Privacy issues
3. Fix all High UX issues
4. Fix remaining High issues by category
5. Work through Medium issues
6. Confirm all Pending Verification items
7. Address Low issues during normal development
```

---

After generating the file, report back:
- Total findings across all scans (by severity)
- How many scans have been run vs not yet run
- The top 3 most urgent items to address