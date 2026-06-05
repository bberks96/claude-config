# Full Audit

Run all 20 scan skills in sequence — one at a time, waiting for each to fully complete and write its findings file before starting the next. Do NOT run them in parallel. Each scan spawns its own parallel agents internally; the sequencing here is at the scan level. After all scans complete, run `/audit-summary` to compile everything into `AUDIT_DASHBOARD.md`.

Every scan writes its results to a findings file immediately. If this session times out or is interrupted, all completed scans' findings are already saved — just resume from where you left off.

---

## Run Order

Work through this list top to bottom. Check off each one as it completes.

### Tier 1 — Safety & Correctness (run first, highest stakes)
1. `/security-scan` → `SECURITY_FINDINGS.md`
2. `/red-team-scan` → `RED_TEAM_FINDINGS.md`
3. `/bug-scan` → `BUG_FINDINGS.md`
4. `/data-scan` → `DATA_FINDINGS.md`
5. `/schema-scan` → `SCHEMA_FINDINGS.md`

### Tier 2 — User Impact (what users actually feel)
6. `/ux-scan` → `UX_FINDINGS.md`
7. `/react-scan` → `REACT_FINDINGS.md`
8. `/accessibility-scan` → `ACCESSIBILITY_FINDINGS.md`
9. `/privacy-scan` → `PRIVACY_FINDINGS.md`

### Tier 3 — Scale & Cost (fine today, expensive at 10k users)
10. `/cost-scan` → `COST_FINDINGS.md`
11. `/performance-scan` → `PERFORMANCE_FINDINGS.md`
12. `/dependency-scan` → `DEPENDENCY_FINDINGS.md`

### Tier 4 — Code Quality (developer experience & maintainability)
13. `/test-scan` → `TEST_FINDINGS.md`
14. `/architecture-scan` → `ARCHITECTURE_FINDINGS.md`
15. `/debt-scan` → `DEBT_FINDINGS.md`
16. `/refactor-scan` → `REFACTOR_FINDINGS.md`
17. `/cleanup-scan` → `CLEANUP_FINDINGS.md`

### Tier 5 — Polish (good to have, not urgent)
18. `/ui-scan` → `UI_FINDINGS.md`
19. `/mobile-scan` → `MOBILE_FINDINGS.md`
20. `/observability-scan` → `OBSERVABILITY_FINDINGS.md`

---

## After All Scans Complete

Run `/audit-summary` to compile every findings file into `AUDIT_DASHBOARD.md` — a single plain-English dashboard showing all open findings by severity, regressions, and suggested fix order.

---

## If Interrupted

Check which findings files already exist at the project root. Any file that exists means that scan completed. Skip those and resume from the first scan in the list that has no findings file yet.