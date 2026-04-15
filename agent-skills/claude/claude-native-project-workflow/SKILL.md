---
name: claude-native-project-workflow
description: Full Claude-native project workflow. Use this skill whenever the user asks to bootstrap an empty repo, continue task execution, choose Fast/Standard/Strict lane, pass Brainstorm/Plan/Sync human gates, or enforce Verify+Review before completion.
---

# Claude Native Project Workflow

Use this skill to run a small project operating system inside the repo. It turns a vague request into a documented task loop, then keeps execution, review, and sync aligned.

## Required Files
For empty repos, create and maintain these files at repo root:

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `specs/TASK-000.md` for startup and brainstorming
- `specs/TASK-001.md` and onward for normal tasks
- `specs/PATCH-TASK.md` for very small fixes

If the repo already has an equivalent structure, map this workflow onto existing docs instead of forcing renames.

## Persistent Project Instructions

On the first meaningful invocation in a repository, create `CLAUDE.md` if it does not already exist so the workflow persists across later Claude Code sessions.

The generated file should be concise and repo-facing. It should capture:
- that this repo defaults to `claude-native-project-workflow`
- when `TASK-000` is required
- the lane model used by this workflow
- required gates: `Brainstorm Review`, `Plan Review`, `Sync Review`
- the rule that work cannot close without `Verify` and `Review`

Do not paste the whole skill into `CLAUDE.md`. Write a compact operating summary instead.
If `CLAUDE.md` already exists, append or refine a workflow section without replacing unrelated project rules.
Never overwrite the entire file unless the user explicitly asks for that.

## When to trigger
Trigger when user intent includes:
- “启动流程 / 继续流程 / 标准化流程”
- “给我一套固定工作流”
- “先别写代码，先定边界”
- “需要人工 gate / review 节点”
- “收口时必须有 verify/review 证据”
- “从0开始初始化仓库流程”

## Workflow
Follow this loop:

1. Read current repo state.
2. Read workflow docs first, then current task card.
3. Run capability gate.
4. If subagents are unavailable, declare `Single-agent serial fallback` and continue.
5. If task is not executable, start brainstorming via `specs/TASK-000.md`.
6. Convert brainstorming output into root docs.
7. Stop at required human gates.
8. Execute task by lane policy.
9. Finish with Verify/Review, then stop at Sync Review before final sync.

### Fixed brainstorming structure (in order)
1. 项目名称 + 目标
2. 现状与背景
3. 用户角色
4. 技术约束
5. Out of Scope
6. Done when

### Turn brainstorming into repo docs
Update:
- `SPEC.md` with six-part structure
- `DECISIONS.md` with key tradeoffs
- `BUILD_PLAN.md` with at least `M1`
- `STATUS.md` with current phase, gate, lane, and notes

Then stop at `Brainstorm Review` and wait for user confirmation.

### Normal task execution (`TASK-001+`)
Always fill:
- `Brainstorm Summary`
- `Lane Decision`
- `Plan Gate`

Lane policy:
- **Fast:** small, low-risk work; `generator -> evaluator`
- **Standard:** multi-step or cross-file work; `planner -> Plan Review -> generator -> evaluator`
- **Strict:** irreversible/high-risk work; `planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

Use Standard only when environment supports it and explicit planning adds value.
Use Strict for migrations, destructive changes, external integration validation, or broad multi-module edits.

### Do not close without review
Every implementation task must end with:
- `Verify`
- `Review`

Then stop at `Sync Review`. After user confirmation, sync milestone docs and/or move to next task.

## Gates
- `Brainstorm Review`: stop after initial docs and framing are ready
- `Plan Review`: stop after planning in Standard/Strict
- `Sync Review`: stop after implementation review and before final sync

## Hard Rules
- Do not code without a task card.
- Do not declare completion without Verify and Review.
- Do not expand into unrelated directories or side quests.
- Update `BUILD_PLAN.md` only for milestone-level changes.
- Prefer the smallest closed loop that still leaves repo reviewable.

## Quick Prompts
- Use `$claude-native-project-workflow` to bootstrap an empty repo from a vague idea.
- Use `$claude-native-project-workflow` to continue the current task and choose lane.
- Use `$claude-native-project-workflow` to review repo state, update STATUS, and prepare next task.

This skill does not require bundled scripts, references, or assets unless the workflow grows more specialized later.

## Standard status output format
Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
