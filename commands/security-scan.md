# Security Scan

You are orchestrating a comprehensive adversarial security audit. Follow these steps exactly.

---

## Step 1 — Stack Detection (run first, alone)

Spawn a single agent using the Agent tool with this prompt:

> "Read the following files if they exist and report back exactly what you find — do not scan for vulnerabilities yet, just identify the stack:
> - `package.json` (dependencies and scripts)
> - `requirements.txt` / `pyproject.toml` / `go.mod` / `Cargo.toml` (if present)
> - `supabase/migrations/` (list the most recent 5 migration filenames)
> - `supabase/functions/` (list all function folder names)
> - `vite.config.ts` / `next.config.js` / `webpack.config.js` (if present)
> - Any `.env.example` file
>
> Report: framework, database/backend, auth provider, payment processor, third-party integrations (OAuth providers, fitness APIs, etc.), whether edge/serverless functions exist, whether file uploads exist, whether push notifications exist."

Wait for this agent to finish before proceeding.

---

## Step 2 — Spawn Parallel Agents

Based on the stack detection results, spawn ALL of the following core agents simultaneously using the Agent tool. Then also spawn any conditional agents that apply. All agents run in parallel — do not wait for one before starting the next.

---

### CORE AGENT 1 — Auth, Session & Privilege Escalation

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check every file in `src/` and any server-side code:
> - Is authentication enforced on every protected route and function?
> - IDOR: does the code verify the authenticated user owns the specific resource being accessed?
> - Client-side trust: is the app making security decisions based on data from the client?
> - Non-linear flows: what happens if a user skips a step?
> - Session tokens / JWTs: validated before trusting their claims? Stored securely?
> - Timing attacks: secret comparisons done with `===` instead of constant-time comparison?
> - Privilege escalation: any `SECURITY DEFINER` SQL functions that don't validate the caller?
> - Admin-only functions: verify admin status server-side, not just client-side?
>
> Report every finding with file path and line number.

---

### CORE AGENT 2 — Client-Side & Frontend

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - XSS: `dangerouslySetInnerHTML`, `innerHTML`, `document.write`, `eval()`, `new Function()`?
> - DOM injection: dynamic script insertions or template literals building HTML from user data?
> - Open redirects: `window.location`, `router.push`, or `navigate()` using a URL from query params without allowlist validation?
> - Prototype pollution: `Object.assign`, deep merge utilities, or `JSON.parse` results spread onto objects?
> - ReDoS: regex patterns with nested quantifiers?
> - Input validation: allowlist-based rather than blocklist?
> - Sensitive data in localStorage or sessionStorage?
> - Fetch/API calls concatenating user input into URLs?
>
> Report every finding with file path and line number.

---

### CORE AGENT 3 — Server-Side & Injection

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check all server-side code:
> - Injection: queries built by string concatenation?
> - SSRF: server making HTTP requests using a URL from user input?
> - Path traversal: server reading/writing files using paths from user input?
> - Command injection: user input passed to exec/spawn/shell?
> - Error handling: catch blocks returning raw errors to caller?
> - Input validation: each function validates inputs before use?
> - Functions accepting `user_id` from request body without verifying it matches JWT?
>
> Report every finding with file path and line number.

---

### CORE AGENT 4 — Security Headers & Transport

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check `index.html`, config files, and edge function response headers:
> - CSP header: restricts `script-src`, `connect-src`, `img-src`? `unsafe-inline` or `unsafe-eval` present?
> - HSTS: set with sufficient `max-age`? `includeSubDomains` set?
> - X-Frame-Options or `frame-ancestors` CSP directive?
> - X-Content-Type-Options: `nosniff`?
> - Referrer-Policy set?
> - Cookie flags: `HttpOnly`, `Secure`, appropriate `SameSite`?
> - CORS: `Access-Control-Allow-Origin` restricted to known domains?
>
> Report every finding with file path and line number.

---

### CORE AGENT 5 — Secrets, Cryptography & Dependencies

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check the entire codebase:
> - Hardcoded secrets: grep for `sk_live_`, `sk_test_`, `service_role`, `eyJ`, `-----BEGIN`, `password =`, `secret =`, `api_key =`, `PRIVATE KEY`.
> - `.gitignore`: are `.env` files with real values tracked by git?
> - Cryptographic weaknesses: MD5 or SHA1 for password hashing? `Math.random()` for security-sensitive purposes?
> - Token entropy: generated tokens/nonces have at least 128 bits of entropy?
> - Supply chain: packages with very few downloads, recently transferred ownership, or typosquatting names?
>
> Report every finding with file path and line number.

---

### CORE AGENT 6 — Business Logic, Race Conditions & Edge Cases

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check the full codebase:
> - Race conditions: two requests modifying the same resource simultaneously?
> - TOCTOU: gap between when permission is checked and when action is taken?
> - Price/quantity manipulation: negative quantity, zero price, arbitrary discount?
> - Limit bypass: rate limits enforced on every code path?
> - Free tier bypass: ways to access premium features without valid subscription?
> - Null / zero / empty edge cases in critical business logic?
>
> Report every finding with file path and line number.

---

### CONDITIONAL AGENT 7 — Supabase: RLS & Data Isolation
*(Spawn only if Supabase detected)*

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check `supabase/migrations/` and all queries in `src/`:
> - Every table: RLS enabled? Policies for SELECT, INSERT, UPDATE, DELETE?
> - Every query in `src/`: includes `.eq('user_id', ...)` or equivalent scoping?
> - Soft-delete leaks: missing `.is('deleted_at', null)` on tables with `deleted_at`?
> - Views: all use `WITH (security_invoker=true)`?
> - `SECURITY DEFINER` functions: validate `auth.uid()` matches requested user?
> - Service role key: ever used in client-side code?
>
> Report every finding with file path and line number.

---

### CONDITIONAL AGENT 8 — Stripe: Billing & Entitlements
*(Spawn only if Stripe detected)*

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check Stripe webhook handler and all billing/entitlement code:
> - Webhook signature: verified on every request before any processing?
> - Idempotency: every Stripe event claimed before handling?
> - Redirect URL validation: checkout success/cancel URLs validated against allowlist?
> - Entitlement enforcement: subscription checks enforced server-side?
> - Stripe secret keys: ever referenced in client-side code?
>
> Report every finding with file path and line number.

---

### CONDITIONAL AGENT 9 — OAuth & Third-Party Integrations
*(Spawn only if OAuth flows or third-party integrations detected)*

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check all OAuth flows and integration code:
> - CSRF protection: `state` parameter generated, stored, and validated on OAuth callback?
> - Token storage: OAuth tokens stored encrypted at rest?
> - Token refresh race conditions: lock to prevent concurrent refresh races?
> - Webhook authenticity: payload authenticity verified for inbound webhooks?
> - Revocation handling: when user disconnects, tokens revoked with provider AND deleted locally?
>
> Report every finding with file path and line number.

---

### CONDITIONAL AGENT 10 — Edge Functions & Serverless
*(Spawn only if edge functions detected)*

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check all files under `supabase/functions/`:
> - CORS: every function validates `Origin` against allowlist?
> - Rate limiting: every mutating function enforces a rate limit?
> - Error sanitization: catch blocks returning raw error messages?
> - Service role misuse: service role key used only where strictly necessary?
> - Functions accepting `user_id` from request body without verifying it matches JWT?
>
> Report every finding with file path and line number.

---

### CONDITIONAL AGENT 11 — File Uploads
*(Spawn only if file upload functionality detected)*

> You are a security adversary. Hunt for vulnerabilities. Rate every finding High / Medium / Low.
>
> Check all file upload handling code:
> - File type validation: validated by checking actual file content (magic bytes)?
> - Allowlist: allowed file type check is an allowlist?
> - File size limits: maximum file sizes enforced server-side?
> - Direct URL access: can a user access another user's uploaded files by guessing the URL?
>
> Report every finding with file path and line number.

---

## Step 3 — Compile the Report

Compile results into `SECURITY_FINDINGS.md` at the project root. Do NOT simply append — diff against existing file.

### Findings format

```
### [ID] — [Severity]
**What:** [Specific technical description]
**Why it matters:** [Plain English explanation of real-world impact]
**File:** `path/to/file.ts:[line]`
**Direction:** [One-line suggested approach]
**Status:** Open | First found: [today's date]
```

### Diff logic
1. Run fresh scan, collect all findings
2. Read existing `SECURITY_FINDINGS.md` if it exists
3. New finding matching existing Open: update if improved, do NOT duplicate
4. New finding matching Fixed: move back to Open, mark **⚠️ REGRESSION**
5. New finding not in file: add to Open
6. Existing Open not found in scan: move to Pending Verification
7. Fixed not re-found: leave in Fixed
8. Update scan date

### File format
```
# Security Findings
**Last scan:** [today's date]
**Agents run:** [list agents that ran]

## Summary
| Severity | Open | Pending Verification | Fixed |
|----------|------|----------------------|-------|
| High     | X    | X                    | X     |
| Medium   | X    | X                    | X     |
| Low      | X    | X                    | X     |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update the `Security` section of `AUDIT_DASHBOARD.md`.