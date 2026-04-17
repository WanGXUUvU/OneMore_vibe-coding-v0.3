---
name: codex-native-lite-project-workflow
description: Lite Codex-native project workflow. Use when the user wants a simpler fixed process, minimal docs, quick delivery loop, or a lightweight Codex workflow with the same task-card and gate structure.
---

# Codex Native Lite Project Workflow

## Overview

Use this skill when Codex should keep the workflow lightweight. It is for fast, bounded execution with task cards and review discipline, but without defaulting to a full repo operating system.

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

On the first meaningful invocation in a repository, create `AGENTS.md` if it does not already exist so the lite workflow becomes the repo default for later sessions.

Keep `AGENTS.md` minimal. It should contain only durable workflow defaults and should not force heavy reads, broad scans, or generic style rules on every task.

If `AGENTS.md` does not exist, create it with exactly this compact workflow section:

```md
# AGENTS.md

## Workflow Defaults

Default to the lite workflow for this repository.

- Use `specs/TASK-000.md` only when scope or done conditions are unclear.
- In later sessions, read `AGENTS.md`, `STATUS.md`, and the current task card first.
- Re-bootstrap workflow guidance only when workflow context is missing or the task needs re-scoping.
- Prefer the smallest closed loop.
- Stop at required gates before sync.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task.
- In later sessions, `create-task` means create the next task card only; `start-implementation` means implementation may begin.
```

If `AGENTS.md` already exists, update or append only the `## Workflow Defaults` section without removing unrelated instructions.
Never overwrite an existing instruction file unless the user explicitly requests replacement.

## Execution Flow

Use this skill in two phases:

1. Bootstrap session.
Use the skill to initialize the repo, create the minimum workflow files, and complete `TASK-000` until the repo reaches `Brainstorm Review`.

2. Delivery sessions.
In later sessions, prefer reading `AGENTS.md`, `STATUS.md`, and the current task card before doing any work. Do not reload the skill unless workflow context is missing, the task needs re-scoping, or the repo must be re-initialized.

3. If the project is new or the scope is unclear, create `specs/TASK-000.md` first.

4. Use `TASK-000` to produce a real working brief.
Capture enough detail to support implementation choices, not just a project title.
Drive `TASK-000` by targeted follow-up questions. Do not ask the user to rewrite the whole brief when only some fields are missing.

5. Once `TASK-000` is approved, open or create one normal task card (`specs/TASK-xxx.md`) only after explicit task-card approval.
Do not treat user clarification as approval. `create-task` approves creating `TASK-001`. `start-implementation` approves implementation work.

6. After `TASK-001` exists, confirm scope in one short block (`Goal / In Scope / Out of Scope`) and stop at `Implementation Approval`.
Do not start implementation until the user explicitly gives implementation approval.

7. Implement the smallest closed loop that satisfies the current task card.
Do not expand scope or silently bundle nearby improvements.

8. Finish with `Verify` evidence and short `Review` notes.

9. Stop for user confirmation at `Sync Review`.
At `Sync Review`, the next move must be explicit:
- close the current task as accepted
- keep working inside the current task
- or create the next task card
Do not treat review comments or clarifying follow-ups as sync approval.

## Capability Gate

- If subagents are available, use them only when they reduce time or risk.
- If subagents are unavailable, declare `Single-agent serial fallback`.
- Keep planner, generator, evaluator, and fixer boundaries intact.

## Task Entry

- If the goal, scope, or Done when is unclear, create `specs/TASK-000.md` first.
- Use this fixed structure for `TASK-000`:
  1. 项目名称 + 目标
  2. 用户角色与使用场景
  3. 核心页面 / 核心流程
  4. 首版范围（In Scope）
  5. 明确不做（Out of Scope）
  6. 技术方向与关键依赖
  7. 风险 / 待确认问题
  8. Done when
- `TASK-000` must be detailed enough to answer:
  - what the user will actually do first
  - what the MVP includes and excludes
  - what technical direction is currently assumed
  - what decisions are still open
- When `TASK-000` is incomplete, list the missing fields and ask focused follow-up questions for those fields.
- Prefer 1 to 5 short questions per round. Ask only for information that is still missing or uncertain.
- If the user gives a partial answer, update `TASK-000`, then continue asking only about the remaining gaps.
- Keep asking until the task can enter `Brainstorm Review` without guessing core scope, stack, or done conditions.
- Update `STATUS.md`, and update `SPEC.md` only when the extra detail materially helps later sessions.
- Stop at `Brainstorm Review` once the repo has enough information to create `TASK-001` without guessing core scope or stack.

## Gates

- Stop at `Brainstorm Review` before implementation if the task is not yet executable.
- Stop at `Implementation Approval` after the task card is ready and before writing code.
- Stop at `Plan Review` only when the task must be escalated beyond normal lite execution.
- Stop at `Sync Review` after verification and review, before syncing milestone docs.

User clarification at a gate is not the same as gate approval.
- `create-task` passes the current gate only far enough to create or update the next task card.
- `start-implementation` passes the current gate for implementation work.
- Do not treat `proceed` as implementation approval.

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
- In new delivery sessions, prefer continuing from `AGENTS.md`, `STATUS.md`, and the current task card instead of re-running bootstrap.
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

- Use `$codex-native-lite-project-workflow` to bootstrap a repo with minimal process.
- Use `$codex-native-lite-project-workflow` to continue current task in lite mode.
- Use `$codex-native-lite-project-workflow` to report status and next action.
- Use `create-task` to approve creating the next task card without starting implementation.
- Use `start-implementation` to approve implementation after the task card is ready.

## Status Output

Whenever asked “where are we now”, report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue (or None)
6. Next action
