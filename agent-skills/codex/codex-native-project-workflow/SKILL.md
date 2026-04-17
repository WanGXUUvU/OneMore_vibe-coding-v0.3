---
name: codex-native-project-workflow
description: Full Codex-native project workflow. Use when Codex should manage or continue work with `SPEC.md`, `DECISIONS.md`, `BUILD_PLAN.md`, `STATUS.md`, and `specs/TASK-*.md`; when a project starts from a vague idea and needs structured brainstorming; or when the task should follow `Fast`, `Standard`, or `Strict` lanes with explicit human gates.
---

# Codex Native Project Workflow

## Overview

Use this skill when Codex should run a full repo operating system. It turns a vague request into explicit project docs, task cards, lane selection, and gated execution.

## When to Use

- The request starts from a vague idea or incomplete scope.
- The repo needs durable project docs, not just a one-off task loop.
- The work spans multiple files, modules, or milestones.
- The task needs explicit planning, human gates, or risk control.

## Repo Files

Create or maintain these files at repo root unless the user already has an equivalent structure:

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `specs/TASK-000.md` for startup and brainstorming
- `specs/TASK-001.md` and onward for normal tasks
- `specs/PATCH-TASK.md` for very small fixes

## Persistent Project Instructions

On the first meaningful invocation in a repository, create `AGENTS.md` if it does not already exist so the workflow persists for later sessions.

Keep `AGENTS.md` minimal. It is a persistent memory file, not a second copy of the skill. Do not add generic coding advice, style slogans, or instructions that trigger expensive work on every task.

If `AGENTS.md` does not exist, create it with exactly this compact workflow section:

```md
# AGENTS.md

## Workflow Defaults

Default to `codex-native-project-workflow`.

- Use `specs/TASK-000.md` when the task is not yet executable.
- Use the smallest valid lane: `Fast`, `Standard`, or `Strict`.
- Stop at required gates: `Brainstorm Review`, `Plan Review`, `Sync Review`.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task card.
```

If `AGENTS.md` already exists, update or append only the `## Workflow Defaults` section without overwriting unrelated project guidance.
Never replace an existing instruction file wholesale unless the user explicitly asks for that.

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

5. Turn brainstorming into repo docs.
Update:
- `SPEC.md` with the six-part structure
- `DECISIONS.md` with the first important tradeoffs
- `BUILD_PLAN.md` with at least `M1`
- `STATUS.md` with the current phase, gate, lane, and notes

6. Stop at `Brainstorm Review`.
After `TASK-000` is good enough to produce a real implementation task, stop and wait for the user before continuing.

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

9. Do not close without review.
Every implementation task must end with:
- `Verify`
- `Review`

10. Stop at `Sync Review`, then sync.
After presenting results, wait for the user before updating milestone documents or moving to the next task.

## Gates

- `Brainstorm Review`: stop after initial docs and task framing are ready
- `Plan Review`: stop after planning in `Standard` or `Strict`
- `Sync Review`: stop after implementation review and before final sync

## Lane Policy

- `Fast`: small, low-risk work; `generator -> evaluator`
- `Standard`: multi-step or cross-file work; `planner -> Plan Review -> generator -> evaluator`
- `Strict`: irreversible or high-risk work; `planner -> Plan Review -> generator -> evaluator -> fixer -> evaluator`

## Hard Rules

- Do not code without a task card.
- Do not declare completion without `Verify` and `Review`.
- Do not expand into unrelated directories or side quests.
- Update `BUILD_PLAN.md` only for milestone-level changes.
- Prefer the smallest closed loop that still leaves the repo in a reviewable state.

## Quick Prompts

- `Use $codex-native-project-workflow to bootstrap this repo from a vague product idea.`
- `Use $codex-native-project-workflow to continue the current task and choose the right lane.`
- `Use $codex-native-project-workflow to review the repo state, update STATUS, and prepare the next task.`

## Status Output

Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action

This skill does not require bundled scripts, references, or assets unless the workflow grows more specialized later.
