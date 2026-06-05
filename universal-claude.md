# Universal Coding Standards

These rules apply to every project in every session. They are synthesized from 20 parallel audit scans — follow these proactively and scans rarely find new issues in freshly written code.

---

## Audit Skills

23 commands available as slash commands in every project. Each scan writes to its own findings file at the project root.

- `/security-scan` → `SECURITY_FINDINGS.md`
- `/red-team-scan` → `RED_TEAM_FINDINGS.md`
- `/privacy-scan` → `PRIVACY_FINDINGS.md`
- `/accessibility-scan` → `ACCESSIBILITY_FINDINGS.md`
- `/performance-scan` → `PERFORMANCE_FINDINGS.md`
- `/debt-scan` → `DEBT_FINDINGS.md`
- `/dependency-scan` → `DEPENDENCY_FINDINGS.md`
- `/ux-scan` → `UX_FINDINGS.md`
- `/observability-scan` → `OBSERVABILITY_FINDINGS.md`
- `/mobile-scan` → `MOBILE_FINDINGS.md`
- `/architecture-scan` → `ARCHITECTURE_FINDINGS.md`
- `/cleanup-scan` → `CLEANUP_FINDINGS.md`
- `/refactor-scan` → `REFACTOR_FINDINGS.md`
- `/react-scan` → `REACT_FINDINGS.md`
- `/ui-scan` → `UI_FINDINGS.md`
- `/bug-scan` → `BUG_FINDINGS.md`
- `/cost-scan` → `COST_FINDINGS.md`
- `/schema-scan` → `SCHEMA_FINDINGS.md`
- `/test-scan` → `TEST_FINDINGS.md`
- `/data-scan` → `DATA_FINDINGS.md`
- `/audit-summary` → compiles all findings into `AUDIT_DASHBOARD.md`
- `/full-audit` → runs all 20 scans in priority order, then compiles
- `/update-project-md` → updates `CLAUDE.md` from codebase + findings files

**Track every fix:** Whenever you fix a finding from any findings file, update that file immediately — move the item to the Fixed section with today's date and a short description of the fix. Update summary counts. Never leave a fixed item listed as open.

**When to run which scan:**

| After this type of change | Run these scans |
|---|---|
| New DB table or migration | `/schema-scan` `/data-scan` `/security-scan` |
| Billing / auth / payments code | `/security-scan` `/test-scan` `/bug-scan` |
| New page or user-facing feature | `/ux-scan` `/react-scan` `/accessibility-scan` |
| New npm package | `/dependency-scan` `/cost-scan` |
| Deleted or refactored code | `/cleanup-scan` `/bug-scan` |
| Changed a data hook or query | `/cost-scan` `/data-scan` `/bug-scan` |
| Third-party integration change | `/security-scan` `/data-scan` `/cost-scan` |
| Full monthly health check | `/full-audit` |
| After any significant change | `/update-project-md` |

---

## Architecture & Structure

- **One responsibility per file** — if a file handles data fetching AND renders UI AND manages drag state, split it; each file should do one thing
- **Never exceed ~400 lines per file** — files longer than this are a signal to extract; large files accumulate bugs and become hard to reason about
- **Dependencies flow one way** — pages → components → hooks → utils → types; circular imports cause unpredictable load order bugs
- **Wrap third-party libraries at a single point** — Supabase, Stripe, analytics: one file imports and re-exports the client so the rest of the app never imports the library directly; swapping it later becomes a one-file change
- **Co-locate feature files** — keep files for the same feature together; scattering by file type (all hooks in `/hooks/`, all components in `/components/`) makes features hard to find and delete
- **Consistent naming throughout** — PascalCase for components, `use` prefix for hooks, SCREAMING_SNAKE for constants; inconsistency means new developers guess wrong
- **Document the architecture in CLAUDE.md** — record what the app does, how it's organized, key concepts, and required env vars; the next session (or developer) can't read your mind

---

## Code Quality & Cleanup

- **Never leave dead code** — unused imports, variables, functions, and components accumulate silently; delete them, version control holds the history
- **Never leave commented-out code** — a comment block of old code is worse than deletion; it confuses readers about what's actually running
- **Fix or delete every TODO/FIXME** — they mark incomplete work; list every one and either implement it or remove the comment
- **Never copy-paste logic** — if the same pattern appears twice, extract it; duplicate logic means bugs get fixed in one place and silently stay in the other
- **Remove debug artifacts** — no hardcoded test user IDs, `alert()` calls, `console.log` left in production paths, or `if (false)` feature flags

---

## Database Queries

- **Never `SELECT *`** — always name only the columns the component actually uses; each extra column is wasted egress billed per GB
- **Always `.limit()`** — every query on a growing table needs a row cap; unbounded fetches get slower as data grows
- **Always filter `user_id`** — every query on user-owned data must include `.eq('user_id', user.id)` or rely on a confirmed RLS policy server-side
- **Always `.is('deleted_at', null)`** on any table with soft deletes
- **Always `staleTime`** on every `useQuery` — default is 0 (refetch on every mount); pick a value that reflects how often the data actually changes
- **Always `refetchOnWindowFocus: false`** unless the data genuinely needs to refresh when the user alt-tabs back
- **Never N+1** — no database calls inside loops; batch with `Promise.all()` or fetch with a join

---

## React Effects & Hooks

- **Always clean up** — every `useEffect` that creates a timer, listener, interval, WebSocket, or realtime channel must return a cleanup function that cancels/removes it
- **Never omit deps** — every variable used inside `useEffect` / `useCallback` / `useMemo` must be in the dependency array; no exceptions without a written comment explaining the deliberate omission
- **Never inline objects/arrays as deps** — `useEffect(() => {}, [{ id }])` creates a new object reference every render, causing the effect to re-run every render; extract to a stable primitive
- **Never use `useEffect` to derive state** — `useEffect(() => { setFull(a + b) }, [a, b])` should be `const full = a + b`; derived state that can be computed synchronously should just be a variable
- **Keep state as low in the tree as possible** — lift state only when multiple siblings need it; unnecessary lifting causes unnecessary re-renders
- **Never store server state in `useState`** — use React Query for anything that comes from the database; copying server state into `useState` creates drift when the cache updates

---

## Async Code

- **Always `try/catch`** around every `await` that could fail
- **Always `JSON.parse` inside `try/catch`** — it throws a SyntaxError on malformed input, which crashes the component
- **Never fire-and-forget** — `void fn()` without a `.catch()` silently swallows failures; add error handling
- **Never have a silent catch block** — if you catch an error, either show a toast, log it, or re-throw; catching and doing nothing hides failures permanently
- **Always guard state after `await`** — before calling `setState` after an async operation, confirm the component is still mounted or use React Query instead of manual state
- **Always prevent double-submit** — disable the trigger or set a loading flag before the first call returns; never let the same action fire twice concurrently

---

## Components

- **Always `React.memo`** on any component rendered inside a list of 10+ items
- **Always `useCallback` / `useMemo`** on any prop passed to a `React.memo` child — otherwise the memo is defeated because the prop reference changes every render
- **Never inline object/array literals as props** — `<C style={{ color: 'red' }} />` creates a new reference every render and breaks `React.memo`; define above or use `useMemo`
- **Always handle three states** — loading, empty, and error — before assuming data exists; `data.map(...)` where `data` is undefined crashes with "Cannot read properties of undefined"
- **Always stable `key` props** — never `key={index}`; use the item's unique database ID; index keys cause stale UI when items are reordered or removed
- **Always reset form state on modal/dialog close** — a form that reopens must show fresh defaults, not values from the previous session
- **Always wrap independent page sections in Error Boundaries** — a crash in one section should not white-screen the whole app

---

## TypeScript

- **Never `as any`** — if a cast is genuinely necessary, use `as unknown as TargetType` and add a one-line comment explaining why the types don't align
- **Never `// @ts-ignore`** — fix the underlying type issue; ignoring it masks real bugs
- **Never `as X` for lazy typing** — type assertions hide mismatches; use proper type definitions
- **Always type JSONB / `metadata` fields explicitly** — never access `row.metadata.someField` without a typed interface or runtime type guard; Supabase's generated type for JSONB is effectively `unknown` at runtime
- **Never `!` non-null assertions on values that could actually be null** — use `?.` optional chaining and provide a fallback; if you are certain it can't be null, add a comment explaining why
- **Always use `unknown` in catch blocks** — `catch (e: any)` loses type information; `catch (e: unknown)` forces you to check before using
- **Always add return types to exported functions** — implicit return types let callers miss type boundaries silently

---

## Dates & Times

- **Never `new Date(dateString)` on date-only strings** — `new Date('2026-04-15')` parses as midnight UTC, which is the previous day in US/Western timezones; use a date library (`date-fns`, `dayjs`)
- **Never `.setHours()` mutations** — mutates the Date object in-place; any other reference to the same object sees the change; use a library that returns new instances
- **Never `date1 === date2`** — compares object references, always false; compare `.getTime()` values or use a library's `isSameDay()`
- **Store UTC, display local** — timezone conversion happens only at the display layer; never store local time

---

## Security

- **Validate at the boundary** — trust no client input; validate types, lengths, ranges, and allowed values at the edge function / API handler, not just in the UI
- **Never trust client-side security decisions** — `user.role === 'admin'` from JavaScript can be spoofed; verify on the server via JWT claims
- **Always verify resource ownership** — when accessing `/api/notes/123`, verify the authenticated user owns that record; missing this is an IDOR (Insecure Direct Object Reference) vulnerability that leaks other users' data
- **Never return raw errors to the client** — catch server-side errors, log the real error with a correlation ID, return a sanitized message; stack traces and SQL errors must never reach the HTTP response
- **Never build queries with string concatenation** — always use parameterized queries or ORM methods; string interpolation enables SQL injection
- **Never use `Math.random()` for tokens or nonces** — it is not cryptographically secure; use `crypto.getRandomValues()`
- **Always validate file uploads** — file extension allowlist + MIME type check + max size limit before calling any storage upload function
- **Never commit secrets** — no API keys, service-role keys, or tokens in code, `.env` files tracked by git, or `localStorage`
- **Always verify Stripe webhook signatures** — and claim the event as processed before any action to prevent replay attacks

---

## Privacy & Data Protection

- **Never log personal data** — no names, emails, user IDs, or sensitive fields in `console.log` or error tracking; scrub before logging
- **Never store sensitive data in localStorage** — localStorage is readable by any script on the page; auth tokens belong in HttpOnly cookies or Supabase's session management
- **Never send more data than needed to third parties** — validate what each analytics or integration API actually receives; APIs should never get the full user object
- **Always provide account deletion** — when users delete accounts, hard-delete ALL their data (not soft-delete); GDPR Article 17 requires it
- **Never collect data you don't use** — if a feature is removed, delete the data it collected; unused columns and tables are liability
- **Always get consent before tracking** — don't fire analytics pixels or set cookies until the user explicitly consents

---

## Accessibility

- **Every image must have meaningful alt text** — `alt=""` only for decorative images; descriptive text is required for screen reader users
- **All interactive elements must be keyboard accessible** — no click-only interactions; use `<button>`, manage `tabIndex`, and test tab navigation
- **Never use color as the only way to convey information** — add icons, text labels, or patterns alongside color for colorblind users
- **All form inputs must have associated labels** — `<label>` or `aria-label` required; placeholder text is not a label and disappears on focus
- **Never hide focus indicators** — `outline: none` without a replacement blocks keyboard users; always provide a visible focus style
- **Ensure 4.5:1 contrast ratio minimum** — text must be visible for low-vision users; check with a contrast checker
- **Icon-only buttons need `aria-label`** — a button with only an icon must have `aria-label` so screen reader users understand its purpose

---

## Performance & Rendering

- **Never import entire libraries for one function** — `import { format } from 'date-fns'` not the whole library; tree-shaking doesn't catch everything
- **Don't refetch data you already have** — set React Query `staleTime` to match how often data actually changes; default 0 refetches on every mount
- **Lazy load all route components** — wrap with `React.lazy()` and `<Suspense>` to keep the main bundle small and first load fast
- **Virtualize lists over 200 items** — rendering 500+ DOM nodes causes slow paint; use `tanstack-virtual` or `react-window`
- **Never put expensive computation inside render** — sorting or filtering large arrays directly in render re-runs on every keystroke; wrap in `useMemo` with correct deps
- **Always use indexes on foreign keys and filter columns** — unindexed queries on growing tables degrade from milliseconds to seconds silently

---

## Mobile & PWA

- **Touch targets must be at least 44×44px** — smaller targets cause mis-taps; this applies to all buttons, icons, and interactive elements
- **Always add viewport meta tag** — `<meta name="viewport" content="width=device-width, initial-scale=1">` is required for responsive mobile layout
- **Never allow horizontal scroll on mobile** — fixed-width or absolutely-positioned elements that overflow cause a broken experience
- **Web App Manifest must have all required fields** — `name`, `short_name`, `start_url`, `display`, and icons at 192px+ for Android and 180px for iOS
- **Service worker must have a meaningful offline fallback** — not just the browser's default error page; show a helpful message
- **Responsive breakpoints must be consistent** — use the same breakpoint system (e.g., Tailwind's `sm`/`md`/`lg`) across all components; mixed systems produce gaps

---

## Observability & Monitoring

- **Never have a silent catch block** — if you catch an error, log it, show it to the user, or re-throw; silent catches make production bugs invisible
- **Every request should have a correlation ID** — thread a `request_id` through all log lines for a single operation so you can trace cross-service failures
- **Structured logging required** — logs should be JSON with `timestamp`, `level`, `request_id`, and `operation`; unstructured strings are unsearchable
- **Critical paths must surface errors** — Stripe webhooks, auth failures, integration syncs, and cron jobs must log failures somewhere visible; silent failure in a cron is worse than no cron
- **Cron jobs must be monitored** — a scheduled function that stops running silently is indistinguishable from one that was never set up; add a heartbeat or alert

---

## UX & Reliability

- **Every async operation needs a loading state** — never leave the user staring at a blank area; show a spinner, skeleton, or disabled button
- **Error messages must be human-readable** — raw technical errors ("Error: 422 Unprocessable Entity") confuse users; translate to plain English with a recovery path
- **Destructive actions need confirmation dialogs** — users press Delete by accident; require explicit confirmation before irreversible operations
- **Form state must reset on modal close** — reopening a modal must show a blank form, not stale values from the last open
- **Session expiry must re-authenticate gracefully** — if an auth token expires mid-use, prompt the user to log back in; don't just silently fail the next request
- **Warn before navigating away from unsaved changes** — if a user edits something and tries to navigate away, confirm intent before discarding their work

---

## UI Consistency

- **All colors must be design tokens** — never hardcode hex values in components; changing brand color should be a one-file change in `tailwind.config.ts`
- **One Button component, reused everywhere** — multiple Button implementations produce visual inconsistency; use one with variant props
- **All spacing must use the design system scale** — no `p-[13px]` or arbitrary values; stick to the defined Tailwind scale
- **One Modal/Dialog implementation, reused everywhere** — multiple modal patterns confuse users and create inconsistent close/escape behavior
- **Z-index managed systematically** — no magic numbers like `z-[9999]`; define named layers (modal, dropdown, tooltip) in the theme config

---

## Dependencies

- **Always check for security CVEs** — `npm audit` must be clean before shipping; flag any dependency with known vulnerabilities
- **Flag abandoned packages** — any package with zero updates in 18+ months is a risk; find an alternative or fork
- **Never install two libraries that do the same thing** — `moment` and `date-fns` in the same project; `lodash` and `ramda`; pick one and remove the other
- **License compliance required** — GPL/AGPL licenses require open-sourcing your app; flag any unlicensed package before adding it to a commercial product
- **Prefer native over library** — if the browser or Node already does it well, don't add a dependency; every package is a future CVE and update burden

---

## New Database Tables (Supabase projects)

When writing a migration that creates a new table, every item below is required before the migration is considered done:

- `ALTER TABLE ... ENABLE ROW LEVEL SECURITY` in the same migration
- At least one policy per operation the app uses (SELECT / INSERT / UPDATE / DELETE) — or a comment documenting why it's service-role-only with no policies
- `user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE` for per-user tables
- `id uuid PRIMARY KEY DEFAULT gen_random_uuid()`
- `created_at timestamptz NOT NULL DEFAULT now()`
- `updated_at timestamptz NOT NULL DEFAULT now()` + trigger
- `ON DELETE CASCADE` or `SET NULL` on every foreign key — never leave the default `NO ACTION`
- `CREATE INDEX CONCURRENTLY idx_<table>_user_id` on `user_id`
- `CREATE INDEX CONCURRENTLY idx_<table>_user_deleted` on `(user_id, deleted_at)` if the table has soft deletes
- `CREATE INDEX CONCURRENTLY idx_<table>_<fk_col>` on every other FK column
- Add the table to `CLAUDE.md` and regenerate `types.ts`

---

## Edge Functions / API Endpoints

- **Always verify auth first** — JWT check or service-role guard before any read, write, or external API call
- **Always rate limit** on mutating endpoints
- **Always sanitize error responses** — never let raw Postgres errors, Stripe errors, or stack traces reach the HTTP body
- **Initialize heavy clients at module level** — `new Stripe(...)`, `createClient(...)`, etc. belong outside the request handler so they're created once per cold start, not once per request

---

## Data Integrity

- **Always write paired fields together** — `completed` and `completed_at` must be set in the same operation; `start_time` and `end_time` must both be present when status is `timed`; never set one without the other
- **Always cascade on delete** — when a parent record is deleted, ensure child records and associated storage files are cleaned up; no orphans
- **Prefer DB constraints over app validation** — if a value has a valid range (0–100, fixed enum set, must-be-positive), add a `CHECK` constraint in the migration in addition to validating in the UI; app validation can be bypassed, DB constraints cannot
- **Always use `INSERT ... ON CONFLICT`** for upserts — the check-then-insert pattern creates duplicates under concurrent load

---

## Before Finishing Any Code Change

Run a quick mental check:

1. Does every new query have named columns, a limit, and a user_id filter?
2. Does every new `useEffect` have a dep array and a cleanup if it sets up anything?
3. Does every new async operation handle failure, show an error state, and prevent double-firing?
4. Does every new component handle loading, empty, and error states?
5. Are all interactive elements keyboard accessible with visible focus and proper labels?
6. Do all new colors, spacing, and components use the design system — no hardcoded values?
7. If I added a new table: does it have RLS, indexes, and documentation?
8. Are any secrets, raw errors, or unvalidated inputs in the new code?
9. Is there anything to log or monitor so failures in this path are visible in production?
