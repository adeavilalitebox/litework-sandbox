# Hygiene, releases and CI (always on)

Recurring errors from Litebox fixes, 2025-10 → 2026-10. Counts are approximate (title-based).

- **Leftovers shipped** (CI-5, ~19 fixes, 8 repos): no placeholder copy, test routes,
  `console.log`/`debugger`, committed build output (`.next/`, `.vercel/output`, `dist/`) or files
  added by mistake. Review `git diff --stat` before every push.
- **Reverts** (REV-1, ~35 fixes, 16 repos): a change that wasn't checked on the preview in the
  target browsers tends to come back as a revert. The preview is part of done.
- **Same fix twice for Main and Develop** (DUP-1, ~32 fixes): when a hotfix targets the release
  branch, the counterpart on the other branch is part of the same task (back-merge or a linked PR).
- **Dependency bump rounds** (DEP-1, ~25 fixes): security bumps pin and bound overrides to the
  same major and keep the lockfile diff small; one bump per package per round.
- **Copied CI workflows** (CI-3, ~17 fixes, 13 repos): a workflow copied from another repo is
  diffed against its source, and every failure path (missing output, skipped job, bot PR) ends in a
  **failing** status, never a silent pass. Prefer a reusable workflow (`workflow_call`).
- **Secrets**: never read, print or commit `.env*` values or tokens. If gitleaks flags a real
  secret, **rotate it first**, then remove or ignore it.
