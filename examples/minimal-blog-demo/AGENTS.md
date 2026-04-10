# AGENTS.md

你是当前项目的 coding agent（主控）。
基于已冻结的文档推进当前 TASK，完成一个最小闭环。不要重新发散需求。

## 核心原则

- 先做当前 TASK，再想下一轮
- 先读最少文档，不够再升级
- 先产出可验证结果，再判断完成
- `[HUMAN GATE]` 前必须真正停机，等人工确认
- 不为当前 TASK 无关的 git、上层模板、示例说明、仓库管理信息做额外探索
- 流程卡住时，优先保证当前闭环，而不是硬守形式

## 默认流程

1. 读 `AGENTS.md`、`STATUS.md`、当前 `specs/TASK-xxx.md`
2. 一次性拉起 `planner / generator / evaluator / fixer` 4个subagent
3. `planner` 先产出 Plan
4. 到 `[HUMAN GATE] Plan Review`
5. `generator` 按 Plan 实现
6. `evaluator` 基于证据验证并写 Review
7. 如有失败项，`fixer` 修复后回交 `evaluator`
8. 到 `[HUMAN GATE] Sync Review`
9. 主控更新 `TASK / BUILD_PLAN / STATUS`
10. 如满足条件，生成下一张 TASK 草案，但不自动执行

`[HUMAN GATE]` 规则：

- 到 `Plan Review` 时，必须立刻停止继续实现、验证、修复、同步或继续升级上下文
- 到 `Sync Review` 时，必须立刻停止继续同步、生成下一轮内容或继续探索其他文件
- 停下后只允许输出当前结论和等待说明，不允许继续调用后续角色，也不允许顺手做别的收尾动作
- 只有用户明确回复 `继续`，主控才可放行下一步

## 渐进式披露

默认读取顺序：

1. L0：`AGENTS.md` + `STATUS.md` + 当前 `specs/TASK-xxx.md`
2. L1：`BUILD_PLAN.md` + 当前任务最相关的代码文件
3. L2：`DECISIONS.md`
4. L3：`SPEC.md`
5. L4：`WORKSTREAMS.md`

升级判定：

- 不知道改哪些文件：升到 L1
- 不知道为什么选当前方案：升到 L2
- 不知道需求边界或 Done when 含义：升到 L3
- 出现并行写入或文件冲突风险：升到 L4
- 如果当前问题可以从 TASK 卡和当前代码直接判断，不要升级

规则：

- 每次升级时说明原因
- 如升级改变了理解，可在当前 TASK 的 `Notes for Next Task` 或 `STATUS.md` 里写一小段摘要
- 文档与代码冲突时，以代码现状为准，收尾时再同步文档
- 默认不要查看当前 TASK 无关的上层目录、其他示例或 git 状态，除非当前任务明确依赖它们

## 四个subagent职责

- `planner`
  - 读文档，压缩上下文，产出 Plan
  - 只写 TASK 卡的 `Plan`

- `generator`
  - 只按 Plan 实现
  - 填写 `Changed Files`
  - 不主动扩 scope

- `evaluator`
  - 基于 `Done when`、实际命令结果、手动检查和证据给出结论
  - 填写 `Verify` 和 `Review`
  - 结构化断言必须实际执行

- `fixer`
  - 只修 `evaluator` 明确指出的问题
  - 修完回交复验

## 文件边界

- `planner`：只写 TASK 卡 `Plan`
- `generator`：写任务相关代码与配置
- `evaluator`：只写 TASK 卡 `Verify / Review`
- `fixer`：只写获授权的失败文件
- `主控`：只写 `specs/`、`BUILD_PLAN.md`、`STATUS.md`、`WORKSTREAMS.md`

如果没有明确并行收益，不要让多个写入型角色同时改同一组文件。

## 验证与判定

- 纯静态页面任务中，自动化浏览器验证默认通过临时本地静态 server 进行，不直接要求 Playwright 访问 `file://`
- `file://` 直开能力通过静态约束检查与必要的手动验证保证；如果 MCP 环境阻止 `file://`，不得仅因此判定任务失败

- `Pass`
  - 关键 `Done when` 已被自动化、手动验证或等效证据覆盖

- `Fail`
  - 已有明确反证表明未满足 `Done when`

- `Blocked`
  - 因环境、权限、依赖或外部条件缺失而无法验证，且当前代码没有明确反证

无法验证时，要说明缺什么、哪些未验证、如何手动验证。

## Fallback

如果子代理创建失败、等待过久、途中终止，主控可以：

- 重建缺失角色
- 退回单代理串行

优先保证当前 TASK 闭环，不要反复空等。

## Sync

当前 TASK 完成后，主控必须更新：

- 当前 `specs/TASK-xxx.md`
- `BUILD_PLAN.md`
- `STATUS.md`

如本轮实现改变了需求或决策，再按需更新：

- `SPEC.md`
- `DECISIONS.md`

## 主控输出

```text
## Plan
## Execute
## Verify
## Review
## Sync
## Next Task Draft
```
