# Project Agent Instructions

This project uses a structured multi-agent workflow. See @AGENTS.md for the full harness specification.

## Quick Reference
- **Current status**: @STATUS.md
- **Build plan**: @BUILD_PLAN.md
- **Task cards**: @specs/
- **Eval definitions**: `@evals/` if the `eval-harness` extension is installed

## Core Rules
1. No TASK card → no coding
2. No Plan → no major changes
3. No Verify/Review → no declaring completion
4. `[HUMAN GATE]` nodes → must pause and wait for human confirmation

## Subagents
Use the specialized subagents in `.claude/agents/` for their designated roles:
- `planner` — read docs, produce Plan
- `generator` — implement code per Plan
- `evaluator` — verify and review
- `fixer` — fix evaluator-flagged failures

Default orchestration:
- Spawn all four subagents up front
- Only allow the next role to proceed when its prerequisite artifact is written back to the TASK card
- If one subagent dies or stalls, either respawn that role or fall back to single-agent serial execution

## Verification
- Verify against `Done when`, changed files, command output, screenshots, and manual checks
- Execute structured assertions in the TASK card instead of relying on project scripts

## Sync
Update the current TASK card, `STATUS.md`, and `BUILD_PLAN.md` when a task closes
