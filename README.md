# OneMore_vibe-coding_v1.0

一个最小化的 vibe coding 模板。复制 `project-base/` 就能开始干活。

这一版保留了 `v1.0` 的分层结构，但把主线重新收回到 `v0.7` 那种更直接的使用方式：

- 先用网页大模型收敛四份文档
- 再把当前 TASK 交给 coding agent 执行
- 一次只推进一个最小闭环
- 主控在两个 `[HUMAN GATE]` 节点停下等你确认
- `extensions/` 只是附加物，不干扰主流程

---

## Quick Start

1. 复制 [`project-base/`](./project-base) 到你的新项目目录
2. 打开 [`PLAYBOOK.md`](./PLAYBOOK.md)
3. 先用网页大语言模型补齐：
   - `SPEC.md`
   - `DECISIONS.md`
   - `BUILD_PLAN.md`
   - `specs/TASK-001.md`
4. 再切到 Codex / Claude Code 执行当前任务卡

推荐接手指令：

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

---

## 目录结构

```text
OneMore_vibe-coding_v1.0/
├── README.md
├── PLAYBOOK.md              ← 操作手册（网页 LLM → coding agent 全流程）
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
│       └── TASK-001.md      ← 任务卡模板
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
└── examples/
    └── personal-blog.md
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
| `TASK-001.md` | 任务卡模板 |

---

## 使用主线

最小闭环就是这条线：

`SPEC → DECISIONS → BUILD_PLAN → TASK → planner → [HUMAN GATE] → generator → evaluator / fixer → [HUMAN GATE] → Sync`

默认按多子代理 harness 执行当前任务。

启动时主控应先按渐进式披露读 L0，先把 `WORKSTREAMS.md` 里的本轮分工和文件边界写清楚，再拉起 `planner / generator / evaluator / fixer` 四个角色。每个角色都以 TASK 卡里的 `Required Reads` 为输入边界，只写自己负责的段落或文件，不重读无关文档，不改不属于自己的内容。

执行顺序保持不变：`planner` 先把 `Plan` 写回 TASK 卡，`generator` 再实现，`evaluator` 负责 `Verify / Review`，`fixer` 只修 evaluator 点名的问题。`evaluator <-> fixer` 最多循环 3 轮，超过就标记 `Blocked`。任何两个写入型角色都不能同时改同一组文件。

最终仍由主控负责整理并输出 `Verify`、`Review`、`Sync` 和 `Next Task Draft`。如果本轮满足 `Ready for Next Task`，由 `planner` 生成下一张任务卡草案，但不自动执行。

- 没有 TASK，不编码
- 没有 Plan，不大改
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
