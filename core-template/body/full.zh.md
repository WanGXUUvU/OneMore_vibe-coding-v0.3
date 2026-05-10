# {{PLATFORM_NAME}} Native Project Workflow（{{PLATFORM_NAME}} 原生完整项目工作流）

## Overview（技能用途）

本技能用于 bootstrap 一个可持续运行的项目治理工作台。它主要负责初始化或 re-bootstrap，不应该成为每次后续会话都必须显式重调的依赖。完成 bootstrap 后，后续对话应优先从仓库文件继续，而不是再次调用 skill。

## When to Use（触发规则）

1. 用户提到“启动流程 / 继续流程 / 标准化流程”时触发
2. 用户说“给我一套完整工作流”时触发
3. 用户说“先别写代码，先定边界”时触发
4. 用户说“需要人工 gate / review 节点”时触发
5. 用户说“收口时必须有 verify/review 证据”时触发
6. 关键词匹配：完整工作流、标准化流程、TASK-000、TASK-001、Brainstorm Review、Plan Review、Sync Review

## Repo Files（仓库文件）

除非仓库已有等价结构，否则在仓库根目录维护以下文件：

- `SPEC.md`：长期保留的问题定义与范围
- `DECISIONS.md`：关键决策与取舍理由
- `BUILD_PLAN.md`：仅记录里程碑级计划
- `STATUS.md`：当前项目状态、当前 gate、当前允许动作、当前里程碑与下一步。`Lane` 只是可选辅助信息，不是主指挥字段。初始格式参考 [references/status-template.md](references/status-template.md)。
- `specs/TASK-000.md`：bootstrap 头脑风暴
- `specs/TASK-001.md` 及后续任务卡：可执行任务
- `specs/PATCH-TASK.md`：超小修补

## Persistent Project Instructions（持久化项目约束）

在仓库内第一次有意义地调用本技能时，如果 `{{CONFIG_FILE}}` 不存在，就应主动创建它，让后续会话能从这些文件持续运行。

保持 `{{CONFIG_FILE}}` 极简。它是持久化记忆文件，不是 skill 的第二份副本。不要写通用编码建议、风格口号，或任何会在每个任务里触发高成本操作的指令。

如果 `{{CONFIG_FILE}}` 不存在，就按下面这段精简 workflow 区块创建：

```md
{{CONFIG_HEADER}}

## Workflow Defaults

- 在后续会话中，先读 `{{CONFIG_FILE}}`、`STATUS.md` 和当前任务卡。
- 只有当规划、范围或里程碑判断依赖它们时，才读 `SPEC.md`、`DECISIONS.md` 和 `BUILD_PLAN.md`。
- 当任务还不可执行，或 workflow 状态需要重建时，使用 `specs/TASK-000.md`。
- 使用最小有效 lane：`Fast`、`Standard`、`Strict`。
- 在必需 gate 停下：`Brainstorm Review`、`Plan Review`、`Implementation Approval`、`Sync Review`。
- 以 `Verify` 和 `Review` 结束实现。
- 不要扩展超出当前任务卡的范围。
- `create-task` 表示只允许创建下一张任务卡；`start-implementation` 表示允许开始实现。
- 每次通过任何 gate 后，立即更新 `STATUS.md`：设置 Phase、Task（文件路径）、Gate、Allowed Now、Milestone 和 Next action。只有当 `Lane` 确实有额外价值时才写它。在 `STATUS.md` 反映新状态之前，不得宣告 gate 已通过或实现完成。
```

如果 `{{CONFIG_FILE}}` 已存在，只更新或追加 `## Workflow Defaults` 这一段，而不是覆盖无关项目规则。
除非用户明确要求，不要整体替换现有 `{{CONFIG_FILE}}`。

当 full workflow 在新仓库里首次落盘时，先初始化 `DECISIONS.md` 和 `BUILD_PLAN.md`，再创建 `TASK-001`。
初始 `DECISIONS.md` 使用 [references/decisions-template.md](references/decisions-template.md)。
初始 `BUILD_PLAN.md` 使用 [references/build-plan-template.md](references/build-plan-template.md)。

## Continuation Contract（后续续跑约定）

后续新对话默认按下面顺序启动：

1. 读取 `{{CONFIG_FILE}}`
2. 读取 `STATUS.md`
3. 读取当前任务卡
4. 只有当规划、范围或里程碑判断依赖它们时，再读 `SPEC.md`、`DECISIONS.md`、`BUILD_PLAN.md`
5. 在采取动作前，先遵守 `STATUS.md` 里的当前 gate

只有当 workflow 状态缺失、损坏或需要重新定义时，才重新调用本技能。

## Execution Flow（执行流程）

本技能执行的是一个有边界的 bootstrap 闭环：

1. 读取当前仓库状态。
先读工作流文件，再读当前任务卡。

2. 当任务还不可执行时，从 `specs/TASK-000.md` 开始头脑风暴。
当项目从模糊想法起步、根文档缺失，或当前任务还没有清晰目标、范围与完成条件时，都使用 `TASK-000`。

3. 使用固定 6 项结构完成头脑风暴：
- `项目名称 + 目标`
- `现状与背景`
- `用户角色`
- `技术约束`
- `Out of Scope`
- `Done when`
用缺口驱动的追问完成 `TASK-000`。当只缺少部分信息时，不要要求用户整段重写 brief。

4. 将头脑风暴结果落成长期文件：
- `SPEC.md` 写入六段结构
- `DECISIONS.md` 记录首轮关键取舍，使用上面的模板
- `BUILD_PLAN.md` 至少补到 `M1`，使用上面的模板
- `STATUS.md` 更新当前阶段、关卡、当前允许动作、当前里程碑、可选车道与说明

5. 停在 `Brainstorm Review`。
当 `TASK-000` 已足够生成真实任务卡时，停下并等待用户明确确认。澄清性输入本身不等于批准下一步。`create-task` 代表允许创建 `TASK-001`。`start-implementation` 代表允许开始实现。

6. 创建第一张可执行任务卡。
对 `TASK-001+` 的正常执行，必须填写：
- `Brainstorm Summary`
- `Lane Decision`
- `Plan Gate`

7. 选择执行车道：
- `Fast`：小改动、低风险，`generator -> evaluator`
- `Standard`：多步骤、跨文件，`planner -> Plan Review -> generator -> evaluator`
- `Strict`：高风险、不可逆，`planner -> Plan Review -> generator -> evaluator -> (fixer -> evaluator)`

只有当任务确实需要显式计划时才使用 `Standard`。涉及迁移、破坏性改动、外部集成验证或广泛多模块改动时使用 `Strict`。

8. 当 `TASK-001` 和车道决策准备好后，设置 `STATUS.md` 的下一 gate 并停下。
在用户明确批准执行前，不得开始实现。对 `Standard` 和 `Strict`，这个批准发生在 `Plan Review` 之后。

9. 后续实现会话应从文件继续，而不是从 skill 继续。
正常下一次对话应从 `{{CONFIG_FILE}}`、`STATUS.md` 和当前任务卡恢复。

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
- 未收到对应的明确批准信号，不得通过任何 gate：`create-task` 仅批准建卡；`start-implementation` 批准实现工作；明确 sync approval 才可通过 `Sync Review`。
- `Sync Review` 之后，只允许：接受当前任务、继续当前任务、或创建下一张任务卡
- 将 `proceed` 视为模糊词，并追问用户是要 `create-task` 还是 `start-implementation`

## Quick Prompts（快捷触发）

- 使用 `${{SKILL_FULL}}` 从模糊产品想法 bootstrap 一个仓库
- 使用 `${{SKILL_FULL}}` 在 repo 文档缺失或漂移后 re-bootstrap workflow 状态
- 从 `{{CONFIG_FILE}}`、`STATUS.md` 和当前任务卡继续这个项目
- 使用 `create-task` 允许创建下一张任务卡但不立即开始实现
- 使用 `start-implementation` 在任务卡和计划就绪后批准开始实现

## Status Output（状态输出格式）

当用户问“现在到哪一步了”时，按以下格式输出：
1. Current Phase
2. Current Task
3. Current Gate
4. Current Milestone
5. Allowed Now
6. Blocking issue（或 None）
7. Next action

如果存在 `Selected Lane`，只把它当作辅助上下文，而不是主指挥信息。
