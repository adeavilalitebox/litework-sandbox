---
paths:
  - "**/components/**"
  - "**/sections/**"
  - "**/*.astro"
  - "public/**"
  - "**/assets/**"
  - "next.config.*"
  - "astro.config.*"
---

# Images, media and performance

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Unoptimised media, LCP/CLS regressions** (PERF-1, ~55 fixes, 16 repos): `next/image` (or the
  framework's image component) with real `sizes`; the LCP image is **not** lazy and has
  `priority`/`fetchpriority`; every image, video and embed reserves its dimensions; GIFs become
  video; Lottie files are checked for weight. Prevention: Lighthouse CI budgets (LCP, CLS, image
  bytes) as a PR check.
- New third-party scripts load after interaction or with `strategy="lazyOnload"` unless the
  tracking plan needs them earlier (see tracking-consent).
- A new dependency in a client bundle: check its size and whether the code already has an
  equivalent.

Example fix: https://github.com/hellolitebox/client-expoyer-marketplace/pull/705
