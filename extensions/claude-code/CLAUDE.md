# Project Agent Instructions

This project uses a structured multi-agent workflow. See @AGENTS.md for the full harness specification.

## Quick Reference
- **Current status**: @STATUS.md
- **Build plan**: @BUILD_PLAN.md
- **Task cards**: @specs/
- **Eval definitions**: `@evals/` if the `eval-harness` extension is installed

## Core Rules
1. No TASK card → no coding
2. No Plan → no medium/high-risk changes
3. No Verify/Review → no declaring completion
4. `[HUMAN GATE]` nodes → must pause and wait for human confirmation
5. Before any delegation, do a `Capability Gate`: if subagent tools are unavailable or not allowed in the current environment, immediately switch to single-agent serial fallback and say so explicitly
6. The main controller must explicitly record `Lane Decision` and `Plan Gate` before execution

## Subagents
Use the specialized subagents in `.claude/agents/` for their designated roles:
- `planner` — read docs, produce Plan
- `generator` — implement code per Plan
- `evaluator` — verify and review
- `fixer` — fix evaluator-flagged failures

Lane-based orchestration:
- `Fast Lane`: default to `generator -> evaluator`
- `Standard Lane`: default to `planner -> generator -> evaluator`
- `Strict Lane`: add `fixer` only after evaluator finds failures
- Do not spawn all four subagents up front by default
- `Plan Review` is a conditional gate, not a default gate for every task
- `Fast Lane` should normally skip `Plan Review`
- Only allow the next role to proceed when its prerequisite artifact is written back to the TASK card
- If one subagent dies or stalls, either respawn that role or fall back to single-agent serial execution

Patch-task support:
- For 1-2 file low-risk fixes, prefer `specs/PATCH-TASK.md` over a full TASK card
- `Patch Task` defaults to `Fast Lane` with `Plan Gate = Skipped`

## Verification
- Verify against `Done when`, changed files, command output, screenshots, and manual checks
- Choose the smallest verification template that matches the task type
- Do not assume `scripts/verify.sh` exists in every project

## Sync
Always update the current TASK card and `STATUS.md` when a task closes.
Update `BUILD_PLAN.md` only for milestone-level changes.
