---
paths:
  - "**/metadata*"
  - "**/layout.{ts,tsx,js,jsx}"
  - "**/page.{ts,tsx,js,jsx}"
  - "**/*.astro"
  - "**/*seo*"
  - "**/*head*"
  - "**/sitemap*"
  - "**/robots*"
  - "**/llms*"
  - "**/*json-ld*"
  - "**/*schema-org*"
---

# SEO metadata, sitemap and structured data

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **og / canonical / alternates from the wrong base** (SEO-1, ~37 fixes, 11 repos): every
  `og:url`, `og:image`, canonical and `alternates` value is an **absolute** URL built from one
  site-origin helper (never the preview host, never string concatenation), with the same
  trailing-slash policy as the route. Prevention: central `getUrl()`/`siteOrigin`, a unit test over
  the metadata exports.
- **Sitemap / llms.txt / robots not updated** (SEO-2, ~34 fixes): a PR that adds, renames or
  localises a route updates `sitemap`, `llms.txt`, `robots` and redirects in the same PR. Check a
  static `public/robots.txt` isn't shadowing the app route. Prevention: sitemap built from the
  route manifest; fetch `/sitemap.xml` and `/robots.txt` on the preview.
- **Heading hierarchy** (SEO-3, ~25 fixes): exactly one `<h1>` **in the server HTML** (curl the
  preview, not the browser DOM), no skipped levels; animated headings still ship real text.
- **JSON-LD** (SEO-4, ~17 fixes): output is valid JSON (`JSON.parse` it), dynamic values are
  escaped (`<` and `</script>`), no duplicates per page. Prevention: typed builders (schema-dts)
  and one `safeJsonLd()` helper.

Example fix: https://github.com/motherduckdb/motherduck-website/pull/3329
