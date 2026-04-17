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
```

If `CLAUDE.md` already exists, update or append only the `## Workflow Defaults` section without replacing unrelated project rules.
Never overwrite the entire file unless the user explicitly asks for that.

## Execution Flow

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

### Do not close without review
Every implementation task must end with:
- `Verify`
- `Review`

Then stop at `Sync Review`. After user confirmation, sync milestone docs and/or move to next task.

## Gates
- `Brainstorm Review`: stop after initial docs and framing are ready
- `Plan Review`: stop after planning in Standard/Strict
- `Sync Review`: stop after implementation review and before final sync

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

## Quick Prompts
- Use `$claude-native-project-workflow` to bootstrap an empty repo from a vague idea.
- Use `$claude-native-project-workflow` to continue the current task and choose lane.
- Use `$claude-native-project-workflow` to review repo state, update STATUS, and prepare next task.

This skill does not require bundled scripts, references, or assets unless the workflow grows more specialized later.

## Status Output
Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
