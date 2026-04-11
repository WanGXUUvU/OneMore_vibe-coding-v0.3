# TASK-001

## Title
[任务标题]

## Task Source
- SPEC: [对应目标或范围]
- BUILD_PLAN: [对应里程碑]

## Task Form
- Type: [`Full Task`]

## Goal
[本轮要完成什么]

## Scope
- In: [本轮要做什么]
- Out: [本轮不做什么]

## Done when
- [ ] [条件 1]
- [ ] [条件 2]

## Context
[可选；只有边界不清时再写]

## Constraints
[可选；只有存在硬约束时再写]

## Execution Lane

> 主控在开工前选择其一；未说明时默认 `Standard Lane`。

- `Fast Lane`：1 到 2 个文件的小修；不改 API 契约、数据模型、权限、部署、迁移
- `Standard Lane`：普通功能开发；需要 `Plan Review`
- `Strict Lane`：高风险任务；涉及协议、权限、迁移、部署或高并行风险

## Lane Decision

> 开工前必须落盘当前轮实际选择。

- Selected: [`Fast Lane` / `Standard Lane` / `Strict Lane`]
- Why this lane: [一句话说明]

## Plan Gate

> 开工前必须落盘。`Fast Lane` 默认 `Skipped`；`Standard / Strict` 默认 `Required`。

- Status: [`Required` / `Skipped`]
- Why: [一句话说明]

## Invariants
[可选；只有确实存在不可破坏前提时再写]

## Required Reads

| 角色 | 必读 |
|------|------|
| 主控 | `AGENTS.md` + `STATUS.md` + 本卡；按需 `BUILD_PLAN.md` |
| planner | 仅在 `Standard / Strict Lane` 默认启用；读本卡与必要上文；TASK 卡 Plan 段已有内容且范围清晰时可跳过 |
| generator | Plan Gate = Required：本卡 `Plan` + [相关源码文件]<br>Plan Gate = Skipped：本卡 `Scope / Done when / Files Involved` + [相关源码文件] |
| evaluator | 本卡 `Done when` + `Changed Files` + `Execution Evidence` |
| fixer | 仅在 `evaluator` 明确指出失败项后启用 |

## Files Involved
[核心文件列表]

## Preflight Checks
[可选；只有开工前必须确认的事实才写]

---

## Plan

> 由 planner 填写，generator 读取。

[步骤 / 涉及文件 / 风险 / 验证方式]

## Changed Files

> 由 generator 填写，evaluator 读取。

- [path/to/file]

## Execution Evidence

> 由 generator / evaluator 追加本轮证据。

| command | artifact | result | note |
|---------|----------|--------|------|
| [例如 `npm run build`] | [输出、截图、日志或 `N/A`] | [pass/fail/blocked] | [补充说明] |

## Verify

> 由 evaluator 填写当前轮结果。
> 按任务类型选择最小验证模板，不要求所有任务都跑同一套重流程。

- Automated: [自动化验证结果]
- Manual: [手动验证结果；若 MCP 阻止 `file://`，写明阻断原因与替代证据]
- Evidence refs: [引用的证据]
- Results: [Pass / Fail / Blocked 项]
- Fix log: [如有修复，记录本轮修复]
- Next action: [`Sync Review` / `Pull fixer` / `Blocked`]

## Review

- Verdict: [Pass / Fail / Blocked] · Ready for Next Task: [Y/N]
- Top Risk: [最多 2 条；无则写"无"]
- Unexpected: [无则写"无"]
- Lane fit: [本轮所选执行车道是否合适；如不合适，说明应升/降档]

## Notes for Next Task
- [给下一轮 planner 的输入、遗留项、注意事项]
