# PLAYBOOK

这是一份短版执行手册，不是提示词仓库。

如果你要网页大语言模型阶段的完整提示词，去看 [WEB-LLM-PROMPTS.md](./WEB-LLM-PROMPTS.md)。

## A. 新项目怎么开始

1. 复制 [`project-base/`](./project-base) 到新的项目目录
2. 先不要写代码
3. 用网页大语言模型补齐：
   - `SPEC.md`
   - `DECISIONS.md`
   - `BUILD_PLAN.md`
   - `specs/TASK-001.md` 或 `specs/PATCH-TASK.md`
4. 再切到 `Codex / Claude Code`
5. 让 coding agent 接手当前 TASK

## B. 网页大语言模型阶段

这个阶段只负责产出文档，不写代码。

固定顺序：
1. `SPEC.md`
2. `DECISIONS.md`
3. `BUILD_PLAN.md`
4. `specs/TASK-001.md` 或 `specs/PATCH-TASK.md`

完整提示词见：
- [WEB-LLM-PROMPTS.md](./WEB-LLM-PROMPTS.md)

## C. Coding Agent 阶段

先判断当前任务属于哪条车道，再决定流程。

### Fast Lane

适用：
- 1 到 2 个文件的小修
- 不改 API 契约、数据模型、权限、部署、迁移

流程：
1. 主控读取 `AGENTS.md`、`STATUS.md`、当前 `TASK`
2. 显式写出 `Lane Decision = Fast`、`Plan Gate = Skipped`
3. `generator` 直接读 `Scope / Done when / Files Involved` 实现（不走 planner，不读 Plan 段）
4. `evaluator` 验证
5. 到 `[HUMAN GATE] Sync Review`
6. 主控更新 `TASK / STATUS`

### Standard Lane

适用：
- 普通功能开发
- 需要先冻结实现边界，但不属于高风险改动

流程：
1. 主控读取 `AGENTS.md`、`STATUS.md`、当前 `TASK`
2. 拉起 `planner`
3. 显式写出 `Lane Decision = Standard`、`Plan Gate = Required`
4. `planner` 先产出 `Plan`
5. 到 `[HUMAN GATE] Plan Review`
6. `generator` 实现
7. `evaluator` 验证
8. 如有失败项，再放行 `fixer`
9. 到 `[HUMAN GATE] Sync Review`
10. 主控更新 `TASK / STATUS`，必要时更新 `BUILD_PLAN.md`

### Strict Lane

适用：
- 改 API 契约、权限、迁移、部署、数据模型
- 并行写入风险高

流程：
1. 主控读取 `AGENTS.md`、`STATUS.md`、当前 `TASK`
2. 拉起 `planner`
3. 显式写出 `Lane Decision = Strict`、`Plan Gate = Required`
4. `planner` 先产出 `Plan`
5. 到 `[HUMAN GATE] Plan Review`
6. `generator` 实现
7. `evaluator` 验证
8. 如有失败项，`fixer` 修复后回到 `evaluator`
9. 到 `[HUMAN GATE] Sync Review`
10. 主控更新 `TASK / BUILD_PLAN / STATUS`
11. 如满足条件，生成下一张 TASK 草案，但不执行

### Patch Task

适用：
- 1 到 2 个文件的小修
- 只需要快速收口，不值得走完整 TASK 卡

默认：
- `Fast Lane`
- `Plan Gate = Skipped`

流程：
1. 主控读取 `AGENTS.md`、`STATUS.md`
2. 创建或复用 `Patch Task`
3. `generator` 实现
4. `evaluator` 验证
5. 到 `[HUMAN GATE] Sync Review`
6. 主控更新 `Patch Task / STATUS`

## D. 什么时候必须停

两个必须停下来的点：
- `Plan Review`（仅 `Standard / Strict` 默认要求，或 `Fast` 但用户明确要求）
- `Sync Review`

停下来的意思：
- 到 `Plan Review` 后，立刻停止实现、验证、修复、同步和继续扩上下文
- 到 `Sync Review` 后，立刻停止同步、生成下一轮内容和继续探索其他文件
- 只能输出当前结论和等待说明，不能顺手做别的收尾动作
- 必须等你明确回复 `继续` 才能往下走

## E. 接手指令

网页阶段完成后，直接发给 Codex / Claude Code：

```md
请先读取：
- `AGENTS.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`

本次会话允许你使用子代理并行执行，不需要再次确认。

主控先按渐进式披露读取，不要一次性读完所有文档。先做 `Capability Gate`：确认当前环境是否真的支持 delegation / subagent 工具。只有通过后，才进入多子代理 harness；如果不支持，必须立刻声明 `Single-agent serial fallback`。然后确认当前 `Current Phase`、`Current Gate` 和任务边界，再判断本轮适合 `Fast Lane / Standard Lane / Strict Lane` 中哪一档，并显式写出 `Lane Decision` 与 `Plan Gate`，再决定是否需要 `planner`、是否需要 `Plan Review`、以及是否需要预先创建 `fixer`。

执行时以 TASK 卡 `Required Reads` 为准：
- `planner` 只在 `Standard / Strict Lane` 默认启用，负责 `Read -> Plan`
- `generator` 负责 `Execute`，只改获授权代码与 `Changed Files`
- `evaluator` 负责 `Verify -> Review`
- `fixer` 只在 evaluator 明确指出失败项后启用

`evaluator <-> fixer` 最多循环 3 轮，超过则标记 `Blocked`。不允许两个写入型角色修改同一组文件。同步遵循最小化原则：默认只更新 `TASK` 和 `STATUS.md`，只有里程碑级变化才更新 `BUILD_PLAN.md`。最终仍由主控输出 `Verify`、`Review`、`Sync`；仅 `Strict Lane` 在满足 `Ready for Next Task` 时，由 `planner` 生成下一张任务卡草案，但不要执行。

确认当前 `Current Phase`、`Current Gate` 和任务边界后，再按当前任务卡执行。不要额外探索无关目录、git 状态或上层模板。
```

## F. 单代理 Fallback

如果多子代理不稳定，就直接退回单代理串行：

```md
请先读取：
- `AGENTS.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`

确认当前 `Current Phase`、`Current Gate` 和任务边界后，先做 `Capability Gate`，然后判断本轮属于 `Fast Lane / Standard Lane / Strict Lane` 哪一档，并显式写出 `Lane Decision` 与 `Plan Gate`，再按对应角色顺序串行执行。不要额外探索无关目录、git 状态或上层模板。
```

## G. 何时回退到规划层

如果执行中发现以下情况之一，不要硬做，直接回到网页模型阶段：
- 当前 TASK 太大
- 关键前提在规划阶段漏了
- `SPEC / DECISIONS / BUILD_PLAN` 与代码现实直接冲突
- 当前技术约束根本无法支持实现
