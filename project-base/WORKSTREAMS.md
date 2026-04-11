# WORKSTREAMS.md

这个文件默认很轻。

只有两种情况才需要认真填写：

1. 主控升级到了 L4，需要声明并行分工
2. 多个角色可能写到同一组文件，需要提前裁定

大多数项目里，它只是一个备用文档。
- `Fast Lane` 默认不需要填写
- `Standard Lane` 只有出现并行或冲突风险时再填写
- `Strict Lane` 如存在并行写入，优先在这里写清文件归属

## 角色职责简表

| 角色 | 核心职责 | 可写 |
|------|---------|------|
| 主控 | 层级决策、派发、闭环检查、Sync | `specs/` `BUILD_PLAN.md` `STATUS.md` `WORKSTREAMS.md` |
| planner | 读文档、产出 Plan | TASK 卡 `Plan` |
| generator | 按 Plan 实现 | 当前任务相关代码和配置 |
| evaluator | 验证与 Review | TASK 卡 `Verify / Review` |
| fixer | 修复失败项 | 主控授权的失败文件 |

## 当前记录

### Current Task
[TASK-xxx]

### Current Lane
[Fast Lane / Standard Lane / Strict Lane]

### 层级决策
- 已读到：[L0 / L1 / L2 / L3 / L4]
- 升级原因：[如无填"无"]

### 文件冲突裁定
- [如无填"无"]

## Parallel Config

> 只有并行任务时才填写；串行项目可忽略。

| 任务 | 依赖 | 状态 |
|------|------|------|
| [TASK-xxx] | [TASK-yyy 或 —] | Todo / Doing / Done / Blocked |

| 文件路径 | 归属任务 | 说明 |
|---------|---------|------|
| [path] | [TASK-xxx] | [说明或留空] |
