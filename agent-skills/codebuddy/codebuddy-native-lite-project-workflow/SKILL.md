---
name: "codebuddy-native-lite-project-workflow"
description: "触发场景：CodeBuddy 原生轻量项目工作流、简化流程、最小工作流、快速交付循环；触发词：轻量流程、简化流程、最小工作流、快速交付、精简模式、lite模式、TASK-000、头脑风暴、项目启动、继续任务；使用 CodeBuddy 原生轻量工作流管理仓库时必须触发"
description_zh: "CodeBuddy 原生轻量项目工作流，带硬关卡的精简交付流程"
description_en: "Lite CodeBuddy-native project workflow with hard gates for minimal delivery"
category: "项目工作流"
version: "1.0.0"
author: "codebuddy"
enabled: true
allowed-tools: Read,Write,Bash,Grep
---

# CodeBuddy Native Lite Project Workflow（CodeBuddy 原生轻量项目工作流）

## Overview（技能用途）

本技能为 CodeBuddy 的轻量项目工作流，用最少的文件和步骤完成交付，在保留任务卡和硬关卡的前提下，避免默认进入完整的仓库操作系统模式。

## When to Use（触发规则）

1. 用户提到"轻量流程 / 简化流程 / 最小工作流"时触发
2. 用户说"不要太多文档，先把功能做完"时触发
3. 用户说"给我一套跨项目通用的简版流程"时触发
4. 用户说"继续当前任务，但用精简模式"时触发
5. 新项目启动，需要最小 TASK-000 头脑风暴步骤时触发
6. 关键词匹配：轻量流程、简化流程、最小工作流、快速交付、精简模式、lite模式、TASK-000

## Repo Files（仓库文件）

- `STATUS.md`
- `specs/TASK-000.md` 在项目全新或范围不清时使用
- `specs/TASK-001.md` 及后续任务卡
- `specs/PATCH-TASK.md`

## Persistent Project Instructions（持久化项目约束）

在仓库内第一次有意义地调用本技能时，如果 `CODEBUDDY.md` 不存在，就应主动创建它，让这套 lite workflow 在后续会话中作为默认方式持续生效。

保持 `CODEBUDDY.md` 极简。它只应包含可长期保留的 workflow 默认值，不应强制每个任务都做重读文档、全仓扫描或套用泛化风格规则。

如果 `CODEBUDDY.md` 不存在，就按下面这段精简 workflow 区块创建：

```md
# CODEBUDDY.md

## Workflow Defaults

Default to `codebuddy-native-lite-project-workflow`.

- Use `specs/TASK-000.md` only when scope or done conditions are unclear.
- In later sessions, read `CODEBUDDY.md`, `STATUS.md`, and the current task card first.
- Reload the full workflow skill only when workflow context is missing or the task needs re-scoping.
- Prefer the smallest closed loop.
- Stop at required gates before sync.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task.
- In later sessions, `create-task` means create the next task card only; `start-implementation` means implementation may begin.
```

如果 `CODEBUDDY.md` 已存在，只更新或追加 `## Workflow Defaults` 这一段，而不是覆盖无关内容。
除非用户明确要求，否则不要整体替换现有 `CODEBUDDY.md`。

## Execution Flow（执行流程）

按两阶段运行：

1. Bootstrap session。
用本技能初始化仓库、创建最小工作流文件，并完成 `TASK-000`，直到仓库进入 `Brainstorm Review`。

2. Delivery sessions。
后续会话优先读取 `CODEBUDDY.md`、`STATUS.md` 和当前任务卡，再决定行动。除非 workflow 上下文缺失、任务需要重新界定范围，或仓库需要重新初始化，否则不要重新加载技能。

3. 如果项目是新的，或范围不清楚，先创建 `specs/TASK-000.md`。

4. 用 `TASK-000` 产出真正可工作的 brief。
收集足够支持实现决策的信息，而不只是项目标题。
用缺口驱动的追问方式推进 `TASK-000`。当只缺少部分信息时，不要要求用户整段重写 brief。

5. `TASK-000` 被批准后，只能在得到明确建卡批准后，创建普通任务卡（`specs/TASK-xxx.md`）。
不要把澄清性输入当成批准。`create-task` 代表允许创建 `TASK-001`。`start-implementation` 代表允许开始实现。

6. `TASK-001` 创建后，用一个简短区块确认范围（`Goal / In Scope / Out of Scope`），并停在 `Implementation Approval`。
在用户明确给出实现批准前，不得开始实现。

7. 以满足当前任务卡的最小闭环执行实现。
不要扩范围，也不要顺手捆绑附近的小改动。

8. 用 `Verify` 证据和简短 `Review` 说明收口。

9. 在 `Sync Review` 等待用户确认。
在 `Sync Review`，下一步必须明确为以下三选一：
- 接受当前任务
- 继续当前任务
- 创建下一张任务卡
不要把评审意见或澄清性追问视为 sync approval。

## Capability Gate（能力门）

- 如果 CodeBuddy 的 Task 工具（子代理）可用，只在它们能降低时间成本或风险时使用。
- 如果子代理不可用，声明 `Single-agent serial fallback`。
- 保持 planner、generator、evaluator、fixer 的职责边界。

## Task Entry（任务入口）

- 如果目标、范围或 Done when 不清楚，先创建 `specs/TASK-000.md`。
- `TASK-000` 使用固定结构：
  1. 项目名称 + 目标
  2. 用户角色与使用场景
  3. 核心页面 / 核心流程
  4. 首版范围（In Scope）
  5. 明确不做（Out of Scope）
  6. 技术方向与关键依赖
  7. 风险 / 待确认问题
  8. Done when
- `TASK-000` 至少要足以回答：
  - 用户第一步实际会做什么
  - MVP 包含什么、不包含什么
  - 当前默认技术方向是什么
  - 还有哪些关键决策未定
- 当 `TASK-000` 还不完整时，列出缺失字段，并只针对这些字段发出追问。
- 每轮优先只问 1 到 5 个短问题，只问仍然缺失或不确定的信息。
- 如果用户只回答一部分，就先更新 `TASK-000`，再继续追问剩余缺口。
- 只要核心范围、技术方向或完成标准还需要猜测，就继续追问，不进入下一步。
- 更新 `STATUS.md`；只有当额外细节对后续会话确有帮助时，才更新 `SPEC.md`。
- 当仓库已有足够信息在不猜测核心范围或技术栈的情况下创建 `TASK-001` 时，停在 `Brainstorm Review`。

## Gates（硬关卡）

- 如果任务还不可执行，在实现前停在 `Brainstorm Review`。
- 在任务卡准备好后、写代码前，停在 `Implementation Approval`。
- 只有任务必须升级出正常 lite 执行范围时，才停在 `Plan Review`。
- 在完成 verification 和 review 之后、同步里程碑文档之前，停在 `Sync Review`。

补充规则：
- 关卡中的澄清输入不等于关卡批准
- `create-task` 只允许通过当前关卡去创建或更新下一张任务卡
- `start-implementation` 才允许实现工作开始
- 不要把 `proceed` 当成实现批准

## Lane Policy（车道策略）

- 默认使用 `Fast`。
- 只有明确属于多步骤或跨文件工作时，才升级到 `Standard`。
- 只有高风险或不可逆工作时，才升级到 `Strict`。
- 如果任务本身不需要，不要主动引入更重的 lane。

## Rules（硬规则）

- 没有任务卡就不要开始编码。
- 不要扩范围。
- 不要跳过 verification。
- 在 `Verify` 和 `Review` 之前不要宣告完成。
- 只有里程碑级变化才更新 `BUILD_PLAN.md`。
- 当项目从零开始或目标仍然模糊时，不要跳过 `TASK-000`。
- 在新的 delivery session 中，优先从 `CODEBUDDY.md`、`STATUS.md` 和当前任务卡继续，而不是重新跑 bootstrap。
- 用户补充信息本身，不得自动视为通过下一关。
- 在 `TASK-000` 期间，不要默认要求用户重写完整 brief，应只追问缺失字段。
- 在 `TASK-000` 期间，如果用户回答仍不完整或不确定，应继续追问，而不是直接前进。
- `Brainstorm Review` 之后，没有 `create-task` 或等价明确批准，不得创建 `TASK-001`。
- 创建 `TASK-001` 后，必须先进入 `Implementation Approval`，等待明确开工批准。
- `Brainstorm Review` 之后，没有 `start-implementation` 或等价明确批准，不得编辑实现文件或开始执行。
- `Implementation Approval` 之后，没有 `start-implementation` 或等价明确批准，不得开始实现。
- `Plan Review` 之后，没有 `start-implementation` 或等价明确批准，不得开始实现。
- `Sync Review` 之后，没有明确 sync approval，不得同步里程碑文档或进入下一任务。
- `Sync Review` 之后，只允许：接受当前任务、继续当前任务、或创建下一张任务卡。
- 将 `proceed` 视为模糊词，并追问用户是要 `create-task` 还是 `start-implementation`。

## Verify Minimum（最低验证要求）

- 文档或配置：静态检查
- 前端：页面可打开，关键内容存在，没有阻塞性错误
- 后端：构建通过，并做最小运行断言

## Review Minimum（最低评审要求）

- 改了什么
- 如何验证
- 通过还是阻塞
- 剩余风险

## Quick Prompts（快捷指令）

- 使用 `$codebuddy-native-lite-project-workflow` 以精简模式引导仓库
- 使用 `$codebuddy-native-lite-project-workflow` 继续当前精简模式任务
- 使用 `$codebuddy-native-lite-project-workflow` 报告项目状态和下一步行动
- 使用 `create-task` 允许创建下一张任务卡但不立即开始实现
- 使用 `start-implementation` 在任务卡准备好后批准开始实现

## Status Output（状态报告）

当被问"现在到哪了"时，必须报告以下 6 项：

1. **Current Phase** — 当前阶段
2. **Current Task** — 当前任务
3. **Current Gate** — 当前关卡
4. **Selected Lane** — 选择的车道
5. **Blocking Issue** — 阻塞问题（或 None）
6. **Next Action** — 下一步行动
