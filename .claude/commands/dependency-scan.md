# Dependency Scan

You are orchestrating a dependency audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Security & Vulnerabilities

> You are a dependency security auditor. Hunt for vulnerable, suspicious, or dangerous packages. Rate every finding High / Medium / Low.
>
> Check `package.json` and `package-lock.json`:
> - Known vulnerabilities: flag any dependencies with known CVEs.
> - Outdated packages: flag any package more than 2 major versions behind latest.
> - Supply chain risk: typosquatting? Very low weekly downloads? No updates in 2+ years?
> - Lock file: is `package-lock.json` or `yarn.lock` committed?
>
> Report every finding with package name and current version.

---

### AGENT 2 — Bundle Size & Bloat

> You are a dependency auditor focused on bundle size. Hunt for packages making the app larger than necessary. Rate every finding High / Medium / Low.
>
> Check `package.json` and import patterns in `src/`:
> - Heavy packages: `moment` → `date-fns`, full `lodash` → individual imports?
> - Whole-library imports: entire library imported when one or two functions are used?
> - Duplicate functionality: multiple packages doing the same thing?
>
> Report every finding with package name, approximate size impact, and suggested alternative.

---

### AGENT 3 — Maintenance & Licensing

> You are a dependency auditor. Hunt for packages with maintenance risk or legal compliance issues. Rate every finding High / Medium / Low.
>
> Check `package.json`:
> - Abandoned packages: no commits in the last 18 months?
> - License compliance: GPL/AGPL may require open-sourcing your code. Unlicensed = no permission to use commercially.
> - Unnecessary dependencies: replaceable by a few lines of native code?
>
> Report every finding with package name, license, and last update date.

---

## Compile the Report

Compile results into `DEPENDENCY_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Dependencies Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.