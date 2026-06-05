# Mobile & PWA Scan

You are orchestrating a mobile and PWA audit. Spawn all agents simultaneously and wait for all results before compiling.

---

## Spawn Parallel Agents

### AGENT 1 — PWA Health & Installability

> You are a mobile/PWA auditor. Check that this PWA is correctly configured. Rate every finding High / Medium / Low.
>
> Check `public/manifest.json`, `vite.config.ts`, service worker files:
> - Web App Manifest: all required fields: `name`, `short_name`, `start_url`, `display`, `background_color`, `theme_color`, `icons`?
> - Icons at all required sizes? iOS requires 180x180. Android requires 192x192 and 512x512.
> - Apple-specific meta tags?
> - Offline fallback: meaningful offline page?
>
> Report every finding with file path and line number.

---

### AGENT 2 — Responsive Design & Layout

> You are a mobile/PWA auditor. Check that every screen renders correctly on mobile. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Viewport meta tag present?
> - Horizontal scroll: fixed-width elements causing overflow?
> - Text overflow: long text overflowing containers?
>
> Report every finding with file path and line number.

---

### AGENT 3 — Mobile UX & Native Feel

> You are a mobile/PWA auditor. Check that the app feels native on a touchscreen. Rate every finding High / Medium / Low.
>
> Check every file in `src/`:
> - Touch targets: all interactive elements at least 44x44px?
> - Input types: correct `type` attribute for mobile keyboards?
> - Drag and drop: works with touch events, not just mouse events?
>
> Report every finding with file path and line number.

---

### AGENT 4 — Push Notifications & Mobile Integration

> You are a mobile/PWA auditor. Check the push notification setup. Rate every finding High / Medium / Low.
>
> - iOS compatibility: push notifications on iOS only work when PWA is installed. Is this communicated to users?
> - Permission prompt: notification permission triggered by user gesture, not page load?
> - Failed delivery handling: when push delivery fails (404/410), is subscription cleaned up?
>
> Report every finding with file path and line number.

---

## Compile the Report

Compile results into `MOBILE_FINDINGS.md` at the project root. Diff against existing file.

### File format
```
# Mobile & PWA Findings
**Last scan:** [date]
**Agents run:** [list]

## Summary
| Severity | Open | Pending Verification | Fixed |

## Open Findings
## Pending Verification
## Fixed
```

After writing, update `AUDIT_DASHBOARD.md`.