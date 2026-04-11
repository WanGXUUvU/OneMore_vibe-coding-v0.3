# OneMore_vibe-coding_v1.0

一个最小化的 vibe coding 模板。复制 `project-base/` 就能开始干活。

这一版保留了 `v1.0` 的分层结构，但把默认执行方式改成“按风险分级”，不再把最重流程压到所有任务上：

- 先用网页大模型收敛四份文档
- 再把当前 TASK 交给 coding agent 执行
- 一次只推进一个最小闭环
- 任务分成 `Fast Lane / Standard Lane / Strict Lane`
- 只有需要时才启用 `planner`、`fixer` 和 `Plan Review`
- `extensions/` 只是附加物，不干扰主流程

---

## Quick Start

1. 复制 [`project-base/`](./project-base) 到你的新项目目录
2. 打开 [`PLAYBOOK.md`](./PLAYBOOK.md)
3. 先用网页大语言模型补齐：
   - `SPEC.md`
   - `DECISIONS.md`
   - `BUILD_PLAN.md`
   - 普通任务用 `specs/TASK-001.md`
   - 小修任务用 `specs/PATCH-TASK.md`
   - 需要长提示词时，查看 [`WEB-LLM-PROMPTS.md`](./WEB-LLM-PROMPTS.md)
4. 再切到 Codex / Claude Code 执行当前任务卡

推荐接手指令：

```md
请先读取：
- `AGENTS.md`
- `STATUS.md`
- 当前 `specs/TASK-xxx.md`

主控先按渐进式披露读取，不要一次性读完所有文档。先做 `Capability Gate`：确认当前环境是否真的支持 delegation / subagent 工具。只有通过后，才进入多子代理 harness；如果不支持，必须立刻声明 `Single-agent serial fallback`。然后确认当前 `Current Phase`、`Current Gate` 和任务边界后，先判断本轮适合 `Fast Lane / Standard Lane / Strict Lane` 中哪一档，并显式写出 `Lane Decision` 与 `Plan Gate`，再决定是否需要 `planner`、是否需要 `Plan Review`、以及是否需要预先创建 `fixer`。

执行时以 TASK 卡 `Required Reads` 为准：
- `planner` 只在 `Standard / Strict Lane` 默认启用，负责 `Read -> Plan`
- `generator` 负责 `Execute`，只改获授权代码与 `Changed Files`
- `evaluator` 负责 `Verify -> Review`
- `fixer` 只在 evaluator 明确指出失败项后启用

`evaluator <-> fixer` 最多循环 3 轮，超过则标记 `Blocked`。不允许两个写入型角色修改同一组文件。同步遵循最小化原则：默认只更新 `TASK` 和 `STATUS.md`，只有里程碑级变化才更新 `BUILD_PLAN.md`。最终仍由主控输出 `Verify`、`Review`、`Sync` 和 `Next Task Draft`；如果满足 `Ready for Next Task`，由 `planner` 生成下一张任务卡草案，但不要执行。

确认当前 `Current Phase`、`Current Gate` 和任务边界后，再按当前任务卡执行。不要额外探索无关目录、git 状态或上层模板。
```

---

## 目录结构

```text
OneMore_vibe-coding_v1.0/
├── README.md
├── PLAYBOOK.md              ← 短版操作手册（启动 / lane / gate / 接手指令）
├── WEB-LLM-PROMPTS.md       ← 网页大语言模型阶段提示词仓库
├── project-base/            ← core：复制这个目录到新项目
│   ├── AGENTS.md            ← 角色定义与职责
│   ├── SPEC.md              ← 需求规格
│   ├── DECISIONS.md         ← 关键决策记录
│   ├── BUILD_PLAN.md        ← 里程碑拆分
│   ├── STATUS.md            ← 当前状态
│   ├── WORKSTREAMS.md       ← 并行任务配置
│   ├── README.md
│   ├── .gitignore
│   └── specs/
│       ├── TASK-001.md      ← 完整任务卡模板
│       └── PATCH-TASK.md    ← 小修轻量模板
├── extensions/              ← 可选扩展包
│   ├── README.md            ← 扩展包说明与安装指南
│   ├── claude-code/         ← Claude Code 适配
│   │   ├── CLAUDE.md
│   │   └── .claude/agents/
│   │       ├── planner.md
│   │       ├── generator.md
│   │       ├── evaluator.md
│   │       └── fixer.md
│   └── eval-harness/        ← 评估示例
│       └── evals/
│           ├── README.md
│           ├── grader-schema.yaml
│           ├── capability/example.yaml
│           └── regression/example.yaml
```

---

## Core 包含什么

| 文件 | 用途 |
|------|------|
| `AGENTS.md` | coding agent 的运行约定 |
| `SPEC.md` | 需求规格模板 |
| `DECISIONS.md` | 关键决策记录 |
| `BUILD_PLAN.md` | 里程碑拆分 |
| `STATUS.md` | 当前状态追踪 |
| `WORKSTREAMS.md` | 静态角色分工和并行声明 |
| `TASK-001.md` | 完整任务卡模板 |
| `PATCH-TASK.md` | 小修轻量模板 |

---

## 使用主线

最小闭环就是这条线：

`SPEC → DECISIONS → BUILD_PLAN → TASK/Patch Task → capability gate → lane select → generator / planner → evaluator / fixer → [HUMAN GATE] → Sync`

默认按 `Standard Lane` 执行，不默认走最重流程。`Plan Review` 也不是默认门，只在 `Standard / Strict` 默认要求。

启动时主控应先按渐进式披露读 L0，先判断当前任务该走哪条车道，再按需创建角色。每个角色都以 TASK 卡里的 `Required Reads` 为输入边界，只写自己负责的段落或文件，不重读无关文档，不改不属于自己的内容。

执行顺序按车道变化：`Fast Lane` 默认 `generator -> evaluator`；`Standard Lane` 默认 `planner -> generator -> evaluator`；`Strict Lane` 再加入 `fixer` 循环。`evaluator <-> fixer` 最多循环 3 轮，超过就标记 `Blocked`。任何两个写入型角色都不能同时改同一组文件。

最终仍由主控负责整理并输出 `Verify`、`Review`、`Sync` 和 `Next Task Draft`。如果本轮满足 `Ready for Next Task`，由 `planner` 生成下一张任务卡草案，但不自动执行。

- 没有 TASK，不编码
- 没有 Plan，不做中高风险改动
- 没有 Verify / Review，不进入下一轮
- evaluator 自己根据证据判断，不依赖脚本

---

## 扩展

大多数项目只需要 `project-base/`。

如果你需要：

| 能力 | 扩展包 |
|------|--------|
| Claude Code 子代理 | `claude-code/` |
| Eval 示例结构（YAML / grader schema） | `eval-harness/` |

详见 [extensions/README.md](./extensions/README.md)。
