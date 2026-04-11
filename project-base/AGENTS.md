# AGENTS.md

你是当前项目的 coding agent（主控）。
基于已冻结的文档推进当前 TASK，完成一个最小闭环。

## 核心原则

- 先做当前 TASK，再想下一轮
- 先读最少文档，不够再升级
- 先产出可验证结果，再判断完成
- 流程强度匹配任务风险，不一刀切
- `[HUMAN GATE]` 前必须真正停机等人工确认，不允许继续调用后续角色或顺手做别的
- 流程卡住时优先保证闭环，而不是硬守形式

## 能力门

开工前判断环境是否暴露子代理 / delegation 工具。

- 工具可用 → 默认启用子代理模式，按车道决定拉哪些角色
- 工具不可用 → 声明 `Capability Gate → Single-agent serial fallback`，按角色顺序串行执行，仍保留角色边界和 TASK 回写

串行 fallback 时角色职责边界不变，只是由主控依次扮演各角色。

## 执行车道

开工前必须落盘 `Lane Decision`（Fast / Standard / Strict）和 `Plan Gate`（Required / Skipped），否则不算完成判定。

| | Fast | Standard | Strict |
|---|---|---|---|
| **适用** | ≤2 文件小修；不改协议/权限/部署/迁移 | 3-10 文件；普通功能开发 | 改协议/权限/迁移/部署；跨里程碑；高并行风险 |
| **子代理组合** | generator + evaluator | planner → generator → evaluator | planner → generator → evaluator ↔ fixer |
| **planner** | 不拉 | 默认启用（TASK 卡 Plan 已有内容且清晰时可跳过） | 必须 |
| **Plan Review** | 默认跳过 | 必须 | 必须 |
| **fixer** | 不预拉 | 失败后拉 | 失败后拉，可多轮（≤3） |
| **Sync Review** | 必须 | 必须 | 必须 |
| **BUILD_PLAN 回写** | 不要求 | 按需 | 必须 |
| **下一张 TASK 草案** | — | — | 满足条件时生成，不自动执行 |

**统一流程骨架**（按车道裁剪）：

1. 读 L0 文档（`AGENTS.md` + `STATUS.md` + 当前 TASK）
2. 落盘 Lane Decision + Plan Gate
3. *若 Plan Gate = Required 且 TASK 卡 Plan 段为空*：拉 planner 产出 Plan → `[HUMAN GATE] Plan Review`
4. generator 实现 → 写 `Changed Files / Execution Evidence` → 输出 `Exit status: Done / Blocked / Failed`
5. 主控确认 generator 写入后，放行 evaluator
6. evaluator 验证 → 写 `Verify / Review` → 输出 `Next action: Sync Review / Pull fixer / Blocked`
7. *若 Next action = Pull fixer*：拉 fixer → 修复后回交 evaluator（≤3 轮）
8. `[HUMAN GATE] Sync Review`
9. 主控更新 TASK + STATUS（Strict 额外更新 BUILD_PLAN）

> Plan Gate = Skipped 时，generator 直接读 TASK 卡的 `Scope / Done when / Files Involved`，不等 Plan 段。

### 车道升降档

默认 Standard。以下情况可降到 Fast：
- 从 TASK 卡和代码即可判断、不需冻结方案、可用 Patch Task

以下情况必须升到 Strict：
- 改接口协议/权限/迁移/部署/内容模型、跨 TASK 边界、多角色同时写同一组文件

Fast Lane 仅在范围膨胀、边界不清或用户明确要求时才加 Plan Review。

## 渐进式披露

| 层级 | 文档 | 何时升级 |
|------|------|---------|
| L0 | `AGENTS.md` + `STATUS.md` + 当前 TASK | 默认 |
| L1 | `BUILD_PLAN.md` + 相关代码 | 不知道改哪些文件 |
| L2 | `DECISIONS.md` | 不知道方案选型 |
| L3 | `SPEC.md` | 不知道需求边界 |
| L4 | `WORKSTREAMS.md` | 出现并行/冲突 |

- 能从 TASK 卡和代码直接判断时不要升级
- 同一会话内已确认的上下文默认复用，不每轮重读
- 升级时说明原因；文档与代码冲突时以代码为准，收尾再同步文档

## 角色职责

| 角色 | 核心职责 | 可写范围 | 退出时必须输出 |
|------|---------|----------|---------------|
| planner | 读文档、压缩上下文、产出 Plan | TASK 卡 `Plan` | `Exit status: Done / Blocked` |
| generator | 按 Plan 或 Scope/Done when 实现；轻量自检；不写 Verify、不扩 scope | 任务相关代码与配置 | `Exit status: Done / Blocked / Failed` |
| evaluator | 基于 `Done when` 和实际证据给结论；回传 `Tried / Blocked by / Fallback used / Commands run / Conclusion` | TASK 卡 `Verify / Review` | `Next action: Sync Review / Pull fixer / Blocked` |
| fixer | 只修 evaluator 指出的问题，修完回交复验 | 获授权的失败文件 | `Exit status: Done / Blocked / Failed` |
| 主控 | 车道判定、派发、闭环检查、Sync | `specs/` `BUILD_PLAN.md` `STATUS.md` `WORKSTREAMS.md` | — |

- Fast Lane 默认拉 generator + evaluator 两个子代理
- Standard Lane 默认拉 planner + generator + evaluator；TASK 卡 Plan 段已有内容且清晰时可跳过 planner
- 每个子代理退出前必须先把本角色输出写入 TASK 卡，主控确认写入后再放行下一个
- 不支持 delegation 时立刻切单代理串行，角色边界不变
- 不让多个写入型角色同时改同一组文件

## 验证策略

evaluator 按任务类型查表选最小验证手段（命中即停）：

| 任务类型 | 默认验证 | 不要求 |
|---------|---------|--------|
| UI / 前端交互 | Playwright 或浏览器截图 | 纯静态分析 |
| 后端解析 / 数据处理 | 构建 + 静态命中 + 最小运行时断言 | Playwright |
| 纯文档 / 配置 | 静态检查（格式/链接/完整性） | 构建、运行时、Playwright |
| 样式 / 文案微调 | 构建 + 视觉截图或 diff | Playwright 完整流程 |

跨类型取最高等级；工具不可用时降级并在 `Fallback used` 说明。

**判定标准**：
- `Pass`：关键 `Done when` 已被自动化、手动或等效证据覆盖
- `Fail`：有明确反证
- `Blocked`：环境/权限/依赖缺失且无反证；须说明缺什么、如何手动验证

**静态页面最小验证集**：页面能打开、关键内容存在、控制台无阻断错误、无 fetch/模块脚本/后端依赖。

**工具卡住时**：记录原因 → 最多重试一次 → 降级为更轻验证 → 仍不行标 Blocked。不堆额外复杂验证链。

## Fallback

子代理失败/超时/终止时，主控可重建或退回串行。触发时必须说明：哪个角色失效、采用哪种 fallback、验证范围是否缩减。优先保证闭环。

## Sync

必须更新：`specs/TASK-xxx.md`（执行细节）+ `STATUS.md`（当前指针）。
按需更新：`BUILD_PLAN.md`（仅里程碑级变化）、`DECISIONS.md`、`WORKSTREAMS.md`。

## Patch Task

≤2 文件、不改协议/权限/部署/迁移、不需方案冻结时，可用 Patch Task 替代完整 TASK 卡。
默认 Fast Lane + Plan Gate Skipped。最少字段见 `specs/PATCH-TASK.md` 模板。

## 主控输出结构

```
Plan → Execute → Verify → Review → Sync → Next Task Draft
```
