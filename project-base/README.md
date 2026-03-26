# Project Base

这个目录是可直接复制出去的新项目地基。

复制后，你应该把它当成真实项目根目录来使用。

---

## 包含什么

- `AGENTS.md`
- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `STATUS.md`
- `WORKSTREAMS.md`
- `specs/TASK-001.md`

这些文件是流程骨架，不是业务代码。

---

## 复制出去之后要做什么

1. 把这个目录重命名成你的项目名
2. 先用网页大语言模型补齐：
   - `SPEC.md`
   - `DECISIONS.md`
   - `BUILD_PLAN.md`
   - `specs/TASK-001.md`
3. 进入 coding agent 阶段后，再执行当前任务卡并完成：
   - `Verify / Review`
   - `Sync`
   - `Next Task Draft`
4. 再把真实代码目录加进来，例如：
   - `src/`
   - `app/`
   - `components/`
   - `lib/`
   - `prisma/`
   - `package.json`
   - `.env.example`

如果你是从模板仓库复制出来的，网页模型与 coding agent 的推荐话术可参考仓库根目录的 `PLAYBOOK.md`。

---

## 这些文件分别干什么

- `AGENTS.md`
  约束 coding agent 怎么执行
- `SPEC.md`
  记录需求事实
- `DECISIONS.md`
  记录关键选型
- `BUILD_PLAN.md`
  记录里程碑和验证方式
- `STATUS.md`
  记录当前阶段和下一步
- `WORKSTREAMS.md`
  在多代理模式下记录并行切分、文件所有权和协调方式
- `specs/TASK-001.md`
  记录当前这一轮只做什么

---

## 规则

- 没有 `TASK`，不进入编码
- 没有 `Verify / Review`，不进入下一轮
- 可以生成下一张任务卡草案
- 但不能自动开始执行下一轮
- 多代理模式下，先更新 `WORKSTREAMS.md` 再派发 subagent
