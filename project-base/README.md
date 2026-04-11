# Project Base

这个目录是可直接复制出去的新项目地基。

复制后，你应该把它当成真实项目根目录来使用。

---

## 包含什么

- `AGENTS.md` — coding agent 的运行约定
- `SPEC.md` — 记录需求事实
- `DECISIONS.md` — 记录关键选型
- `BUILD_PLAN.md` — 记录里程碑和验证方式
- `STATUS.md` — 记录当前阶段、下一步和历史轨迹
- `WORKSTREAMS.md` — 并行或冲突时才重点使用的备用文档
- `.gitignore` — 最小的项目忽略规则起点
- `specs/TASK-001.md` — 当前这一轮只做什么，并记录本轮执行证据

---

## 复制出去之后要做什么

1. 把这个目录重命名成你的项目名
2. 先用网页大语言模型补齐：
   - `SPEC.md`
   - `DECISIONS.md`
   - `BUILD_PLAN.md`
   - `specs/TASK-001.md`
3. 进入 coding agent 阶段后，先判断当前 TASK 属于哪条车道：
   - `Fast Lane`：小修，默认 `generator -> evaluator`
   - `Standard Lane`：普通功能，默认 `planner -> generator -> evaluator`
   - `Strict Lane`：高风险改动，再加入 `fixer` 循环
4. 主控只按需启用角色：
   - `planner`：只在 `Standard / Strict Lane` 默认启用
   - `generator`：Execute
   - `evaluator`：Verify / Review（写入当前 TASK 卡，并引用执行证据）
   - `fixer`：只在验证失败后启用
   - 主控：Sync / Next Task Draft 落盘
5. 如果这是空项目，`TASK-001` 可以直接定义为 `Bootstrap Task`，用于创建第一批真实代码和配置
6. 再把真实代码目录扩展下去，例如：
   - `src/`
   - `app/`
   - `components/`
   - `lib/`
   - `prisma/`
   - `package.json`
   - `.env.example`

推荐话术参考仓库根目录的 `PLAYBOOK.md`。
网页版 LLM 阶段结束后，由你把执行指令直接发给 Codex / Claude Code；不要依赖仓库内占位启动脚本判断 agent 是否真正开始执行。

---

## 规则

- 没有 `TASK`，不进入编码
- 没有 `Plan`，不做中高风险改动
- 没有 `Verify / Review`，不进入下一轮
- 不一次性读取全部文档，优先按需加载
- 可以生成下一张任务卡草案，但不能自动开始执行下一轮
- 以 TASK 卡为主要信息中转枢纽
- evaluator ↔ fixer 循环不超过 3 轮
- `STATUS / BUILD_PLAN / WORKSTREAMS / next TASK file` 只由主控更新
- `BUILD_PLAN.md` 只记录里程碑级变化，不要求每张小卡都回写
- commit / tag 是可选的稳定 checkpoint，不是强制步骤


## 执行证据与工具权限

- `TASK` 中的 `Execution Evidence` 用于记录本轮命令、产物、结果和备注
- 结构化 `Done when` 断言（`assert file exists` / `assert exit 0`）的执行结果也写入此表
- 证据优先服务于 evaluator 复验、fixer 回退和下一轮 agent 快速接手
- 保持最小化，不要求完整日志系统
