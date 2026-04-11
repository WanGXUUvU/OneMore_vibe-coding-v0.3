# WEB-LLM-PROMPTS

这是一份网页大语言模型阶段的提示词仓库。

用途：
- 补齐 `SPEC.md`
- 冻结 `DECISIONS.md`
- 生成 `BUILD_PLAN.md`
- 生成 `specs/TASK-001.md`

这个文件只服务于“网页模型阶段”。  
真正执行流程请看 [PLAYBOOK.md](./PLAYBOOK.md)。

## 1. 补全 `SPEC.md`

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

## 2. 冻结 `DECISIONS.md`

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

## 3. 生成 `BUILD_PLAN.md`

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

## 4. 生成 `TASK-001.md`

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
