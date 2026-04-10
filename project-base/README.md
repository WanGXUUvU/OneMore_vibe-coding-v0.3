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
3. 进入 coding agent 阶段后，主控调度子代理完成：
   - `planner`：Read → Plan（写入当前 TASK 卡）
   - `generator`：Execute
   - `evaluator`：Verify / Review（写入当前 TASK 卡，并引用执行证据）
   - `fixer`：修复失败项并回交复验
   - 主控：Sync / Next Task Draft 落盘
4. 如果这是空项目，`TASK-001` 可以直接定义为 `Bootstrap Task`，用于创建第一批真实代码和配置
5. 再把真实代码目录扩展下去，例如：
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
- 没有 `Plan`，不大改
- 没有 `Verify / Review`，不进入下一轮
- 不一次性读取全部文档，优先按需加载
- 可以生成下一张任务卡草案，但不能自动开始执行下一轮
- 以 TASK 卡为主要信息中转枢纽
- evaluator ↔ fixer 循环不超过 3 轮
- `STATUS / BUILD_PLAN / WORKSTREAMS / next TASK file` 只由主控更新
- commit / tag 是可选的稳定 checkpoint，不是强制步骤


## 执行证据与工具权限

- `TASK` 中的 `Execution Evidence` 用于记录本轮命令、产物、结果和备注
- 结构化 `Done when` 断言（`assert file exists` / `assert exit 0`）的执行结果也写入此表
- 证据优先服务于 evaluator 复验、fixer 回退和下一轮 agent 快速接手
- 保持最小化，不要求完整日志系统
