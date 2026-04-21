# {{PLATFORM_NAME}} Native Project Workflow

## Overview

Use this skill to bootstrap a durable project operating model. The skill is for initialization and re-bootstrap, not for every later session. After bootstrap, future conversations should continue from the repo files rather than by re-calling the skill.

## When to Use

- The request starts from a vague idea or incomplete scope.
- The repo needs durable project docs, not just a one-off task loop.
- The work spans multiple files, modules, or milestones.
- The task needs explicit planning, human gates, or risk control.

## Repo Files

Create or maintain these files at repo root unless the repo already has an equivalent structure:

- `SPEC.md` for durable problem framing and scope
- `DECISIONS.md` for major decisions and rationale
- `BUILD_PLAN.md` for milestone-level planning only
- `STATUS.md` for canonical current project state, gate, and next action. Use [references/status-template.md](references/status-template.md) as the initial format.
- `specs/TASK-000.md` for bootstrap brainstorming
- `specs/TASK-001.md` and onward for executable work
- `specs/PATCH-TASK.md` for very small fixes

## Persistent Project Instructions

On the first meaningful invocation in a repository, create `{{CONFIG_FILE}}` if it does not already exist so the continuation rules persist for later {{PLATFORM_NAME}} sessions.

Keep `{{CONFIG_FILE}}` minimal. It is a persistent memory file, not a second copy of the skill. Do not add generic coding advice, style slogans, or instructions that trigger expensive work on every task.

If `{{CONFIG_FILE}}` does not exist, create it with exactly this compact workflow section:

```md
{{CONFIG_HEADER}}

## Workflow Defaults

- This workflow is bootstrap-first. Use the skill for initialization or re-bootstrap, then continue later sessions from repo files.
- In later sessions, read `{{CONFIG_FILE}}`, `STATUS.md`, and the current task card first.
- Read `SPEC.md`, `DECISIONS.md`, and `BUILD_PLAN.md` when planning or scope decisions depend on them.
- Use `specs/TASK-000.md` when the task is not yet executable or the workflow state must be rebuilt.
- Use the smallest valid lane: `Fast`, `Standard`, or `Strict`.
- Stop at required gates: `Brainstorm Review`, `Plan Review`, `Implementation Approval`, `Sync Review`.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task card.
- `create-task` means create the next task card only; `start-implementation` means implementation may begin.
- After any gate is passed, immediately update `STATUS.md`: set Phase, Task (file path), Gate, Lane, and Next action. Do not declare a gate passed or implementation done before `STATUS.md` reflects the new state.
```

If `{{CONFIG_FILE}}` already exists, update or append only the `## Workflow Defaults` section without replacing unrelated repository instructions.
Never overwrite the entire instruction file unless the user explicitly asks for replacement.

When the full workflow bootstraps a new repo, seed `DECISIONS.md` and `BUILD_PLAN.md` before creating `TASK-001`.
Use [references/decisions-template.md](references/decisions-template.md) for the initial `DECISIONS.md`.
Use [references/build-plan-template.md](references/build-plan-template.md) for the initial `BUILD_PLAN.md`.

## Continuation Contract

For normal future conversations, do this startup sequence by default:

1. Read `{{CONFIG_FILE}}`.
2. Read `STATUS.md`.
3. Read the current task card.
4. Read `SPEC.md`, `DECISIONS.md`, and `BUILD_PLAN.md` only when planning, scope, or milestone decisions depend on them.
5. Respect the current gate in `STATUS.md` before taking action.

Re-use this skill only when workflow state is missing, corrupted, or needs to be redefined.

## Execution Flow

Use this skill for a bounded bootstrap loop:

1. Read the current repo state.
Read the workflow files first, then the current task card.

2. Start with brainstorming when the task is not yet executable.
Use `specs/TASK-000.md` when the project starts from a vague idea, when root docs are missing, or when the current task lacks a clear goal, scope, or done conditions.

3. Use the fixed brainstorming structure.
Capture these six items in order:
- `项目名称 + 目标`
- `现状与背景`
- `用户角色`
- `技术约束`
- `Out of Scope`
- `Done when`
Drive `TASK-000` by targeted follow-up questions. Do not ask the user to replace the whole brief when only some decisions are missing.

4. Turn brainstorming into durable repo docs.
Update:
- `SPEC.md` with the six-part structure
- `DECISIONS.md` with the first important tradeoffs, using the template above
- `BUILD_PLAN.md` with at least `M1`, using the template above
- `STATUS.md` with the current phase, gate, lane, and notes

5. Stop at `Brainstorm Review`.
After `TASK-000` is good enough to produce a real implementation task, stop and wait for explicit user confirmation before continuing. Clarifying input does not by itself authorize `TASK-001`. `create-task` approves creating `TASK-001`. `start-implementation` approves implementation work.

6. Create the first executable task card.
For `TASK-001+`, always fill:
- `Brainstorm Summary`
- `Lane Decision`
- `Plan Gate`

7. Choose the lane.
- `Fast`: small, low-risk work; `generator -> evaluator`
- `Standard`: multi-step or cross-file work; `planner -> Plan Review -> generator -> evaluator`
- `Strict`: irreversible or high-risk work; `planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

Use `Standard` only when the environment supports it and the task needs an explicit plan. Use `Strict` for migrations, destructive changes, external integration verification, or broad multi-module edits.

8. After `TASK-001` and the lane decision are ready, set `STATUS.md` to the next gate and stop.
Do not start implementation until the user explicitly approves execution. For `Standard` and `Strict`, this approval comes after `Plan Review`.

9. Future implementation sessions continue from files, not from the skill.
The normal next conversation should resume from `{{CONFIG_FILE}}`, `STATUS.md`, and the current task card.

## Gates

- `Brainstorm Review`: stop after initial docs and task framing are ready
- `Implementation Approval`: stop after the task card is ready and before writing code
- `Plan Review`: stop after planning in `Standard` or `Strict`
- `Sync Review`: stop after implementation review and before final sync

User clarification at a gate is not the same as gate approval.
- `create-task` passes the current gate only far enough to create or update the next task card.
- `start-implementation` passes the current gate for implementation work.
- Do not treat `proceed` as implementation approval.

## Hard Rules

- Do not code without a task card.
- Do not declare completion without `Verify` and `Review`.
- Do not expand into unrelated directories or side quests.
- Update `BUILD_PLAN.md` only for milestone-level changes.
- Prefer the smallest closed loop that still leaves the repo in a reviewable state.
- User clarification does not by itself authorize the next gate.
- During `TASK-000`, do not ask for a full replacement brief by default. Ask structured follow-up questions based on the missing fields.
- During `TASK-000`, if the user answer is incomplete or uncertain, continue the follow-up loop instead of moving on.
- Do not pass any gate without the corresponding explicit approval signal: `create-task` approves task creation only; `start-implementation` approves implementation work; explicit sync approval advances past `Sync Review`.
- After `Sync Review`, the allowed next moves are: accept the task, continue the same task, or create the next task card.
- Treat `proceed` as ambiguous. Ask whether the user wants `create-task` or `start-implementation`.

## Quick Prompts

- `Use ${{SKILL_FULL}} to bootstrap this repo from a vague product idea.`
- `Use ${{SKILL_FULL}} to re-bootstrap workflow state after the repo docs drifted or went missing.`
- `Continue this project from {{CONFIG_FILE}}, STATUS.md, and the current task card.`
- `Use create-task to approve creating the next task card without starting implementation.`
- `Use start-implementation to approve implementation after the task card and plan are ready.`

## Status Output

Whenever asked "where are we now", report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
