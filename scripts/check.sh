#!/usr/bin/env bash
# The checks CI runs, in one command: green here means green there. Litework and its QA reviewer
# run this before every push and review (idea from hellolitebox/litebox-inbox-jev).
#
#   scripts/check.sh             install from the lockfile, lint, type-check, test, build
#   scripts/check.sh --fix       the same, running the repo's `format` / `lint:fix` scripts first
#   scripts/check.sh --no-build  skip the production build (CI and the QA reviewer's worktree,
#                                which have no env vars: the Vercel preview build is that gate)
#
# Installs from the lockfile exactly as CI does (a stale node_modules can't hide a failure), fails
# on a second lockfile, and runs only the package.json scripts that exist. Exits on the first
# failing step.
set -euo pipefail
cd "$(dirname "$0")/.."

fix=0 build=1
for arg in "$@"; do
  case "$arg" in
    --fix) fix=1 ;;
    --no-build) build=0 ;;
    *) echo "usage: $0 [--fix] [--no-build]" >&2; exit 2 ;;
  esac
done

step() { printf '\n== %s\n' "$*"; }

locks=0
for f in pnpm-lock.yaml yarn.lock bun.lock bun.lockb package-lock.json; do [ -f "$f" ] && locks=$((locks + 1)); done
[ "$locks" -le 1 ] || { echo "more than one lockfile: keep only the package manager's own" >&2; exit 1; }

if [ -f pnpm-lock.yaml ]; then pm=pnpm; install=(pnpm install --frozen-lockfile)
elif [ -f yarn.lock ] && [ -f .yarnrc.yml ]; then pm=yarn; install=(yarn install --immutable)
elif [ -f yarn.lock ]; then pm=yarn; install=(yarn install --frozen-lockfile)
elif [ -f bun.lock ] || [ -f bun.lockb ]; then pm=bun; install=(bun install --frozen-lockfile)
elif [ -f package-lock.json ]; then pm=npm; install=(npm ci)
else echo "no lockfile: commit one so CI and local install the same versions" >&2; exit 1
fi

has() { node -e "process.exit(require('./package.json').scripts?.[process.argv[1]] ? 0 : 1)" "$1"; }
run() { if has "$1"; then step "$pm run $1"; "$pm" run "$1"; else echo "(no '$1' script, skipped)"; fi; }

step "${install[*]}"
"${install[@]}"

if [ "$fix" = 1 ]; then
  has format && { step "$pm run format"; "$pm" run format; }
  has lint:fix && { step "$pm run lint:fix"; "$pm" run lint:fix; }
fi

run lint
if has typecheck; then run typecheck
elif [ -f tsconfig.json ]; then step "tsc --noEmit"; ./node_modules/.bin/tsc --noEmit
fi
CI=1 run test
[ "$build" = 1 ] && run build
step "all checks passed"
