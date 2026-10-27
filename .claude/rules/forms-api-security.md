---
paths:
  - "**/api/**"
  - "**/actions/**"
  - "**/server/**"
  - "**/forms/**"
  - "**/*form*"
  - "**/*webhook*"
  - "**/middleware.*"
  - "**/jobs/**"
  - "**/cron/**"
---

# Forms, API routes, webhooks and security

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Form / lead flow** (FORM-1, ~38 fixes, 10 repos): client and server validation come from the
  same schema (zod); double submit is prevented (disable on submit, idempotency); bot guards and
  captchas fail open for real users and log their decisions.
- **Payments and webhooks** (FORM-2, ~38 fixes, 5 repos): signature comparison normalised (case,
  encoding); handlers idempotent; async rejection states handled; sandbox vs production config
  explicit.
- **Escaping and access** (DEP-2, ~11 fixes, 7 repos): every value inserted into HTML, `<script>`,
  JSON-LD, CRM payloads or headers is escaped; every new endpoint checks auth and validates input;
  security headers (CSP, frame-ancestors, cookie flags) are not weakened.
- **Retries, timeouts, races** (LOGIC-2, ~27 fixes, 10 repos): every network call has a timeout;
  background jobs have retry with backoff, per-host rate limits and a single-flight lock.
- **Null / unknown shapes from outside** (LOGIC-1): validate external responses at the boundary;
  the failing branch is tested.

Example fixes: https://github.com/hellolitebox/client-vu-app/pull/393 ·
https://github.com/hellolitebox/client-aicouncil-app/pull/251
