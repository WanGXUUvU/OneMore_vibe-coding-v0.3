# Minimal Blog Demo

这是一个示例项目目录，用来演示 `PLAYBOOK.md` 里“网页大语言模型阶段”如何把一个最小 blog 收敛成可执行任务。

当前它处于初始化状态，只有文档骨架，没有业务实现。

目标是把最小 blog 的执行输入冻结为：

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `specs/TASK-001.md`

这个 demo 刻意收敛为最小范围：

- 纯前端静态 blog
- 无后端
- 无数据库
- 浏览器可直接打开
- 先做一个可展示的首页和文章详情页

后续进入 coding agent 阶段时，再基于这套文档开始生成实现。
