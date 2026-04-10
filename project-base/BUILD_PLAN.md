# BUILD_PLAN

## Goal Understanding

### Current Stage Objective
[当前阶段要交付什么]

### Why This Plan
[为什么这套方案满足 SPEC 与 DECISIONS]

## Plan Inputs
- SPEC version / summary:
  - [摘要]
- Key decisions:
  - [关键决策 1]
  - [关键决策 2]

## Architecture Snapshot

> 按需填写。不存在的层直接写 `N/A`，不要为了填模板伪造架构。

- UI / Frontend:
  - [选型或 N/A]
- Runtime / Backend:
  - [选型或 N/A]
- Storage / Database:
  - [选型或 N/A]
- Access Control / Auth:
  - [选型或 N/A]
- External Integrations:
  - [选型或 N/A]
- Test strategy:
  - [选型]

## Milestones

> 里程碑默认串行。如果某个里程碑内的多个 TASK 可以并行，在名称后加 `(parallel)` 标注。
> 并行里程碑中的 TASK 需要在 WORKSTREAMS.md 的 `Parallel Config` 中注册依赖关系。

### M1 [名称]
- Goal:
  - [目标]
- Scope:
  - [范围 1]
  - [范围 2]
- Files involved:
  - [路径]
- Risks:
  - [风险]
- Verify:
  - [验证方式]
- Exit criteria:
  - [ ] [条件 1]
  - [ ] [条件 2]

### M2 [名称]
- Goal:
  - [目标]
- Scope:
  - [范围 1]
  - [范围 2]
- Files involved:
  - [路径]
- Risks:
  - [风险]
- Verify:
  - [验证方式]
- Exit criteria:
  - [ ] [条件 1]
  - [ ] [条件 2]

### M3 [名称]
- Goal:
  - [目标]
- Scope:
  - [范围 1]
  - [范围 2]
- Files involved:
  - [路径]
- Risks:
  - [风险]
- Verify:
  - [验证方式]
- Exit criteria:
  - [ ] [条件 1]
  - [ ] [条件 2]

### M4 [名称，可选]
- Goal:
  - [目标]
- Scope:
  - [范围 1]
  - [范围 2]
- Files involved:
  - [路径]
- Risks:
  - [风险]
- Verify:
  - [验证方式]
- Exit criteria:
  - [ ] [条件 1]
  - [ ] [条件 2]

### M5 [名称，可选]
- Goal:
  - [目标]
- Scope:
  - [范围 1]
  - [范围 2]
- Files involved:
  - [路径]
- Risks:
  - [风险]
- Verify:
  - [验证方式]
- Exit criteria:
  - [ ] [条件 1]
  - [ ] [条件 2]

## Verify Strategy

### Automated
- [ ] test
- [ ] lint
- [ ] typecheck
- [ ] build
- [ ] 如为纯静态页面，启动临时本地静态 server，通过 `http://127.0.0.1:<port>` 执行浏览器自动化验证
- [ ] 扫描源码，确认没有 `fetch`、模块脚本、后端请求或构建产物依赖

### Manual
1. [步骤 1]
2. [步骤 2]
3. [如需保留 `file://` 直开能力，必要时手动验证；若 MCP 阻止 `file://`，记录原因且不直接判失败]

## Rollback Points
- [回滚点 1]
- [回滚点 2]

## Checkpoint Policy
- Before fixer edits:
  - [主控如何保存最近 checkpoint，例如 commit / patch / diff]
- If no git checkpoint exists:
  - [如何恢复到 generator 已验证状态]

## Current Pointer
- Current milestone:
  - [例如 M1]
- Why this one first:
  - [理由]

## Execution Harness
- Roles:
  - `planner`
  - `generator`
  - `evaluator`
  - `fixer`
- Run style:
  - 多子代理协作（默认）
  - 单代理串行（Fallback）
- State owner:
  - 主控负责更新 `STATUS.md`、`BUILD_PLAN.md`、`WORKSTREAMS.md` 和下一张 TASK 文件

## Progress
- [ ] M1 Not started
- [ ] M1 Doing
- [ ] M1 Done
- [ ] M2 Doing
- [ ] M2 Done
- [ ] M3 Doing
- [ ] M3 Done
- [ ] M4 Doing
- [ ] M4 Done
- [ ] M5 Doing
- [ ] M5 Done

## Readiness
- [ ] Ready for Task
