# Performance Scan

You are orchestrating a performance audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — Database & Query Performance

> You are a performance auditor. Hunt for slow, wasteful, or unbounded database queries. Rate every finding High / Medium / Low.
>
> Check all files in `src/` that make database queries:
> - N+1 queries: loops that make a database call on each iteration?
> - Unbounded queries: queries with no `.limit()`?
> - Over-fetching: queries using `.select('*')` when only 2-3 columns are needed?
> - Missing indexes: foreign key columns have indexes? Columns used in `.eq()` or `.order()` have indexes?
> - Waterfall requests: Request B starting after A when they could run in parallel?
>
> Report every finding with file path and line number.

---

### AGENT 2 — React Rendering Performance

> You are a performance auditor. Hunt for unnecessary React re-renders. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Missing `React.memo`: expensive components missing memoization?
> - Missing `useCallback`: functions passed as props without `useCallback`?
> - Missing `useMemo`: expensive calculations inside render without `useMemo`?
> - State placement: state defined too high causing large subtrees to re-render?
> - Inline object/array props: `style={{ color: 'red' }}` defeating memo?
>
> Report every finding with file path and line number.

---

### AGENT 3 — Bundle Size & Assets

> You are a performance auditor. Hunt for bundle bloat and unoptimized assets. Rate every finding High / Medium / Low.
>
> Check `package.json`, `vite.config.ts`, `index.html`, and `src/`:
> - Heavy dependencies with lighter alternatives?
> - Full library imports when one function is needed?
> - Lazy loading: all route-level components lazy loaded with `React.lazy()`?
> - Images: unoptimized in `public/`? No WebP format?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Caching & Network

> You are a performance auditor. Hunt for missing caching and redundant network requests. Rate every finding High / Medium / Low.
>
> Check every file in `src/` that uses React Query, fetch, or Supabase:
> - React Query stale times: `staleTime` values set appropriately?
> - Polling: any `setInterval` or `refetchInterval` when real-time subscriptions would be more efficient?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `PERFORMANCE_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Performance Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.