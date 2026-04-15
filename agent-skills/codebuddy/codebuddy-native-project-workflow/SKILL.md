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

## Required Files（必备文件）

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

生成的 `CODEBUDDY.md` 应该保持简短、面向项目长期约束，只需要写清：
- 当前仓库默认采用 `codebuddy-native-project-workflow`
- 什么时候必须先做 `TASK-000`
- 当前仓库采用的车道模型：`Fast`、`Standard`、`Strict`
- 必须停下来的 gate：`Brainstorm Review`、`Plan Review`、`Sync Review`
- 收口前必须完成 `Verify` 和 `Review`

不要把整个 skill 原文复制进 `CODEBUDDY.md`，只写适合长期保留的默认行为摘要。
如果 `CODEBUDDY.md` 已存在，应追加或更新 workflow 区块，而不是覆盖无关项目规则。
除非用户明确要求，不要整体替换现有 `CODEBUDDY.md`。

## Workflow（完整流程）

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

5. 将头脑风暴结果同步到仓库文档：
- `SPEC.md` 写入六段结构
- `DECISIONS.md` 记录首轮关键取舍
- `BUILD_PLAN.md` 至少补到 `M1`
- `STATUS.md` 更新当前阶段、关卡、车道与说明

6. 停在 `Brainstorm Review`，等待用户确认。

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

9. 每个实施任务结束前，必须完成：
- `Verify`
- `Review`

10. 停在 `Sync Review`。
用户确认前，不要更新里程碑文档，也不要自动进入下一张任务卡。

## Gates（硬关卡）

- `Brainstorm Review`：初始文档和任务边界成形后停止
- `Plan Review`：`Standard` 或 `Strict` 输出计划后停止
- `Sync Review`：实现评审完成后、最终同步前停止

## Hard Rules（硬约束）

- 没有任务卡，不得编码
- 没有 `Verify` 和 `Review`，不得宣布完成
- 不扩展到无关目录或无关支线
- `BUILD_PLAN.md` 只记录里程碑级变化
- 优先保持最小但可评审的闭环

## Quick Prompts（快捷触发）

- 使用 `$codebuddy-native-project-workflow` 从模糊想法启动一个仓库
- 使用 `$codebuddy-native-project-workflow` 继续当前任务并选择合适车道
- 使用 `$codebuddy-native-project-workflow` 检查仓库状态、更新 STATUS 并准备下一张任务卡

## Status Output（状态输出格式）

当用户问“现在到哪一步了”时，按以下格式输出：
1. Current Phase
2. Current Task
3. Current Gate
4. Selected Lane
5. Blocking issue（或 None）
6. Next action
