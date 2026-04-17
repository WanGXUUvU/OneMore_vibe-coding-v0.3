---
name: "codebuddy-native-project-workflow"
description: "触发场景：CodeBuddy 原生完整项目工作流、标准化流程、完整交付闭环、Brainstorm/Plan/Sync 人工关卡；触发词：启动流程、继续流程、标准化流程、完整工作流、TASK-000、TASK-001、Brainstorm Review、Plan Review、Sync Review、Verify、Review；使用 CodeBuddy 原生完整工作流管理仓库时必须触发"
description_zh: "CodeBuddy 原生完整项目工作流，带文档骨架、车道选择和硬关卡的完整交付流程"
description_en: "Full CodeBuddy-native project workflow with docs, lanes, and hard gates"
category: "项目工作流"
version: "1.0.0"
author: "codebuddy"
enabled: true
allowed-tools: Read,Write,Bash,Grep
---

# CodeBuddy Native Project Workflow（CodeBuddy 原生完整项目工作流）

## Overview（技能用途）

本技能为 CodeBuddy 的完整项目工作流，用明确的文档骨架、任务卡、车道和人工关卡，把模糊需求推进为可执行、可验证、可同步的最小闭环。

## When to Use（触发规则）

1. 用户提到"启动流程 / 继续流程 / 标准化流程"时触发
2. 用户说"给我一套完整工作流"时触发
3. 用户说"先别写代码，先定边界"时触发
4. 用户说"需要人工 gate / review 节点"时触发
5. 用户说"收口时必须有 verify/review 证据"时触发
6. 关键词匹配：完整工作流、标准化流程、TASK-000、TASK-001、Brainstorm Review、Plan Review、Sync Review

## Repo Files（仓库文件）

除非仓库已有等价结构，否则在仓库根目录维护以下文件：

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `specs/TASK-000.md` 用于启动和头脑风暴
- `specs/TASK-001.md` 及后续任务卡
- `specs/PATCH-TASK.md` 用于小修补

## Persistent Project Instructions（持久化项目约束）

在仓库内第一次有意义地调用本技能时，如果 `CODEBUDDY.md` 不存在，就应主动创建它，让这套 workflow 在后续会话中持续生效。

保持 `CODEBUDDY.md` 极简。它是持久化记忆文件，不是 skill 的第二份副本。不要写通用编码建议、风格口号，或任何会在每个任务里触发高成本操作的指令。

如果 `CODEBUDDY.md` 不存在，就按下面这段精简 workflow 区块创建：

```md
# CODEBUDDY.md

## Workflow Defaults

Default to `codebuddy-native-project-workflow`.

- Use `specs/TASK-000.md` when the task is not yet executable.
- Use the smallest valid lane: `Fast`, `Standard`, or `Strict`.
- Stop at required gates: `Brainstorm Review`, `Plan Review`, `Sync Review`.
- End implementation with `Verify` and `Review`.
- Do not expand scope beyond the current task card.
- `create-task` means create the next task card only; `start-implementation` means implementation may begin.
```

如果 `CODEBUDDY.md` 已存在，只更新或追加 `## Workflow Defaults` 这一段，而不是覆盖无关项目规则。
除非用户明确要求，不要整体替换现有 `CODEBUDDY.md`。

## Execution Flow（执行流程）

按以下闭环执行：

1. 读取当前仓库状态。
先读工作流文档，再读当前任务卡。

2. 执行 Capability Gate。
判断是否支持并行助手或子代理；如果不支持，声明 `Single-agent serial fallback` 后继续。

3. 当任务还不可执行时，先进入 `specs/TASK-000.md` 头脑风暴。

4. 按固定 6 项结构完成头脑风暴：
- `项目名称 + 目标`
- `现状与背景`
- `用户角色`
- `技术约束`
- `Out of Scope`
- `Done when`
用缺口驱动的追问完成 `TASK-000`。当只缺少部分信息时，不要要求用户整段重写 brief。

5. 将头脑风暴结果同步到仓库文档：
- `SPEC.md` 写入六段结构
- `DECISIONS.md` 记录首轮关键取舍
- `BUILD_PLAN.md` 至少补到 `M1`
- `STATUS.md` 更新当前阶段、关卡、车道与说明

6. 停在 `Brainstorm Review`，等待用户明确确认。
澄清性输入本身不等于批准下一步。`create-task` 代表允许创建 `TASK-001`。`start-implementation` 代表允许开始实现。

7. 对 `TASK-001+` 的正常执行，必须填写：
- `Brainstorm Summary`
- `Lane Decision`
- `Plan Gate`

8. 选择执行车道：
- `Fast`：小改动、低风险，`generator -> evaluator`
- `Standard`：多步骤、跨文件，`planner -> Plan Review -> generator -> evaluator`
- `Strict`：高风险、不可逆，`planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

只有当显式计划确实有价值时才使用 `Standard`。
涉及迁移、破坏性改动、外部集成验证或广泛多模块改动时使用 `Strict`。

9. 当任务卡和车道决策准备好后，停在 `Implementation Approval`。
在用户明确批准执行前，不得开始实现。对 `Standard` 和 `Strict`，这个批准发生在 `Plan Review` 之后。

10. 每个实施任务结束前，必须完成：
- `Verify`
- `Review`

11. 停在 `Sync Review`。
用户确认前，不要更新里程碑文档，也不要自动进入下一张任务卡。
在 `Sync Review`，下一步必须明确为以下三选一：
- 接受当前任务
- 继续当前任务
- 创建下一张任务卡

## Gates（硬关卡）

- `Brainstorm Review`：初始文档和任务边界成形后停止
- `Implementation Approval`：任务卡准备好后、写代码前停止
- `Plan Review`：`Standard` 或 `Strict` 输出计划后停止
- `Sync Review`：实现评审完成后、最终同步前停止

补充规则：
- 关卡中的澄清输入不等于关卡批准
- `create-task` 只允许通过当前关卡去创建或更新下一张任务卡
- `start-implementation` 才允许实现工作开始
- 不要把 `proceed` 当成实现批准

## Lane Policy（车道策略）

- `Fast`：小改动、低风险，`generator -> evaluator`
- `Standard`：多步骤、跨文件，`planner -> Plan Review -> generator -> evaluator`
- `Strict`：高风险、不可逆，`planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

## Hard Rules（硬约束）

- 没有任务卡，不得编码
- 没有 `Verify` 和 `Review`，不得宣布完成
- 不扩展到无关目录或无关支线
- `BUILD_PLAN.md` 只记录里程碑级变化
- 优先保持最小但可评审的闭环
- 用户补充信息本身，不得自动视为通过下一关
- 在 `TASK-000` 期间，不要默认要求用户重写完整 brief，应只追问缺失字段
- 在 `TASK-000` 期间，如果用户回答仍不完整或不确定，应继续追问，而不是直接前进
- `Brainstorm Review` 之后，没有 `create-task` 或等价明确批准，不得创建 `TASK-001`
- 创建 `TASK-001` 后，必须先进入 `Implementation Approval`，等待明确开工批准
- `Brainstorm Review` 之后，没有 `start-implementation` 或等价明确批准，不得编辑实现文件或开始执行
- `Implementation Approval` 之后，没有 `start-implementation` 或等价明确批准，不得开始实现
- `Plan Review` 之后，没有 `start-implementation` 或等价明确批准，不得开始实现
- `Sync Review` 之后，没有明确 sync approval，不得同步里程碑文档或进入下一任务
- `Sync Review` 之后，只允许：接受当前任务、继续当前任务、或创建下一张任务卡
- 将 `proceed` 视为模糊词，并追问用户是要 `create-task` 还是 `start-implementation`

## Quick Prompts（快捷触发）

- 使用 `$codebuddy-native-project-workflow` 从模糊想法启动一个仓库
- 使用 `$codebuddy-native-project-workflow` 继续当前任务并选择合适车道
- 使用 `$codebuddy-native-project-workflow` 检查仓库状态、更新 STATUS 并准备下一张任务卡
- 使用 `create-task` 允许创建下一张任务卡但不立即开始实现
- 使用 `start-implementation` 在任务卡和计划就绪后批准开始实现

## Status Output（状态输出格式）

当用户问“现在到哪一步了”时，按以下格式输出：
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue（或 None）
6. Next action
