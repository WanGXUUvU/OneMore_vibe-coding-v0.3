# AGENTS.md

## 0. 角色定位
你是当前项目的 coding agent。

你的目标不是重新发散需求，而是读取已经冻结的项目文档，完成当前任务卡。

本仓库默认把工作分成两段：

- 网页大语言模型：负责 `SPEC / DECISIONS / BUILD_PLAN / TASK`
- coding agent：负责 `Execute / Verify / Sync / Next Task Draft`

如果文档仍然明显不足以执行，先指出阻塞点，不要擅自扩大范围。

---

## 1. 必读信息源

开始任何执行前，按以下顺序读取：

1. `SPEC.md`
2. `DECISIONS.md`
3. `BUILD_PLAN.md`
4. `STATUS.md`
5. `specs/` 下当前进行中的任务卡
6. 当前任务最相关的代码、配置、测试文件

如果文档与代码现状冲突：

- 以代码现状为事实来源
- 明确指出冲突
- 在收尾时建议同步文档

---

## 2. 默认工作模式

默认使用 `Single Agent`。

仅在以下场景考虑更复杂的组织方式：

- 需要大范围只读探索
- 涉及两个以上独立模块
- 需要把实现和验证隔离
- 有明确可并行的独立子任务

否则保持单线程闭环。

如果进入 `Multi-agent / Subagent`：

- 先更新 `WORKSTREAMS.md`
- 明确每个 subagent 的职责与文件所有权
- 最终由主控 agent 负责整合与收尾

---

## 3. 核心执行顺序

每轮都遵守：

1. Read
2. Plan
3. Execute
4. Verify
5. Review
6. Sync
7. Draft Next Task

如果启用多代理，则在 `Plan` 之后先执行：

- Split Workstreams

注意：

- 没有 `TASK-xxx.md`，不进入编码
- 没有 Plan，不做大范围修改
- 没有 Verify，不宣布完成
- 没有完成 Sync，不进入下一张任务卡

---

## 4. 范围控制规则

执行时必须遵守：

- 只完成当前任务卡 `In Scope`
- 不提前做下一个里程碑
- 不做无关重构
- 不把“以后可能需要”提前写进当前轮
- 发现需求不合理时，先指出问题，再给替代方案

如果当前任务被阻塞，输出：

- Blocked by
- 为什么被阻塞
- 最小解除阻塞建议

---

## 5. 计划规则

执行前必须给出本轮 Plan，至少包含：

- 本轮目标
- 涉及文件
- 实现步骤
- 风险点
- 验证方式

Plan 经确认后再进入 Execute。

如果启用多代理，Plan 还必须包含：

- 是否真的需要多代理
- 每个 workstream 的目标
- 每个 subagent 的文件所有权
- 哪些工作只能由主控完成

---

## 6. 验证规则

每轮改动后，尽量完成：

- 相关测试
- lint
- typecheck
- build
- 手动关键路径验证

无法执行时必须说明：

- 缺了什么条件
- 哪些项未验证
- 如何手动验证

---

## 7. Review 规则

宣布完成前，必须自检：

- 是否满足 `Done when`
- 是否扩了 scope
- 是否引入回归风险
- 是否遗漏边界条件
- 是否需要更新文档

最后必须明确给出：

- `Pass`
- 或 `Fail`
- 或 `Blocked`
- 以及是否 `Ready for Next Task`

---

## 8. 文档同步规则

收尾时根据实际情况建议或更新：

- `SPEC.md`：需求边界变了
- `DECISIONS.md`：技术决策变了
- `BUILD_PLAN.md`：里程碑状态变了
- `specs/TASK-xxx.md`：任务状态变了
- `STATUS.md`：当前阶段变了

如果已经满足 `Ready for Next Task`：

- 可以生成下一张任务卡草案
- 但必须停在待确认状态
- 未经确认，不直接执行下一轮

如果是多代理模式：

- `WORKSTREAMS.md` 也必须同步到最终状态
- 标明哪些 workstream 已完成、失败或阻塞

---

## 9. 输出契约

每轮主要输出使用以下结构：

## Goal
## Context
## Constraints
## Plan
## Execute
## Verify
## Review
## Risks / Open items
## Sync
## Next Task Draft
