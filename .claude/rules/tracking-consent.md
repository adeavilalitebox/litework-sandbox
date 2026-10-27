---
paths:
  - "**/*analytics*"
  - "**/*tracking*"
  - "**/*posthog*"
  - "**/*gtm*"
  - "**/*gtag*"
  - "**/*consent*"
  - "**/*cookie*"
  - "**/*mixpanel*"
  - "**/*amplitude*"
---

# Tracking and consent

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Event wrong, duplicated or missing vs the tracking plan** (TRK-2, ~56 fixes, 11 repos): diff
  every new or changed event against the tracking plan: name, properties, trigger. Check it can't
  fire twice (effect dependencies, client-side navigation, Strict Mode) or before the SDK is ready.
  Prevention: one typed `trackEvent()` with a union of event names; a test that an interaction
  fires its event exactly once; link the tracking plan in the PR.
- **Consent gating wired wrong** (TRK-1, ~44 fixes, 7 repos): no analytics/ads script or cookie is
  initialised before the consent state is read. The banner script (CookieYes etc.) is a plain
  `<script>` in `<head>`; its ID comes from an env var that exists in **every** Vercel
  environment. Prevention: one consent-gate helper wrapping every tracker; an e2e test asserting
  zero tracking requests before consent.
- Never put personal data in event properties unless the tracking plan says so.

Example fix: https://github.com/hellolitebox/client-aicouncil-app/pull/234
