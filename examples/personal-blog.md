# 示例：个人 Blog 如何使用 v0.2

## 场景

目标：验证这套流程是否适合个人 blog 项目。

建议先决定你要验证的是哪种 blog：

- 展示型 blog
- 带后台 CMS 的 blog

如果只是第一次验证流程，建议先选展示型 blog。
如果你要顺手验证中等复杂度项目，再做 CMS blog。

---

## 先做什么

1. 从模板仓库复制：
   - [project-base](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/project-base)
2. 把复制后的目录命名成你的 blog 项目
3. 打开：
   - [PLAYBOOK.md](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/PLAYBOOK.md)
4. 按里面的步骤推进

---

## 阶段 A：网页大语言模型

这一阶段直接照 [PLAYBOOK.md](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/PLAYBOOK.md) 的 B 段执行即可。

你的目标是产出：

- `SPEC.md`
- `DECISIONS.md`
- `BUILD_PLAN.md`
- `specs/TASK-001.md`

---

## 阶段 B：切到 Coding Agent

这一阶段直接照 [PLAYBOOK.md](/Users/wangxu/Downloads/OneMore_vibe-coding_模板/OneMore_vibe-coding_v0.2/PLAYBOOK.md) 的 C 段执行即可。

你的目标是：

- 执行 `TASK-001`
- 完成 `Verify / Review`
- 同步状态
- 自动得到 `TASK-002` 草案
- 由你决定是否继续执行

---

## 一个实际建议

如果是 CMS blog，首版建议先冻结为：

- Frontend: `Next.js`
- Database: `PostgreSQL`
- ORM: `Prisma`
- Auth: 单管理员账号密码
- Editor: Markdown textarea
- Cover: URL，而不是首版就做上传

这样更适合先验证流程是否顺。
