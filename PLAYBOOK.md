# PLAYBOOK

这是一份操作手册，不是项目文档。

使用原则：

- 网页大语言模型负责规划
- coding agent 负责执行
- 每次只推进一个最小闭环

---

## A. 新项目怎么开始

1. 复制 [project-base](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/project-base) 到新的项目目录
2. 打开新项目目录
3. 先不要写代码
4. 先让网页大语言模型把项目收敛到 `TASK-001`
5. 再切到 `Codex / Claude Code`

---

## B. 网页大语言模型阶段

这个阶段只负责产出文档，不写仓库代码。

### 1. 补全 `SPEC.md`

发给网页模型：

```md
先不要写代码。

我要补全当前项目的 `SPEC.md`。
请通过对话收敛：
- Goal
- Context
- Constraints
- Done when
- Out of Scope
- Assumptions
- Open Questions

要求：
1. 每轮最多问 3 个最关键问题
2. 每轮输出当前 SPEC 摘要
3. 将 Open Questions 区分为：
   - Blocking
   - Non-blocking
4. 如果信息足够进入关键决策阶段，请明确输出：Ready for Decisions
```

### 2. 冻结 `DECISIONS.md`

发给网页模型：

```md
基于当前 `SPEC.md`，现在不要写代码。

请冻结会阻塞执行的关键决策，并更新 `DECISIONS.md`。

输出时请包含：
- 决策项
- 备选方案
- 推荐方案
- 推荐理由
- 对当前阶段的影响

如果足够进入 BUILD_PLAN 阶段，请明确输出：Ready for Build Plan
```

### 3. 生成 `BUILD_PLAN.md`

发给网页模型：

```md
请基于：
- `SPEC.md`
- `DECISIONS.md`

生成 `BUILD_PLAN.md`。

要求：
1. 保持 MVP 范围
2. 拆成 3 到 5 个可验证里程碑
3. 每个里程碑都要包含：
   - Goal
   - Scope
   - Files involved
   - Risks
   - Verify
   - Exit criteria
4. 明确当前应该先做哪个里程碑
5. 完成后输出：Ready for Task
```

### 4. 生成 `TASK-001.md`

发给网页模型：

```md
请读取：
- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`

现在不要写代码。

请为当前最小闭环里程碑生成 `specs/TASK-001.md`。

要求：
1. 只覆盖当前这一轮
2. 不跨下一个里程碑
3. 必须包含：
   - Goal
   - Context
   - In Scope
   - Out of Scope
   - Constraints
   - Files Involved
   - Done when
   - Plan
   - Verify
   - Review Focus
   - Blocked By
   - Status
4. 完成后明确输出：Ready for Execute
```

---

## C. Coding Agent 阶段

这一阶段才切到 `Codex / Claude Code`。

### 1. 执行当前任务卡

发给 coding agent：

```md
请读取：
- `AGENTS.md`
- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`

现在只执行当前任务卡。

要求：
1. 先输出 Plan，不要直接改代码
2. Plan 至少包含：
   - 本轮目标
   - 涉及文件
   - 实现步骤
   - 风险点
   - 验证方式
3. 未经说明，不要跨任务卡或跨里程碑
```

标准单代理话术：

```md
请读取：
- `AGENTS.md`
- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `specs/TASK-001.md`

现在使用 Single Agent 模式执行当前任务。

要求：
1. 先输出 Plan，不要直接改代码
2. Plan 必须包含：
   - 本轮目标
   - 涉及文件
   - 实现步骤
   - 风险点
   - 验证方式
3. 未经说明，不要跨任务卡或跨里程碑
4. 完成后输出 `Verify / Review`
5. 最后同步更新：
   - `specs/TASK-001.md`
   - `BUILD_PLAN.md`
   - `STATUS.md`
6. 如果满足 `Ready for Next Task`，请生成下一张任务卡草案，但不要执行
```

### 1.1 什么时候切到多代理

只有满足以下任意两项，才建议从单代理切到 `Multi-agent / Subagent`：

- 当前任务跨两个以上模块
- 需要大范围只读探索
- 需要把实现和验证分离
- 存在可并行的独立子任务
- 单轮预计会改动很多文件，主上下文容易失控

如果只是单页面、小闭环、小范围改动，继续保持单代理。

### 1.2 多代理模式怎么开

先由主控 agent 读取：

- `AGENTS.md`
- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`
- `WORKSTREAMS.md`

然后发给 coding agent：

```md
请使用 Multi-agent / Subagent 模式执行当前任务。

要求：
1. 先不要写代码，先给出并行切分方案
2. 先更新 `WORKSTREAMS.md`
3. 必须明确：
   - Coordinator 负责什么
   - 哪些子任务可以并行
   - 每个 subagent 的文件所有权
   - 哪些工作必须由主控整合
4. 不允许两个 subagent 修改同一组文件
5. 完成切分后，再分别执行：
   - 只读探索
   - 实现
   - 验证 / Review
6. 最终仍由主控 agent 输出 Verify / Review / Sync / Next Task Draft
```

标准多代理话术：

```md
请读取：
- `AGENTS.md`
- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `WORKSTREAMS.md`
- `specs/TASK-001.md`

现在使用 Multi-agent / Subagent 模式执行当前任务。

要求：
1. 先不要写代码，先给出并行切分方案
2. 先更新 `WORKSTREAMS.md`
3. 明确：
   - Coordinator 负责什么
   - 哪些任务可以并行
   - 每个 subagent 的文件所有权
   - 哪些工作必须由主控整合
4. 不允许两个 subagent 修改同一组文件
5. 完成切分后再执行
6. 最终仍由主控输出：
   - `Verify`
   - `Review`
   - `Sync`
   - `Next Task Draft`
7. 如果满足 `Ready for Next Task`，请生成下一张任务卡草案，但不要执行
```

### 2. 收尾 Verify / Review

发给 coding agent：

```md
请对刚完成的当前任务输出：

## Verify
- 运行了哪些测试 / lint / typecheck / build
- 哪些验证通过
- 哪些验证无法执行
- 手动验证步骤

## Review
- 是否满足 `Done when`
- 是否扩了 scope
- 是否有回归风险
- 是否存在边界条件遗漏
- 是否需要更新 `SPEC / DECISIONS / BUILD_PLAN / TASK / STATUS`
- 是否满足 `Ready for Next Task`

请明确标记：
- `Pass / Fail / Blocked`
- `Ready for Next Task: Yes / No`
- `Risks / Open items`
```

### 3. 同步状态并生成下一张任务卡草案

发给 coding agent：

```md
请根据刚完成的当前任务，同步更新以下文档：

- `specs/TASK-xxx.md`
- `BUILD_PLAN.md`
- `STATUS.md`

如有必要，再建议是否更新：

- `SPEC.md`
- `DECISIONS.md`

要求：
1. 更新当前任务状态
2. 更新当前里程碑进度
3. 更新当前阶段与下一步
4. 明确判断是否满足：
   - `Ready for Next Task = Yes / No`
5. 如果 `Ready for Next Task = No`：
   - 说明阻塞原因
   - 不生成下一张任务卡
   - 停止
6. 如果 `Ready for Next Task = Yes`：
   - 生成下一张任务卡草案，例如 `specs/TASK-002.md`
   - 更新 `STATUS.md` 中的 `Next Task Candidate`
   - 只生成，不执行
7. 生成后停止，等我确认是否执行下一轮
```

---

## D. 一个任务何时算闭环

以下全部满足，才算闭环：

- 当前任务已有 `Pass / Fail / Blocked`
- 当前任务状态已写回任务卡
- `BUILD_PLAN.md` 已更新进度
- `STATUS.md` 已写清楚下一步
- 已判断是否 `Ready for Next Task`

如果满足：

- 可以生成下一张任务卡草案
- 但不允许自动执行下一轮

---

## E. 什么时候回写上游文档

- 需求边界变了：更新 `SPEC.md`
- 关键选型变了：更新 `DECISIONS.md`
- 里程碑拆法变了：更新 `BUILD_PLAN.md`
- 当前轮目标或结果变了：更新当前 `TASK`
- 当前阶段变了：更新 `STATUS.md`

---

## F. 多代理模式的最小规则

如果启用 `Multi-agent / Subagent`，至少遵守：

- 主控 agent 负责读文档、切任务、整合结果、更新文档
- explorer 只读，不改文件
- implementer 只能改自己负责的文件集合
- reviewer / verifier 不重写需求，只做验证与审查
- 任何并行写入都必须事先写到 `WORKSTREAMS.md`
- 最终闭环仍然只有一个出口：
  - 主控 agent 输出 `Verify / Review / Sync / Next Task Draft`
