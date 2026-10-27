---
paths:
  - ".env.example"
  - "**/env.{ts,js,mjs}"
  - "**/env/**"
  - "next.config.*"
  - "astro.config.*"
  - "package.json"
  - "pnpm-lock.yaml"
  - "package-lock.json"
  - "yarn.lock"
  - "bun.lock*"
  - ".nvmrc"
  - "**/lib/**"
  - "**/app/**"
  - "**/providers*"
---

# Env vars, build and SSR

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Env var or ID missing or wrong at deploy** (CI-1, ~29 fixes, 7 repos): a new env var exists
  in **every** Vercel environment (preview, staging, production) and in `.env.example` (name only,
  never a value); one variable per meaning (don't reuse `APP_RETURN_URL` as the site base URL).
  List it in the PR's deploy notes. Prevention: validate required env at build (zod / t3-env) so a
  missing var fails the build instead of needing an empty "redeploy" commit.
- **Build crashes at deploy time** (CI-2, ~30 fixes, 13 repos): no SDK client constructed at
  module scope when it needs secrets at import time (OpenAI, Algolia, Prisma…): create it inside
  the handler. The production build and `tsc --noEmit` pass locally (`scripts/check.sh`).
- **Hydration / SSR mismatch** (CSS-4, ~17 fixes, 8 repos): no `Date`, `toLocale*`,
  `Math.random` or `window` in render paths; dates formatted with an explicit `timeZone` and
  locale; `useSearchParams` inside a Suspense boundary; scripts and providers in `<head>`/`<body>`
  where the framework expects them.
- **Lockfile / package manager / Node drift** (CI-4, ~17 fixes, 13 repos): the PR changes one
  lockfile only, from the package manager in `packageManager`; `engines`, `.nvmrc`, CI and Vercel
  agree on the Node version.

Example fixes: https://github.com/hellolitebox/client-atomix-app/pull/155 ·
https://github.com/hellolitebox/client-aicouncil-app/pull/261
