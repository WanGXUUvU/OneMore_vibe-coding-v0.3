---
name: claude-native-lite-project-workflow
description: Lite Claude-native project workflow. Use when the user wants a simpler fixed process, minimal docs, quick delivery loop, or a lite version of the Claude-native workflow. Also use when starting a new project that still needs a minimal TASK-000 brainstorming step.
---

# Claude Native Lite Project Workflow

## Overview

Use this skill when Claude Code should keep the workflow lightweight. It is for fast, bounded execution with task cards and review discipline, but without defaulting to a full repo operating system.

## When to Use

- “轻量流程 / 简化流程 / 最小工作流”
- “不要太多文档，先把功能做完”
- “给我一套跨项目通用的简版流程”
- “继续当前任务，但用精简模式”

## Repo Files

- `STATUS.md`
- `specs/TASK-000.md` when the project is new or scope is unclear
- `specs/TASK-001.md` and onward
- `specs/PATCH-TASK.md`

Optional:
- `SPEC.md` only when scope or boundary is unclear
- `BUILD_PLAN.md` only for milestone-level changes

## Persistent Project Instructions

On the first meaningful invocation in a repository, create `CLAUDE.md` if it does not already exist so the lite workflow becomes the default for later Claude Code sessions.

Keep `CLAUDE.md` minimal. It should contain only durable workflow defaults and should not force heavy reads, broad scans, or generic style rules on every task.

If `CLAUDE.md` does not exist, create it with exactly this compact workflow section:

```md
# CLAUDE.md

## Workflow Defaults

Default to `claude-native-lite-project-workflow`.

- Use `specs/TASK-000.md` only when scope or done conditions are unclear.
- Prefer the smallest closed loop.
- Stop at required gates before sync.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task.
```

If `CLAUDE.md` already exists, update or append only the `## Workflow Defaults` section without deleting unrelated guidance.
Never overwrite the full file unless the user explicitly requests that.

## Execution Flow

1. Read current repo state.
2. If the project is new or the scope is unclear, create `specs/TASK-000.md` first.
3. Use `TASK-000` to confirm: 目标 / 现状 / 角色 / 约束 / Out of Scope / Done when.
4. Otherwise open or create one normal task card (`specs/TASK-xxx.md`).
5. Confirm scope in one short block (目标 / In Scope / Out of Scope).
6. Execute implementation in the smallest closed loop.
7. Finish with `Verify` evidence and short `Review` notes.
8. Stop for user confirmation before sync-level updates.

## Capability Gate

- If subagents are available, use them only when they reduce time or risk.
- If subagents are unavailable, declare `Single-agent serial fallback`.
- Keep planner, generator, evaluator, and fixer boundaries intact.

## Task Entry

- If the goal, scope, or Done when is unclear, create `specs/TASK-000.md` first.
- Use this fixed structure for `TASK-000`:
  1. 项目名称 + 目标
  2. 现状与背景
  3. 用户角色
  4. 技术约束
  5. Out of Scope
  6. Done when
- Update `SPEC.md` and `STATUS.md`, then stop at `Brainstorm Review`.

## Gates

- Stop at `Brainstorm Review` before implementation if the task is not yet executable.
- Stop at `Plan Review` only when the task must be escalated beyond normal lite execution.
- Stop at `Sync Review` after verification and review, before syncing milestone docs.

## Lane Policy

- Default to `Fast`.
- Escalate to `Standard` only for clearly multi-step or cross-file work.
- Escalate to `Strict` only for high-risk or irreversible work.
- Do not introduce heavier lanes unless the task actually needs them.

## Rules

- Do not code without a task card.
- Do not expand scope.
- Do not skip verification.
- Do not declare done before `Verify` and `Review`.
- Update `BUILD_PLAN.md` only for milestone-level changes.
- Do not skip `TASK-000` when the project starts from scratch or the goal is still fuzzy.

## Verify Minimum

- Docs or config: static check
- Frontend: page opens, key content exists, no blocking errors
- Backend: build plus minimal runtime assertion

## Review Minimum

- What changed
- How it was verified
- Pass or blocked status
- Remaining risk

## Quick Prompts

- Use `$claude-native-lite-project-workflow` to bootstrap a repo with minimal process.
- Use `$claude-native-lite-project-workflow` to continue current task in lite mode.
- Use `$claude-native-lite-project-workflow` to report status and next action.

## Status Output

Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
