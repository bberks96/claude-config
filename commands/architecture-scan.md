# Architecture Scan

You are orchestrating a commercial-grade architecture audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Folder Structure & File Organization

> You are a senior software architect. Evaluate whether this codebase is organized to impress a new developer. Rate every finding High / Medium / Low.
>
> Check the entire directory structure of `src/`:
> - Folder structure: clear and conventional? (`components/`, `pages/`, `hooks/`, `lib/`, `types/`)
> - Feature co-location: files for the same feature grouped together?
> - File size: flag any files over 400 lines.
>
> Report every finding with file path.

---

### AGENT 2 — Dependency Architecture & Coupling

> You are a senior software architect. Evaluate whether dependencies between modules are clean. Rate every finding High / Medium / Low.
>
> Check import patterns across all files in `src/`:
> - Circular dependencies: files that import from each other?
> - Dependency direction: pages → components → hooks → utils → types?
> - God files: files imported by more than 10-15 other files?
> - Third-party coupling: any library imported directly across many components instead of wrapped?
>
> Report every finding with file paths showing the problematic dependency.

---

### AGENT 3 — Naming, Conventions & Consistency

> You are a senior software architect. Evaluate whether naming and conventions are consistent. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Component naming: all React components in PascalCase?
> - Hook naming: all custom hooks start with `use`?
> - Consistency: similar concepts named consistently?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Separation of Concerns & Component Design

> You are a senior software architect. Evaluate whether components have clear single responsibilities. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Presentation vs logic: UI components separated from business logic?
> - Hook responsibilities: does each custom hook do one thing?
> - Component props: components taking more than 8-10 props?
>
> Report every finding with file path and line number.

---

### AGENT 5 — Onboarding Readiness & Documentation

> You are a senior software architect. Evaluate whether a new developer could become productive quickly. Rate every finding High / Medium / Low.
>
> Check `CLAUDE.md`, `README.md`, `docs/`, `package.json` scripts:
> - Architecture documentation: document explaining what the app does and how the codebase is structured?
> - Setup instructions: steps to run locally documented and up to date?
> - Env var documentation: `.env.example` listing all required variables?
>
> Report every finding with file path.

---

## Compile the Report

Compile results into `ARCHITECTURE_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Architecture Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.