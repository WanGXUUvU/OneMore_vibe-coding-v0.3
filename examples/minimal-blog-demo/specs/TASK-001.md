# TASK-001

## Title
Bootstrap 一个可直接打开的静态 blog 骨架

## Task Source
- SPEC: 最小展示型 blog，首页 + 详情页，无后端，可直接打开
- BUILD_PLAN: M1 Bootstrap Static Blog

## Goal
创建最小可运行的静态 blog demo，让用户能直接打开首页和详情页看到真实内容，而不是占位文档。

## Context
项目当前只有文档骨架，没有实际页面或前端代码。第一轮目标是把最小闭环做出来，再按当前模板继续验证流程。

## In Scope
- 创建首页、详情页、本地数据和样式文件
- 让首页能展示简介和文章列表，详情页能渲染一篇文章
- 让当前文档与最终生成的代码状态对齐

## Out of Scope
- 新增后台管理
- 引入框架、构建链或本地 server 依赖
- 超出最小 blog demo 的功能扩展

## Constraints
- 单张 TASK 变更文件 ≤10 个
- 这是 `Bootstrap Task`
- 页面必须能通过直接打开本地文件验证
- 不允许为了首轮任务引入后端或本地 server 依赖
- 自动化浏览器验证默认通过临时本地静态 server 执行，不直接要求 Playwright 访问 `file://`

## Invariants
- 继续保持纯静态前端方案
- 不破坏 `index.html` / `post.html` 的本地直开能力

## Required Reads

| 角色 | 必读 |
|------|------|
| planner | `AGENTS.md` + `STATUS.md` + 本卡；按需 `BUILD_PLAN.md` |
| generator | 本卡 `Plan` + `index.html` `post.html` `styles.css` `content/posts.js` `main.js` `post.js` |
| evaluator | 本卡 `Done when` + `Changed Files` + `Verify` |
| fixer | 本卡 `Verify` 失败项 + 具体失败文件 |

## Files Involved
- `index.html`
- `post.html`
- `styles.css`
- `content/posts.js`
- `main.js`
- `post.js`

## Preflight Checks
- 当前 6 个目标文件还不存在
- 当前实现不应引入 fetch、模块依赖或后端

## Done when

> 只写可运行、可验证的代码或交付标准。
> 好例：通过临时本地静态 server 打开 `index.html` 时无阻断性错误，且实现仍满足 `file://` 直开约束。
> 反例：文档格式正确。

- [ ] 通过临时本地静态 server 打开 `index.html` 后能看到个人简介和至少 3 篇文章卡片
- [ ] 通过临时本地静态 server 打开 `post.html` 后能展示一篇文章的标题、日期和正文
- [ ] 页面在自动化验证路径下无阻断性的 JavaScript 报错
- [ ] 当前代码与本卡 `Files Involved`、`Invariants` 和 `Out of Scope` 保持一致
- [ ] 当前实现不包含会破坏 `file://` 直开能力的依赖：如 `fetch`、模块脚本、后端请求、构建产物依赖

---

## Plan

> 由 planner 填写，generator 读取。

1. 新建静态首页与详情页骨架：`index.html`、`post.html` 负责承载内容，继续使用本地相对路径加载脚本和样式，确保 `file://` 或本地静态服务下都可直接打开。
2. 建立本地文章数据源：`content/posts.js` 提供至少 3 篇示例文章，包含 `slug`、`title`、`date`、`excerpt` 和正文段落，供首页列表和详情页共享。
3. 渲染首页列表：`main.js` 读取本地数据并生成文章卡片，首页必须展示个人简介和至少 3 篇文章卡片。
4. 渲染详情页：`post.js` 根据 URL `slug` 定位文章，展示标题、日期和正文，未命中时回退到首篇文章。
5. 收敛基础样式：`styles.css` 统一首页、详情页、卡片、正文和窄屏排版，避免引入构建链、后端或 fetch 依赖。
6. 验证最小闭环：启动临时本地静态 server，通过 `http://127.0.0.1:<port>/index.html` 和 `post.html?slug=building-small-things-first` 检查页面内容；再扫描源码确认没有会破坏 `file://` 直开能力的依赖，必要时补一次手动直开验证。

## Changed Files

> 由 generator 填写，evaluator 读取。

- [待填写]

## Execution Evidence

> 由 generator / evaluator 追加本轮证据。

| command | artifact | result | note |
|---------|----------|--------|------|
| [待执行] | [N/A] | [pending] | [N/A] |

## Verify

> 由 evaluator 填写当前轮结果。

- Automated: [待填写；如为纯静态页面，优先填写临时本地静态 server 下的自动化验证结果]
- Manual: [待填写；若 MCP 阻止 `file://`，写明阻断原因与替代证据]
- Evidence refs: [待填写]
- Results: [Pass / Fail / Blocked]
- Fix log: [待填写]

## Review

- Verdict: [Pass / Fail / Blocked] · Ready for Next Task: [Y/N]
- Top Risk: [待填写]
- Unexpected: [待填写]

## Review Focus

- 重点检查页面是否仍然能直接通过本地文件运行
- 重点检查当前代码是否和新的 TASK 边界对齐，而不是残留上一版流程痕迹

## Notes for Next Task
- [待填写]

---

## Archive

> 旧轮次 Verify / Fix log 移到此处。
