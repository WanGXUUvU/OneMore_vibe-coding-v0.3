# TASK-001

## Title
[任务标题]

## Task Source
- SPEC: [对应目标或范围]
- BUILD_PLAN: [对应里程碑]

## Goal
[本轮要完成什么]

## Context
[本轮最相关的上下文]

## In Scope
- [本轮包含 1]
- [本轮包含 2]

## Out of Scope
- [本轮不做 1]

## Constraints
- 单张 TASK 变更文件 ≤10 个
- 如果代码库为空，可标记为 `Bootstrap Task`
- 如为纯静态页面，自动化浏览器验证默认通过临时本地静态 server 执行，不直接要求 Playwright 访问 `file://`

## Invariants
- [本轮不能破坏的事实 1]
- [本轮不能破坏的事实 2]

## Required Reads

| 角色 | 必读 |
|------|------|
| planner | `AGENTS.md` + `STATUS.md` + 本卡；按需 `BUILD_PLAN.md` |
| generator | 本卡 `Plan` + [相关源码文件] |
| evaluator | 本卡 `Done when` + `Changed Files` + `Verify` |
| fixer | 本卡 `Verify` 失败项 + [具体失败文件] |

## Files Involved
- [路径 1]
- [路径 2]

## Preflight Checks
- [开工前必须确认的事实 1]
- [开工前必须确认的事实 2]

## Done when

> 只写可运行、可验证的代码或交付标准。
> 好例：通过临时本地静态 server 打开 `index.html` 时无阻断性错误，且实现仍满足 `file://` 直开约束。
> 反例：文档格式正确。

- [ ] [条件 1]
- [ ] [条件 2]
- [ ] [如需保留 `file://` 直开能力，补充不会破坏该能力的静态约束]

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

- Automated: [自动化验证结果]
- Manual: [手动验证结果；若 MCP 阻止 `file://`，写明阻断原因与替代证据]
- Evidence refs: [引用的证据]
- Results: [Pass / Fail / Blocked 项]
- Fix log: [如有修复，记录本轮修复]

## Review

- Verdict: [Pass / Fail / Blocked] · Ready for Next Task: [Y/N]
- Top Risk: [最多 2 条；无则写"无"]
- Unexpected: [无则写"无"]

## Review Focus

- [重点检查项]

## Notes for Next Task
- [给下一轮 planner 的输入、遗留项、注意事项]

---

## Archive

> 旧轮次 Verify / Fix log 移到此处。
