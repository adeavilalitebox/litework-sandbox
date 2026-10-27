---
paths:
  - "next.config.*"
  - "astro.config.*"
  - "vercel.json"
  - "**/middleware.*"
  - "**/redirects*"
  - "**/i18n/**"
  - "**/locales/**"
  - "**/messages/**"
  - "**/[[]locale[]]/**"
  - "**/routing*"
  - "**/pathnames*"
---

# Routing, redirects and i18n

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Legacy URLs not redirected at cutover** (I18N-1, ~30 fixes, 13 repos): when a route or slug
  moves, the old path has a **permanent** redirect to a page that returns 200, in the same PR.
  Grep the old path in the redirect config and middleware. Prevention: a redirect table in code
  with a test that every legacy URL (from a crawl of the old site) resolves 301 → 200; a cutover
  checklist.
- **Localised route, slug or hreflang missing for a locale** (I18N-2, ~12 fixes): every new page
  or link exists for **every** locale: localised slug (pathnames map), `hreflang` alternates and
  sitemap entries. Prevention: one locale route manifest used by the router, sitemap, footer and
  hreflang; a test that iterates every locale.
- A route change also updates sitemap, `llms.txt` and robots (see seo-metadata).

Example fix: https://github.com/hellolitebox/client-puppygraph-web/pull/2
