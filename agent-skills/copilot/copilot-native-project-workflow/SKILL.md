---
name: copilot-native-project-workflow
description: Full Copilot-native project workflow. Use when the user wants GitHub Copilot to manage or continue work with `SPEC.md`, `DECISIONS.md`, `BUILD_PLAN.md`, `STATUS.md`, and `specs/TASK-*.md`; when a project starts from a vague idea and needs structured brainstorming; or when the task should follow `Fast`, `Standard`, or `Strict` lanes with explicit human gates.
---

# Copilot Native Project Workflow

## Overview

Use this skill to run a repo-level project workflow inside GitHub Copilot. It turns a vague request into a documented task loop, then keeps execution, review, and sync aligned.

## Required Files

Create or maintain these files at repo root unless the repo already has an equivalent structure:

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `specs/TASK-000.md` for startup and brainstorming
- `specs/TASK-001.md` and onward for normal tasks
- `specs/PATCH-TASK.md` for very small fixes

## Workflow

Follow this loop:

1. Read the current repo state.
Read the workflow files first, then the current task card.

2. Do a capability gate.
Decide whether parallel helpers or subagents are available. If not, declare `Single-agent serial fallback` and continue.

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

## Hard Rules

- Do not code without a task card.
- Do not declare completion without `Verify` and `Review`.
- Do not expand into unrelated directories or side quests.
- Update `BUILD_PLAN.md` only for milestone-level changes.
- Prefer the smallest closed loop that still leaves the repo in a reviewable state.

## Quick Prompts

- Use this skill when the user asks for a full workflow in GitHub Copilot.
- For repo-local reuse, keep the workspace skill at `.github/skills/copilot-native-project-workflow/SKILL.md`.

## Status Output

Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
