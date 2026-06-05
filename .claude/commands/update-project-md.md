# Update Project MD

You are keeping the project's `CLAUDE.md` accurate and useful. This is not a rewrite from scratch — it is a careful update in place. The goal: a developer (or a new Claude session) reading `CLAUDE.md` should get a complete, current picture of the project without reading a single line of code.

Spawn all research agents simultaneously, wait for all results, then write the updated file.

---

## Spawn Parallel Research Agents

### AGENT 1 — Codebase Reality Check

> You are auditing a project's CLAUDE.md for accuracy. Read the existing `CLAUDE.md` at the project root, then read the actual codebase and identify everything that has drifted or is missing. Do NOT rewrite anything — just report findings.
>
> **Routes & pages:** Read `src/App.tsx` or equivalent router file. List every route — path, component, public vs protected. Flag any route in `CLAUDE.md` that no longer exists, and any route in the code that isn't documented.
>
> **Database schema:** Read every file in `supabase/migrations/`. For each table: does it exist in CLAUDE.md? Are all columns documented? Are any columns missing, renamed, or added since the last CLAUDE.md update?
>
> **Edge functions / API routes:** List every function in `supabase/functions/`. Which are documented in CLAUDE.md? Which are missing?
>
> **Architecture notes:** Read key files — `src/App.tsx`, `src/main.tsx`, `vite.config.ts`, `src/hooks/`, `src/components/`. Identify any significant patterns, libraries, or decisions NOT documented in CLAUDE.md.
>
> **Domain model:** Does the domain model section still match how the app actually works?
>
> Report a structured diff: what's stale, what's missing, what's accurate.

---

### AGENT 2 — Findings File Knowledge Extraction

> You are mining completed audit findings for architectural knowledge. Read every `*_FINDINGS.md` file that exists at the project root. Do NOT report open bugs — those belong in findings files, not CLAUDE.md. Extract only knowledge that helps future developers understand HOW the app works or what rules to follow.
>
> For each findings file, extract:
>
> **From Fixed sections:** Look for fixes that revealed an architectural decision, a non-obvious constraint, or a deployment gotcha.
> Examples worth extracting:
> - "Fixed: migrations are not auto-applied on deploy — must run manually in dashboard" → worth noting as a project rule
> - "Fixed: is_user_confirmed anon EXECUTE was revoked — polling now routes through check-user-confirmed edge function" → worth noting in architecture notes
>
> **From Open/recurring patterns:** If the same type of issue appears across multiple scans, that pattern should become a project-specific rule.
>
> **From Schema findings:** Any table, column, index, or constraint not in CLAUDE.md.
>
> **From Architecture/Refactor findings:** Any architectural decision that reveals how the system is actually structured.
>
> Do NOT extract: individual bug descriptions, open issues, specific line numbers, or anything that belongs in findings files.
>
> Report a clean list: "Add to Rules: ...", "Add to Table X docs: ...", "Add to Architecture Notes: ..."

---

### AGENT 3 — Project Rules Gap Analysis

> You are checking whether the project's `CLAUDE.md` captures the project-specific constraints that matter most. Read `CLAUDE.md` and the codebase, focusing on things that would surprise a developer new to this project.
>
> Check for undocumented:
> - **Deployment gotchas:** anything about how this project deploys that differs from the default
> - **Auth/entitlement patterns:** project-specific auth flows, custom entitlement logic, or RLS patterns
> - **Third-party integration quirks:** connected services (OAuth, webhooks, API quota limits, encryption)
> - **Data integrity rules:** paired-field requirements, soft-delete patterns, cascade behaviors
> - **Known limitations or workarounds:** non-obvious platform constraints
> - **Decisions that look wrong but are intentional:** anything a developer might "fix" that would break something
>
> Report each gap as: "Missing rule: [the rule a developer needs to know]"

---

## Compile and Rewrite

Once all three agents have returned, rewrite `CLAUDE.md` at the project root. Follow these rules exactly:

### What to preserve
- The overall structure and section order of the existing file
- All content that is still accurate
- The tone and level of detail already established
- Any project-specific history or context

### What to update
- Stale routes, tables, columns — update to match current reality
- Missing routes, tables, columns — add them
- Missing architecture notes — add in the appropriate section
- Project rules extracted from findings — add to the Rules section

### What NOT to add
- Open bugs or issues (those belong in findings files)
- Universal coding standards (those are in `~/.claude/CLAUDE.md`)
- Verbose explanations of things obvious from the code
- Anything speculative — only document what is confirmed

### Format for new table entries

```markdown
### `table_name`
[One line: what this table stores and its role in the domain model.]

| Column | Type | Notes |
|--------|------|-------|
| `id` | uuid PK | |
| `user_id` | uuid | FK → auth.users |
| `column_name` | type | notes |
| `created_at` | timestamptz | |
| `updated_at` | timestamptz | |
```

### Format for new rules

```
- **[Short rule name]:** [Plain English explanation. Why it matters and what breaks if ignored.]
```

### Format for new architecture notes

```
- **[Feature or pattern name]:** [How it works, what files are involved, any non-obvious details.]
```

---

## After Writing

Report back:
- How many sections were updated
- What was added (new tables, routes, rules, architecture notes)
- What was removed or corrected (stale content)
- Which findings files contributed knowledge
- Whether any section still needs manual input