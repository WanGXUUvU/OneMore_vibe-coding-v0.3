# PLAYBOOK

这是一份操作手册，不是项目文档。

## A. 新项目怎么开始

1. 复制 [`project-base/`](./project-base) 到新的项目目录
2. 打开新项目目录
3. 先不要写代码
4. 先让网页大语言模型把项目收敛到 `TASK-001`
5. 再切到 `Codex / Claude Code`

---

## B. 网页大语言模型阶段

这个阶段只负责产出文档，不写代码。

顺序固定：

1. `SPEC.md`
2. `DECISIONS.md`
3. `BUILD_PLAN.md`
4. `specs/TASK-001.md`

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
5. 如果 Blocking Open Questions 非空，不允许输出 Ready for Decisions
6. 输出时额外说明：
   - 当前仍缺什么信息会影响实现
   - 当前先采用了哪些假设
   - 本轮结束后冻结了什么
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
- 本轮结束后明确冻结了什么
- 如果当前不冻结，会导致哪些实现分叉

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
3. 单张 TASK 的预期变更范围不超过 10 个文件
4. 必须包含：
   - Goal
   - Context
   - In Scope
   - Out of Scope
   - Constraints
   - Task Source
   - Required Reads
   - Files Involved
   - Done when
   - Plan
   - Verify
   - Review
   - Review Focus
   - Notes for Next Task
5. 完成后明确输出：Ready for Execute
6. 如任务是纯静态页面，`Done when` 与 `Plan` 里的自动化验证默认通过临时本地静态 server 执行，不直接要求 Playwright 访问 `file://`
```

---

## C. Coding Agent 阶段

默认流程：

1. 主控读取 `AGENTS.md`、`STATUS.md`、当前 `TASK`
2. 一次性拉起 `planner / generator / evaluator / fixer`
3. `planner` 先产出 Plan
4. 到 `[HUMAN GATE] Plan Review`
5. `generator` 实现
6. `evaluator` 验证
7. 如有失败项，`fixer` 修复后回到 `evaluator`
8. 到 `[HUMAN GATE] Sync Review`
9. 主控更新 `TASK / BUILD_PLAN / STATUS`
10. 如满足条件，生成下一张 TASK 草案，但不执行

纯静态页面验证补充规则：

- 自动化浏览器验证默认通过临时本地静态 server 执行
- 不直接要求 Playwright MCP 访问 `file://`
- `file://` 直开能力通过静态约束检查与必要的手动验证保证
- 如果 MCP 环境阻止 `file://`，记录原因，不得仅因此判任务失败

两个必须停下来的点：

- `Plan Review`
- `Sync Review`

停下来的意思是：

- 到 `Plan Review` 后，立刻停止实现、验证、修复、同步和继续扩上下文
- 到 `Sync Review` 后，立刻停止同步、生成下一轮内容和继续探索其他文件
- 只能输出当前结论和等待说明，不能顺手做别的收尾动作
- 必须等你明确回复 `继续` 才能往下走

### 接手指令

网页阶段完成后，直接发给 Codex / Claude Code：

```md
请先读取：
- `AGENTS.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`

现在使用多子代理 harness 执行当前任务。

主控先按渐进式披露读取，不要一次性读完所有文档。确认当前 `Current Phase`、`Current Gate` 和任务边界后，先更新 `WORKSTREAMS.md`，写清本轮角色分工、输入边界、输出位置、文件所有权和禁止事项，再显式拉起 `planner / generator / evaluator / fixer` 四个角色。

执行时以 TASK 卡 `Required Reads` 为准：
- `planner` 负责 `Read -> Plan`，只写 TASK 卡 `Plan`
- `generator` 负责 `Execute`，只改获授权代码与 `Changed Files`
- `evaluator` 负责 `Verify -> Review`
- `fixer` 只修 evaluator 明确指出的失败项

`evaluator <-> fixer` 最多循环 3 轮，超过则标记 `Blocked`。不允许两个写入型角色修改同一组文件。最终仍由主控输出 `Verify`、`Review`、`Sync` 和 `Next Task Draft`；如果满足 `Ready for Next Task`，由 `planner` 生成下一张任务卡草案，但不要执行。

确认当前 `Current Phase`、`Current Gate` 和任务边界后，再按当前任务卡执行。不要额外探索无关目录、git 状态或上层模板。
```

补充要求：

- 只探索当前 TASK 直接相关的文档和代码
- 不为 git、上层模板、其他示例、无关目录做额外探索
- 到 `[HUMAN GATE]` 时必须真正停机，不能继续往后执行，也不能顺手做别的探索或收尾

### 单代理 fallback

如果多子代理不稳定，就直接退回单代理串行：

```md
请先读取：
- `AGENTS.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`

确认当前 `Current Phase`、`Current Gate` 和任务边界后，再按 planner → generator → evaluator → fixer 的顺序串行执行当前任务。不要额外探索无关目录、git 状态或上层模板。
```

### 何时回退到规划层

如果执行中发现以下情况之一，不要硬做，直接回到网页模型阶段：

- 当前 TASK 太大
- 关键前提在规划阶段漏了
- `SPEC / DECISIONS / BUILD_PLAN` 与代码现实直接冲突
- 当前技术约束根本无法支持实现
