---
paths:
  - "**/sanity/**"
  - "**/studio/**"
  - "**/schemas/**"
  - "**/strapi/**"
  - "**/cms/**"
  - "**/api/revalidate*"
  - "sanity.config.*"
  - "sanity.cli.*"
  - "**/*.queries.*"
  - "**/queries/**"
---

# CMS (Sanity / Strapi)

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Component ignores the CMS field or crashes on empty data** (CMS-2, ~13 fixes; LOGIC-1, ~12):
  render every CMS-driven component with empty, null and missing fields (optional chaining, empty
  arrays, cleared references); nothing hard-coded that the CMS should control (nav, FAQ, CTA).
  Prevention: schema-driven fixtures with empty values; strict null checks on generated types.
- **Content changes don't revalidate** (CMS-3, ~11 fixes): every new document type has a
  revalidation tag or webhook, and both publish and unpublish trigger it.
- **Studio preview / visual editing blocked** (CMS-1, ~9 fixes): CSP `frame-ancestors` allows the
  studio origin; enum/string values read in preview mode are `stegaClean`ed before comparisons.
- **Generated types out of sync** (CMS-4, ~5 fixes): schema edits regenerate and commit the CMS
  types in the same PR.
- Schema changes are **additive** unless the PR says otherwise: existing documents must still
  render. Note any migration in the PR's deploy notes.

Example fix: https://github.com/hellolitebox/client-aicouncil-app/pull/264
