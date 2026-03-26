# OneMore_vibe-coding_v0.2

一个最小化的 `vibe coding` 模板仓库。

这个版本只保留两类真正需要的东西：

- 方法说明
- 可直接复制出去作为新项目地基的目录

---

## 最终结构

```text
OneMore_vibe-coding_v0.2/
├── README.md
├── PLAYBOOK.md
├── project-base/
│   ├── AGENTS.md
│   ├── SPEC.md
│   ├── DECISIONS.md
│   ├── BUILD_PLAN.md
│   ├── STATUS.md
│   ├── WORKSTREAMS.md
│   ├── README.md
│   └── specs/
│       └── TASK-001.md
└── examples/
    └── personal-blog.md
```

---

## 每个部分的职责

### `README.md`

模板仓库说明，只讲：

- 这套流程解决什么问题
- 仓库里有什么
- 你应该怎么复制和使用

### `PLAYBOOK.md`

操作手册。

里面收敛了原先分散的 prompts，按阶段告诉你：

- 网页大语言模型该怎么用
- coding agent 该怎么接手
- 当前任务结束后如何形成闭环

### `project-base/`

这是最重要的部分。

它不是“示例文档集合”，而是未来新项目的最小地基。
你以后新开项目时，直接复制这个目录即可。

### `examples/`

只放少量示例，帮助你理解怎么把这套流程套到真实项目。

---

## 为什么不再保留 `prompts/` 和 `templates/`

因为它们对模板仓库有用，但对真实项目过重，而且会和 `project-base/` 重复。

`v0.2` 现在采用的原则是：

- 操作手册集中到 `PLAYBOOK.md`
- 项目骨架集中到 `project-base/`

这样仓库更轻，也更不容易混淆“模板资产”和“项目资产”。

---

## 你怎么使用

### 1. 复制项目地基

把下面这个目录复制出去：

- [project-base](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/project-base)

复制后重命名成你的新项目目录。

### 2. 按 `PLAYBOOK.md` 推进

先用网页大语言模型完成：

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `specs/TASK-001.md`

再切到 `Codex / Claude Code` 完成：

- Execute
- Verify / Review
- Sync
- Next Task Draft
- 如有必要启用 Multi-agent / Subagent

### 3. 把真实代码加进项目目录

例如：

- `src/`
- `app/`
- `components/`
- `lib/`
- `prisma/`
- `package.json`
- `.env.example`

流程文档和代码仓库共存在同一个项目里。

---

## 这套流程的最小闭环

`SPEC -> DECISIONS -> BUILD_PLAN -> TASK -> Execute -> Verify -> Sync -> Next Task Draft`

注意：

- 没有 `TASK`，不进入编码
- 没有 `Verify / Review`，不进入下一轮
- 可以自动生成下一张任务卡草案
- 但不能自动开始执行下一轮

---

## 推荐场景

适合：

- 个人 blog
- docs site
- 小型 SaaS MVP
- 工具站
- 原型验证项目

---

## 示例

参考：

- [personal-blog.md](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/examples/personal-blog.md)

---

## 版本说明

当前版本：`v0.2`

这个版本的目标是：

- 模板仓库尽量轻
- 真实项目地基可直接复制
- 网页模型与 coding agent 的边界明确
