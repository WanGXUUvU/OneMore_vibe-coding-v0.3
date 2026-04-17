---
name: claude-native-project-workflow
description: Full Claude-native project workflow. Use this skill whenever the user asks to bootstrap an empty repo, continue task execution, choose Fast/Standard/Strict lane, pass Brainstorm/Plan/Sync human gates, or enforce Verify+Review before completion.
---

# Claude Native Project Workflow

## Overview

Use this skill when Claude Code should run a full repo operating system. It turns a vague request into explicit project docs, task cards, lane selection, and gated execution.

## When to Use

- The request starts from a vague idea or incomplete scope.
- The repo needs durable project docs, not just a one-off task loop.
- The work spans multiple files, modules, or milestones.
- The task needs explicit planning, human gates, or risk control.

## Repo Files

Create or maintain these files at repo root:

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

Keep `CLAUDE.md` minimal. It is a persistent memory file, not a second copy of the skill. Do not add generic coding advice, style slogans, or instructions that trigger expensive work on every task.

If `CLAUDE.md` does not exist, create it with exactly this compact workflow section:

```md
# CLAUDE.md

## Workflow Defaults

Default to `claude-native-project-workflow`.

- Use `specs/TASK-000.md` when the task is not yet executable.
- Use the smallest valid lane: `Fast`, `Standard`, or `Strict`.
- Stop at required gates: `Brainstorm Review`, `Plan Review`, `Sync Review`.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task card.
- `create-task` means create the next task card only; `start-implementation` means implementation may begin.
```

If `CLAUDE.md` already exists, update or append only the `## Workflow Defaults` section without replacing unrelated project rules.
Never overwrite the entire file unless the user explicitly asks for that.

## Execution Flow

Follow this loop:

1. Read the current repo state.
Read the workflow files first, then the current task card.

2. Do a capability gate.
Decide whether subagents are available. If not, declare `Single-agent serial fallback` and continue.

3. Start with brainstorming when the task is not yet executable.
Use `specs/TASK-000.md` when the project starts from a vague idea, when root docs are missing, or when the current task lacks a clear goal, scope, or done conditions.

4. Use the fixed brainstorming structure.
Capture these six items in order:
- `项目名称 + 目标`
- `现状与背景`
- `用户角色`
- `技术约束`
- `Out of Scope`
- `Done when`
Drive `TASK-000` by targeted follow-up questions. Do not ask the user to replace the whole brief when only some decisions are missing.

5. Turn brainstorming into repo docs.
Update:
- `SPEC.md` with the six-part structure
- `DECISIONS.md` with the first important tradeoffs
- `BUILD_PLAN.md` with at least `M1`
- `STATUS.md` with the current phase, gate, lane, and notes

6. Stop at `Brainstorm Review`.
After `TASK-000` is good enough to produce a real implementation task, stop and wait for explicit user confirmation before continuing. Clarifying input does not by itself authorize `TASK-001`. `create-task` approves creating `TASK-001`. `start-implementation` approves implementation work.

7. Run normal task execution.
For `TASK-001+`, always fill:
- `Brainstorm Summary`
- `Lane Decision`
- `Plan Gate`

8. Choose the lane.
- `Fast`: small, low-risk work; `generator -> evaluator`
- `Standard`: multi-step or cross-file work; `planner -> Plan Review -> generator -> evaluator`
- `Strict`: irreversible or high-risk work; `planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

Use `Standard` only when the environment supports it and the task needs an explicit plan. Use `Strict` for migrations, destructive changes, external integration verification, or broad multi-module edits.

9. After the task card and lane decision are ready, stop at `Implementation Approval`.
Do not start implementation until the user explicitly approves execution. For `Standard` and `Strict`, this approval comes after `Plan Review`.

10. Do not close without review.
Every implementation task must end with:
- `Verify`
- `Review`

11. Stop at `Sync Review`, then sync.
After presenting results, wait for explicit user confirmation before updating milestone documents or moving to the next task.
At `Sync Review`, the next move must be explicit:
- close the current task as accepted
- keep working inside the current task
- or create the next task card

## Gates
- `Brainstorm Review`: stop after initial docs and framing are ready
- `Implementation Approval`: stop after the task card is ready and before writing code
- `Plan Review`: stop after planning in Standard/Strict
- `Sync Review`: stop after implementation review and before final sync

User clarification at a gate is not the same as gate approval.
- `create-task` passes the current gate only far enough to create or update the next task card.
- `start-implementation` passes the current gate for implementation work.
- Do not treat `proceed` as implementation approval.

## Lane Policy

- `Fast`: small, low-risk work; `generator -> evaluator`
- `Standard`: multi-step or cross-file work; `planner -> Plan Review -> generator -> evaluator`
- `Strict`: irreversible/high-risk work; `planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

Use Standard only when environment supports it and explicit planning adds value.
Use Strict for migrations, destructive changes, external integration validation, or broad multi-module edits.

## Hard Rules
- Do not code without a task card.
- Do not declare completion without Verify and Review.
- Do not expand into unrelated directories or side quests.
- Update `BUILD_PLAN.md` only for milestone-level changes.
- Prefer the smallest closed loop that still leaves repo reviewable.
- User clarification does not by itself authorize the next gate.
- During `TASK-000`, do not ask for a full replacement brief by default. Ask structured follow-up questions based on the missing fields.
- During `TASK-000`, if the user answer is incomplete or uncertain, continue the follow-up loop instead of moving on.
- After `Brainstorm Review`, do not create `TASK-001` without `create-task` or equivalent explicit task-card approval.
- After `TASK-001` is created, move to `Implementation Approval` and wait there until implementation is explicitly approved.
- After `Brainstorm Review`, do not edit implementation files or start execution without `start-implementation` or equivalent explicit implementation approval.
- After `Implementation Approval`, do not start implementation without `start-implementation` or equivalent explicit implementation approval.
- After `Plan Review`, do not start implementation without `start-implementation` or equivalent explicit implementation approval.
- After `Sync Review`, do not sync milestone docs or advance to the next task without explicit sync approval.
- After `Sync Review`, the allowed next moves are: accept the task, continue the same task, or create the next task card.
- Treat `proceed` as ambiguous. Ask whether the user wants `create-task` or `start-implementation`.

## Quick Prompts
- Use `$claude-native-project-workflow` to bootstrap an empty repo from a vague idea.
- Use `$claude-native-project-workflow` to continue the current task and choose lane.
- Use `$claude-native-project-workflow` to review repo state, update STATUS, and prepare next task.
- Use `create-task` to approve creating the next task card without starting implementation.
- Use `start-implementation` to approve implementation after the task card and plan are ready.

This skill does not require bundled scripts, references, or assets unless the workflow grows more specialized later.

## Status Output
Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
