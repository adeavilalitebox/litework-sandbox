## <Ticket ID> — <title>

**ClickUp:** <card URL> · **Preview:** <URL>

## What

<!-- What changed and the approach, in plain language. -->

## Acceptance criteria

- [ ] <criterion> — <how it was verified>

## Verification

<!-- `scripts/check.sh` result. Visual QA / Playwright / SEO checks as they apply.
A bug fix: the regression test run WITHOUT the fix and how it failed (stash or parent commit,
the error). No test suite in the repo: the exact repro steps before and after. -->

## Deploy notes

- Env vars (name, and which Vercel environments: preview / staging / production): none
- CMS: schema change, migration, revalidation or webhook: none
- Redirects / route changes (sitemap, llms.txt, robots updated): none
- One-off steps: none
- Rollback: redeploy the previous production deployment in Vercel, nothing else

Rules applied: <!-- .claude/rules files that loaded for the changed paths, or "none" -->
