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

本技能为轻量级跨项目工作流，用最少的文件和步骤完成项目交付，在关键决策点设有强制暂停关卡，平衡速度与安全性。核心理念：**有纪律的极简主义**。

## When to Use（触发规则）

1. 用户提到"轻量流程 / 简化流程 / 最小工作流"时触发
2. 用户说"不要太多文档，先把功能做完"时触发
3. 用户说"给我一套跨项目通用的简版流程"时触发
4. 用户说"继续当前任务，但用精简模式"时触发
5. 新项目启动，需要最小 TASK-000 头脑风暴步骤时触发
6. 关键词匹配：轻量流程、简化流程、最小工作流、快速交付、精简模式、lite模式、TASK-000

## Interaction Guidelines（交互指南）

### 第一步：读取仓库状态

触发技能后，**必须首先执行以下操作**：

1. 检查仓库中是否存在以下文件：
   - `STATUS.md` — 项目状态文件
   - `specs/TASK-000.md` — 头脑风暴任务卡
   - `specs/TASK-xxx.md` — 实施任务卡
   - `specs/PATCH-TASK.md` — 补丁任务卡
   - `SPEC.md` — 范围说明（可选）
   - `BUILD_PLAN.md` — 构建计划（可选）

2. 根据检查结果判断当前阶段：
   - 无任何文件 → 新项目，需要创建 TASK-000
   - 仅有 STATUS.md → 读取状态，继续进行
   - 有任务卡 → 读取当前任务，继续执行

### 第二步：判断是否需要 TASK-000

**以下情况必须先创建 `specs/TASK-000.md`：**
- 项目全新，无任何任务卡
- 目标/范围/Done when 不清晰
- 用户从零开始描述需求

**TASK-000 固定结构：**
```markdown
# TASK-000: 项目头脑风暴

## 1. 项目名称 + 目标
[项目名称]：[一句话目标]

## 2. 现状与背景
[当前项目状态、已有代码/资源、背景信息]

## 3. 用户角色
[谁使用这个系统？主要角色和职责]

## 4. 技术约束
[技术栈、框架、数据库、部署环境等约束]

## 5. Out of Scope
[明确排除的范围，不做的事情]

## 6. Done when
[完成的判定条件，可验证的验收标准]
```

创建 TASK-000 后，**停止在 Brainstorm Review 关卡**，等待用户确认。

### 第三步：确认范围

在开始实施前，用简短的一个区块确认：
- **目标**：本任务要达成什么
- **In Scope**：包含哪些工作
- **Out of Scope**：不包含哪些工作

### 第四步：选择车道

根据任务特征选择车道：

| 车道 | 适用场景 | 流程 | 示例 |
|------|---------|------|------|
| **Fast** | 小改动、低风险 | generator → evaluator | 修 bug、改配置、加日志 |
| **Standard** | 多步骤、跨文件 | planner → Plan Review → generator → evaluator | 新增功能页面、重构模块 |
| **Strict** | 高风险、不可逆 | planner → Plan Review → generator → evaluator → fixer → evaluator | 删表、改数据库结构、上线前变更 |

**车道选择原则：**
- 默认使用 Standard 车道
- 用户明确说"快速/简单/小改动"时使用 Fast 车道
- 涉及数据丢失、不可逆操作时必须使用 Strict 车道
- 不确定时选择更高等级的车道

### 第五步：执行实施

**在最小的闭环中执行实现：**

1. **planner**（Fast 车道跳过）：制定实施计划，列出改动文件和步骤
2. **Plan Review**（Fast 车道跳过）：停止，等用户确认计划
3. **generator**：按计划编写代码
4. **evaluator**：验证实现结果
5. **fixer**（仅 Strict 车道）：修复 evaluator 发现的问题
6. **evaluator**（仅 Strict 车道）：二次验证

### 第六步：验证（Verify Minimum）

每个任务完成后必须验证：

| 类型 | 验证标准 |
|------|---------|
| 文档/配置 | 静态检查：格式正确、内容完整 |
| 前端 | 页面能打开，关键内容存在，无阻断错误 |
| 后端 | 构建通过 + 最小运行断言 |
| 数据库 | SQL 语法正确，可执行 |

### 第七步：评审（Review Minimum）

验证通过后，输出简短评审：

```markdown
## Review

### What changed
[改了什么，列出关键变更]

### How verified
[如何验证的，验证方法]

### Status
[✅ Pass / 🚫 Blocked]

### Remaining risk
[剩余风险，或 None]
```

### 第八步：停在 Sync Review

验证和评审完成后，**停止等待用户确认**，不要自动进行同步级别的更新。

## Minimal Files（最精简文件集合）

### 必选文件
| 文件 | 用途 | 何时创建 |
|------|------|---------|
| `STATUS.md` | 项目状态追踪 | 项目启动时 |
| `specs/TASK-000.md` | 头脑风暴 | 项目全新或目标模糊时 |
| `specs/TASK-001.md` 及之后 | 实施任务卡 | 确认范围后 |
| `specs/PATCH-TASK.md` | 补丁任务 | 小修补时 |

### 可选文件
| 文件 | 用途 | 何时创建 |
|------|------|---------|
| `SPEC.md` | 范围说明 | 边界不清晰时 |
| `BUILD_PLAN.md` | 构建计划 | 里程碑级变更时 |

### STATUS.md 格式
```markdown
# Project Status

## Current Phase
[Brainstorm / Planning / Implementation / Verification / Review / Sync]

## Current Task
[TASK-xxx 或 None]

## Current Gate
[Brainstorm Review / Plan Review / Sync Review 或 None]

## Selected Lane
[Fast / Standard / Strict]

## Blocking Issue
[阻塞问题或 None]

## Next Action
[下一步行动]
```

## Gates（三道硬关卡）

### Brainstorm Review
- **触发时机**：TASK-000 创建后，实施前
- **检查内容**：目标/现状/角色/约束/Out of Scope/Done when 是否清晰可执行
- **通过条件**：任务已可执行，用户确认
- **未通过**：继续完善 TASK-000

### Plan Review
- **触发时机**：Standard/Strict 车道的计划制定后
- **检查内容**：实施计划是否合理、是否遗漏
- **通过条件**：用户确认计划
- **未通过**：修改计划

### Sync Review
- **触发时机**：验证和评审通过后，同步级别更新前
- **检查内容**：变更是否可安全同步
- **通过条件**：用户确认
- **未通过**：回退或修复

## Capability Gate（子代理能力门控）

- 如果 CodeBuddy 的 Task 工具（子代理）可用，仅在能减少时间或风险时使用
- 如果子代理不可用，声明 `单代理串行回退`，手动切换角色
- 保持 planner、generator、evaluator、fixer 的职责边界：
  - **planner**：只做规划，不写代码
  - **generator**：只按计划写代码
  - **evaluator**：只验证，不修改
  - **fixer**：只修复验证发现的问题

## Rules（六条硬规则）

1. **没有任务卡不写代码** — 必须有 specs/TASK-xxx.md 才能开始实施
2. **不扩大范围** — 严格按照任务卡的范围执行
3. **不跳过验证** — 每个任务必须通过 Verify Minimum
4. **Verify + Review 完成前不宣告 Done** — 两个步骤缺一不可
5. **BUILD_PLAN.md 仅在里程碑级变更时更新** — 不要频繁更新
6. **项目从零开始或目标模糊时不跳过 TASK-000** — 必须先做头脑风暴

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

## 与其他技能联动

- 项目工作流可与 `sheno` 系列技能结合使用
- 代码实施阶段可触发 `sheno-codegen` 生成代码
- 数据库初始化可触发 `sheno-db`
- 权限配置可触发 `sheno-permission`

## Common Mistakes（使用规范）

1. 不要把简单流程变复杂 — 如果任务可以用 Fast 车道完成，不要强制用 Standard
2. 不要跳过关卡 — 即使"我知道了"，也必须在关卡处停一下
3. 不要在用户未确认的情况下自动推进到下一阶段
4. 不要创建过多的文档 — 只维护必要的文件
5. 不要在 TASK-000 中写实现细节 — 只做范围澄清

## 参考文档

- 工作流模式详解：`./references/workflows.md`
- 任务卡模板：`./references/task-templates.md`
