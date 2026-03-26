# WORKSTREAMS

> 只有在 `Multi-agent / Subagent` 模式下使用。
> 默认单代理时，可以保持空白或标记为 N/A。

## Mode
- [ ] Single Agent
- [ ] Multi-agent / Subagent

## Coordinator
- Owner:
  - [主控 agent]
- Responsibilities:
  - [读取文档]
  - [切分工作流]
  - [整合结果]
  - [更新 BUILD_PLAN / STATUS / TASK]

## Workstream 1
- Name:
  - [例如 只读探索]
- Type:
  - [Explorer / Implementer / Reviewer]
- Goal:
  - [目标]
- File ownership:
  - [路径 1]
  - [路径 2]
- Constraints:
  - [限制]
- Status:
  - [Todo / Doing / Done / Blocked]

## Workstream 2
- Name:
  - [例如 前端实现]
- Type:
  - [Explorer / Implementer / Reviewer]
- Goal:
  - [目标]
- File ownership:
  - [路径 1]
  - [路径 2]
- Constraints:
  - [限制]
- Status:
  - [Todo / Doing / Done / Blocked]

## Workstream 3
- Name:
  - [例如 验证与 Review]
- Type:
  - [Explorer / Implementer / Reviewer]
- Goal:
  - [目标]
- File ownership:
  - [只读或特定路径]
- Constraints:
  - [限制]
- Status:
  - [Todo / Doing / Done / Blocked]

## Shared Risks
- [风险 1]
- [风险 2]

## Handoffs
- [主控何时整合]
- [哪些结果必须先返回]

## Final Sync
- [ ] 所有 workstream 状态已同步
- [ ] 主控已整合结果
- [ ] 已完成 Verify / Review
- [ ] 已更新 STATUS / BUILD_PLAN / TASK
