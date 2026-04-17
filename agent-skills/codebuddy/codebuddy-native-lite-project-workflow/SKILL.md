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
- Prefer the smallest closed loop.
- Stop at required gates before sync.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task.
```

如果 `CODEBUDDY.md` 已存在，只更新或追加 `## Workflow Defaults` 这一段，而不是覆盖无关内容。
除非用户明确要求，否则不要整体替换现有 `CODEBUDDY.md`。

## Execution Flow（执行流程）

1. 读取当前仓库状态。
2. 如果项目是新的，或范围不清楚，先创建 `specs/TASK-000.md`。
3. 用 `TASK-000` 确认：目标 / 现状 / 角色 / 约束 / Out of Scope / Done when。
4. 否则直接打开或创建一张普通任务卡（`specs/TASK-xxx.md`）。
5. 用一个简短区块确认范围（目标 / In Scope / Out of Scope）。
6. 以最小闭环执行实现。
7. 用 `Verify` 证据和简短 `Review` 说明收口。
8. 在做同步级更新前，先停下等待用户确认。

## Capability Gate（能力门）

- 如果 CodeBuddy 的 Task 工具（子代理）可用，只在它们能降低时间成本或风险时使用。
- 如果子代理不可用，声明 `Single-agent serial fallback`。
- 保持 planner、generator、evaluator、fixer 的职责边界。

## Task Entry（任务入口）

- 如果目标、范围或 Done when 不清楚，先创建 `specs/TASK-000.md`。
- `TASK-000` 使用固定结构：
  1. 项目名称 + 目标
  2. 现状与背景
  3. 用户角色
  4. 技术约束
  5. Out of Scope
  6. Done when
- 更新 `SPEC.md` 和 `STATUS.md`，然后停在 `Brainstorm Review`。

## Gates（硬关卡）

- 如果任务还不可执行，在实现前停在 `Brainstorm Review`。
- 只有任务必须升级出正常 lite 执行范围时，才停在 `Plan Review`。
- 在完成 verification 和 review 之后、同步里程碑文档之前，停在 `Sync Review`。

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

## Status Output（状态报告）

当被问"现在到哪了"时，必须报告以下 6 项：

1. **Current Phase** — 当前阶段
2. **Current Task** — 当前任务
3. **Current Gate** — 当前关卡
4. **Selected Lane** — 选择的车道
5. **Blocking Issue** — 阻塞问题（或 None）
6. **Next Action** — 下一步行动
