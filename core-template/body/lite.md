# {{PLATFORM_NAME}} Native Lite Project Workflow

## Overview

Use this skill to bootstrap a lightweight workflow that can keep running from a minimal file set. The skill is for initialization and re-bootstrap, not for every future session.

## When to Use

- "lightweight workflow / minimal workflow / simplified process"
- "skip the heavy docs, just ship the feature"
- "give me a lean cross-project workflow"
- "bootstrap the repo, then continue from files"

## Repo Files

- `STATUS.md` for the current phase, task, gate, what is allowed now, blockers, and next action. `Lane` is optional helper context only. Use [references/status-template.md](references/status-template.md) as the initial format.
- `specs/TASK-000.md` when the project is new or scope is unclear
- `specs/TASK-001.md` and onward for executable work
- `specs/PATCH-TASK.md` for very small fixes

Optional:

- `SPEC.md` only when scope or boundary is unclear and later sessions need durable context
- `BUILD_PLAN.md` only for milestone-level changes

## Persistent Project Instructions

On the first meaningful invocation in a repository, create `{{CONFIG_FILE}}` if it does not already exist so the lite workflow becomes the repo default for later {{PLATFORM_NAME}} sessions.

Keep `{{CONFIG_FILE}}` minimal. It should contain only durable workflow defaults and should not force heavy reads, broad scans, or generic style rules on every task.

If `{{CONFIG_FILE}}` does not exist, create it with exactly this compact workflow section:

```md
{{CONFIG_HEADER}}

## Workflow Defaults

- Use `specs/TASK-000.md` only when scope or done conditions are unclear.
- In later sessions, read `{{CONFIG_FILE}}`, `STATUS.md`, and the current task card first.
- Read `SPEC.md` only if it exists and the extra context is relevant.
- Read `BUILD_PLAN.md` only if it exists and milestone context is relevant.
- Re-bootstrap workflow guidance only when workflow context is missing or the task needs re-scoping.
- Prefer the smallest closed loop.
- Stop at required gates before sync.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task.
- `create-task` means create the next task card only; `start-implementation` means implementation may begin.
- After any gate is passed, immediately update `STATUS.md`: set Phase, Task (file path), Gate, Allowed Now, and Next action. Set `Lane` only when it adds useful context. Do not declare a gate passed or implementation done before `STATUS.md` reflects the new state.
```

If the file already exists, update or append only the `## Workflow Defaults` section without removing unrelated instructions.
Never overwrite the file unless the user explicitly requests that.

## Continuation Contract

For normal future conversations, do this startup sequence by default:

1. Read `{{CONFIG_FILE}}`.
2. Read `STATUS.md`.
3. Read the current task card.
4. Read `SPEC.md` only if it exists and is relevant.
5. Respect the current gate in `STATUS.md` before taking action.

Re-use this skill only when workflow state is missing, corrupted, or needs to be redefined.

## Execution Flow

Use this skill in a bounded bootstrap loop:

1. Bootstrap session.
Use the skill to initialize the repo, create the minimum workflow files, and complete `TASK-000` until the repo reaches `Brainstorm Review`.

2. Delivery sessions.
In later sessions, prefer reading `{{CONFIG_FILE}}`, `STATUS.md`, and the current task card before doing any work. Do not reload the skill unless workflow context is missing, the task needs re-scoping, or the repo must be re-initialized.

3. If the project is new or the scope is unclear, create `specs/TASK-000.md` first.

4. Use `TASK-000` to produce a real working brief.
Capture enough detail to support implementation choices, not just a project title.
Drive `TASK-000` by targeted follow-up questions. Do not ask the user to rewrite the whole brief when only some fields are missing.

5. Once `TASK-000` is approved, open or create one normal task card (`specs/TASK-xxx.md`) only after explicit task-card approval.
Do not treat user clarification as approval. `create-task` approves creating `TASK-001`. `start-implementation` approves implementation work.

6. After `TASK-001` exists, confirm scope in one short block (`Goal / In Scope / Out of Scope`), set `STATUS.md` to the next gate, and stop.
Do not start implementation until the user explicitly gives implementation approval.

7. Future implementation sessions continue from files, not from the skill.
The normal next conversation should resume from `{{CONFIG_FILE}}`, `STATUS.md`, and the current task card.

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
- Update `STATUS.md` so a new session can continue from files alone, and update `SPEC.md` only when the extra detail materially helps later sessions.
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
- In new delivery sessions, prefer continuing from `{{CONFIG_FILE}}`, `STATUS.md`, and the current task card instead of re-running bootstrap.
- User clarification does not by itself authorize the next gate.
- During `TASK-000`, do not ask for a full replacement brief by default. Ask structured follow-up questions based on the missing fields.
- During `TASK-000`, if the user answer is incomplete or uncertain, continue the follow-up loop instead of moving on.
- Do not pass any gate without the corresponding explicit approval signal: `create-task` approves task creation only; `start-implementation` approves implementation work; explicit sync approval advances past `Sync Review`.
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

- `Use ${{SKILL_LITE}} to bootstrap a repo with minimal process.`
- `Use ${{SKILL_LITE}} to re-bootstrap lite workflow state after the minimal files drifted or went missing.`
- `Continue this task from {{CONFIG_FILE}}, STATUS.md, and the current task card.`
- `Use create-task to approve creating the next task card without starting implementation.`
- `Use start-implementation to approve implementation after the task card is ready.`

## Status Output

Whenever asked "where are we now", report exactly:
1. Current Phase
2. Current Task
3. Current Gate
4. Allowed Now
5. Blocking issue (or None)
6. Next action

If `Selected Lane` exists, treat it as optional helper context rather than the main instruction source.
