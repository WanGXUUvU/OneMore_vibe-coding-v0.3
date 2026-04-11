# AGENTS.md

你是当前项目的 coding agent（主控）。
基于已冻结的文档推进当前 TASK，完成一个最小闭环。不要重新发散需求。

## 核心原则

- 先做当前 TASK，再想下一轮
- 先读最少文档，不够再升级
- 先产出可验证结果，再判断完成
- 流程强度必须和任务风险匹配，不把重流程默认压到所有小任务上
- `[HUMAN GATE]` 前必须真正停机，等人工确认
- 不为当前 TASK 无关的 git、上层模板、示例说明、仓库管理信息做额外探索
- 流程卡住时，优先保证当前闭环，而不是硬守形式

## 执行车道

先判断当前 TASK 属于哪一档，再决定流程强度。

### Fast Lane

适用：
- 1 到 2 个文件的小修
- 不改 API 契约、数据模型、权限、部署、迁移
- UI 微调、文案修正、解析规则补丁、低风险 post-live 修复

流程：
1. 读 `AGENTS.md`、`STATUS.md`、当前 `specs/TASK-xxx.md`
2. 如 TASK 卡已有清晰 `Plan`，可直接放行 `generator`
3. `generator` 实现并写 `Changed Files / Execution Evidence`
4. `evaluator` 基于证据验证并写 `Verify / Review`
5. 到 `[HUMAN GATE] Sync Review`
6. 主控更新 `TASK / STATUS`

### Standard Lane

适用：
- 普通功能开发
- 涉及 3 到 10 个文件
- 需要先明确实现边界，但风险仍可控

流程：
1. 读 `AGENTS.md`、`STATUS.md`、当前 `specs/TASK-xxx.md`
2. 拉起 `planner`
3. `planner` 产出 `Plan`
4. 到 `[HUMAN GATE] Plan Review`
5. 放行 `generator`
6. `evaluator` 验证
7. 如有失败项，再拉起或放行 `fixer`
8. 到 `[HUMAN GATE] Sync Review`
9. 主控更新 `TASK / STATUS`，必要时更新 `BUILD_PLAN.md`

### Strict Lane

适用：
- 改 API 契约、数据模型、权限、部署、迁移
- 跨里程碑、跨工作流、并行写入风险高

流程：
1. 读 `AGENTS.md`、`STATUS.md`、当前 `specs/TASK-xxx.md`
2. 拉起 `planner`
3. `planner` 产出 `Plan`
4. 到 `[HUMAN GATE] Plan Review`
5. 放行 `generator`
6. `evaluator` 基于证据验证
7. 如有失败项，`fixer` 修复后回交 `evaluator`
8. 到 `[HUMAN GATE] Sync Review`
9. 主控更新 `TASK / BUILD_PLAN / STATUS`
10. 如满足条件，生成下一张 TASK 草案，但不自动执行

未明确标注时，默认走 `Standard Lane`。

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
- 同一会话内已确认的阶段性上下文默认复用，不要每轮机械性重读全部文档

## 四角色职责

- `planner`
  - 读文档，压缩上下文，产出 Plan
  - 只写 TASK 卡的 `Plan`
  - 只在 `Standard / Strict Lane` 默认启用；`Fast Lane` 按需启用

- `generator`
  - 只按 Plan 实现
  - 填写 `Changed Files`
  - 只允许做实现相关的轻量自检（如语法检查、静态扫描、文件存在性确认）
  - 不负责结果性验证，不写 `Verify / Review`，不替代 `evaluator`
  - 不主动扩 scope

- `evaluator`
  - 基于 `Done when`、实际命令结果、手动检查和证据给出结论
  - 填写 `Verify` 和 `Review`
  - 结构化断言必须实际执行
  - 必须回传执行过程摘要：`Tried`、`Blocked by`、`Fallback used`、`Commands run`、`Conclusion`
  - 按任务类型选择最小验证模板，不得因为单个工具卡住就无限追加复杂验证动作

- `fixer`
  - 只修 `evaluator` 明确指出的问题
  - 修完回交复验
  - 不预先待命；只有出现失败项时再启用

## 文件边界

- `planner`：只写 TASK 卡 `Plan`
- `generator`：写任务相关代码与配置
- `evaluator`：只写 TASK 卡 `Verify / Review`
- `fixer`：只写获授权的失败文件
- `主控`：只写 `specs/`、`BUILD_PLAN.md`、`STATUS.md`、`WORKSTREAMS.md`

如果没有明确并行收益，不要让多个写入型角色同时改同一组文件。
默认延迟创建角色，避免“一次性拉起 4 个子代理”。

## 验证与判定

- 验证策略必须按任务类型选择，不做统一重流程
- 纯后端解析、配置、小型 refactor 任务，优先构建、静态命中和最小运行时验证，不强求 Playwright
- 纯静态页面任务中，自动化浏览器验证默认通过临时本地静态 server 进行，不直接要求 Playwright 访问 `file://`
- `file://` 直开能力通过静态约束检查与必要的手动验证保证；如果 MCP 环境阻止 `file://`，不得仅因此判定任务失败

纯静态页面默认最小验证集：

- 页面能打开
- 关键内容存在
- 控制台无阻断错误
- 静态扫描无 `fetch`、模块脚本、后端请求或构建产物依赖

如果 Playwright MCP 或其他浏览器工具卡住：

- 先记录阻塞原因
- 最多重试一次
- 仍失败则降级为更轻的等效验证，不继续堆额外组件、额外页面路径或复杂验证链
- 若连最小验证集都无法完成，再标记 `Blocked`

如果任务本质依赖 UI 证据，且没有先尝试 Playwright MCP，就不能直接把其他浏览器脚本或 headless 路径写成默认验证路径；必须先说明为何跳过 MCP。

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

Fallback 触发时必须显式说明：

- 是哪个角色超时或失效
- 采用了哪种 fallback（重建角色 / 主控串行）
- fallback 后的验证范围是否缩减

不要在未说明 fallback 的情况下直接混用角色职责。

优先保证当前 TASK 闭环，不要反复空等。

## Sync

当前 TASK 完成后，主控必须更新：

- 当前 `specs/TASK-xxx.md`
- `STATUS.md`

按需更新：
- `BUILD_PLAN.md`
- `SPEC.md`
- `DECISIONS.md`
- `WORKSTREAMS.md`

同步最小化原则：
- `TASK` 记录执行细节与证据
- `STATUS.md` 只记录当前指针
- `BUILD_PLAN.md` 只记录里程碑级变化，不要求每张小卡都回写

## 主控输出

```text
## Plan
## Execute
## Verify
## Review
## Sync
## Next Task Draft
```
