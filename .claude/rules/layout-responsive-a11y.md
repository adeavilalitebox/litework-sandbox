---
paths:
  - "**/*.css"
  - "**/*.scss"
  - "**/*.module.*"
  - "**/components/**"
  - "**/sections/**"
  - "**/*.astro"
  - "tailwind.config.*"
  - "**/tokens*"
  - "**/theme*"
---

# Layout, breakpoints, browsers and accessibility

Recurring errors from Litebox fixes, 2025-10 → 2026-10. This is the largest family (~977 layout
fixes, inflated by vague titles). Counts are approximate.

- **Scroll / sticky / overflow regressions** (CSS-3, ~97 fixes, 19 repos): check the preview at
  375 px and at 1280×600, top to bottom: no sideways scroll, no clipped text, sticky elements don't
  cover anchors; Lenis/ScrollTrigger pages still scroll. Never `overflow-x: hidden` on html/body
  to hide a bug. Prevention: Playwright assertion `document.documentElement.scrollWidth <=
  innerWidth` at 360/768/1280.
- **Doesn't match Figma / the design system** (CSS-5, ~78 fixes, 14 repos): compare against the
  Figma frame at every breakpoint (visual-qa); use design tokens and theme values, no magic px.
- **Breaks at one breakpoint or viewport height** (CSS-2, ~70 fixes, 16 repos): every layout
  covers 768–1024, 1024–1280 and ≥1920, not only "mobile" and "desktop"; short laptop heights
  (≈600–700 px) too. Use the shared breakpoint constants.
- **Safari / iOS / Firefox only** (CSS-1, ~32 fixes): search the diff for `dvh`/`svh`,
  `color-mix`, `backdrop-filter`, `overscroll-behavior`, `:has`, media-query range syntax; check
  support for Safari < 16.4 or ship a fallback.
- **Accessibility** (A11Y-1, ~39 fixes, 14 repos): contrast from tokens, touch targets ≥ 44 px,
  labels on inputs and icon buttons, alt text, keyboard focus visible, landmarks. Run axe on the
  changed page.

Example fixes: https://github.com/hellolitebox/client-aicouncil-app/pull/330 ·
https://github.com/hellolitebox/client-vu-app/pull/342
