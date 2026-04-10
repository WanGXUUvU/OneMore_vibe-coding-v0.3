# BUILD_PLAN

## Goal Understanding

### Current Stage Objective
先完成一个无需构建、能直接在浏览器打开的最小 blog demo，为后续 coding agent 执行提供明确的首轮任务输入。

### Why This Plan
该方案严格遵守 `SPEC.md` 的静态前端边界，并基于 `DECISIONS.md` 选择的原生多页面方案，先做最小可见闭环，再逐步补齐内容组织和体验细节。

## Plan Inputs
- SPEC version / summary:
  - 展示型个人 blog；无后端；直接打开；首页 + 详情页；至少 3 篇示例文章
- Key decisions:
  - 原生多页面静态站点
  - 本地 JavaScript 数据文件存放文章内容

## Architecture Snapshot

> 按需填写。不存在的层直接写 `N/A`，不要为了填模板伪造架构。

- UI / Frontend:
  - HTML + CSS + JavaScript
- Runtime / Backend:
  - N/A
- Storage / Database:
  - N/A（本地静态数据文件）
- Access Control / Auth:
  - N/A
- External Integrations:
  - N/A
- Test strategy:
  - 临时本地静态 server + 自动化页面检查 + 静态约束扫描 + 条件允许时手动打开页面验证

## Milestones

> 里程碑默认串行。如果某个里程碑内的多个 TASK 可以并行，在名称后加 `(parallel)` 标注。
> 并行里程碑中的 TASK 需要在 WORKSTREAMS.md 的 `Parallel Config` 中注册依赖关系。

### M1 Bootstrap Static Blog
- Goal:
  - 创建最小可运行的静态 blog 骨架
- Scope:
  - 新建首页、详情页、基础样式和本地文章数据
  - 让首页能展示简介和文章列表，详情页能渲染一篇文章
- Files involved:
  - `index.html`
  - `post.html`
  - `styles.css`
  - `content/posts.js`
  - `main.js`
  - `post.js`
- Risks:
  - 直接打开页面时，脚本引用路径或模块写法可能不兼容
  - 详情页路由方案如果设计过重，会超出 MVP
- Verify:
  - 文件存在性断言
  - 启动临时本地静态 server 并检查首页 / 详情页
  - 扫描是否存在会破坏 `file://` 直开能力的依赖
  - 条件允许时手动打开 `index.html` 和 `post.html`
- Exit criteria:
  - [ ] 首页可直接打开且无明显报错
  - [ ] 首页能看到个人简介和至少 3 篇文章卡片
  - [ ] 详情页能展示一篇文章的标题、日期和正文

### M2 Improve Readability
- Goal:
  - 提升 blog 的阅读体验和版式完整度
- Scope:
  - 优化排版、间距、移动端适配和文章卡片可读性
  - 补充页脚、导航或返回入口
- Files involved:
  - `index.html`
  - `post.html`
  - `styles.css`
  - `main.js`
  - `post.js`
- Risks:
  - 样式调整可能影响已完成的最小可用布局
- Verify:
  - 手动检查桌面端和手机宽度下的阅读体验
- Exit criteria:
  - [ ] 首页和详情页在常见窄屏宽度下仍可正常阅读
  - [ ] 文章卡片、标题层级和正文排版明显优于 M1

### M3 Final Demo Polish
- Goal:
  - 把示例项目整理成可展示的最终 demo
- Scope:
  - 补齐示例文案
  - 统一视觉细节
  - 补充项目说明，方便展示流程成果
- Files involved:
  - `README.md`
  - `index.html`
  - `post.html`
  - `styles.css`
  - `content/posts.js`
- Risks:
  - 为了展示效果而引入超出 MVP 的额外元素
- Verify:
  - 手动通读页面和项目说明
- Exit criteria:
  - [ ] demo 目录内容清晰，可直接作为流程示例展示
  - [ ] 页面文案和视觉风格前后一致

## Verify Strategy

### Automated
- [ ] test
- [ ] lint
- [ ] typecheck
- [x] build（本项目无需构建，改为文件存在性检查）
- [ ] 如为纯静态页面，优先使用 Playwright MCP 配合临时本地静态 server，通过 `http://127.0.0.1:<port>` 执行浏览器自动化验证
- [ ] 扫描源码，确认没有 `fetch`、模块脚本、后端请求或构建产物依赖
- [ ] 浏览器工具卡住时，优先降级为最小验证集，而不是继续堆复杂验证动作

### Manual
1. 必要时直接在浏览器中打开 `index.html`
2. 检查首页是否展示个人简介和至少 3 篇文章
3. 必要时打开 `post.html`，检查文章详情是否完整显示
4. 如果 MCP 环境阻止 `file://`，记录原因，不因该限制直接判任务失败
4. 将浏览器宽度缩小到手机宽度，检查可读性

### Static Page Fallback
- 默认先尝试 Playwright MCP；若未使用，必须在验证结论中说明原因
- 最小验证集默认只包含：页面能打开、关键内容存在、控制台无阻断错误、源码约束扫描通过
- 如果 Playwright MCP 或浏览器自动化卡住，最多重试一次
- 重试失败后，改用更轻的等效验证；不要继续追加额外组件、额外页面路径或复杂验证链
- 若仍无法覆盖最小验证集，则标记 `Blocked`，并写明缺失条件

## Rollback Points
- M1 静态骨架完成后
- M2 可读性优化完成后

## Checkpoint Policy
- Before fixer edits:
  - 主控保留 generator 阶段的 diff 或 commit 作为 checkpoint
- If no git checkpoint exists:
  - 通过保存当前修改 patch 回退到 evaluator 首次验证前状态

## Current Pointer
- Current milestone:
  - M1
- Why this one first:
  - 先拿到一个最小可见闭环，后续体验优化才有验证对象

## Execution Harness
- Roles:
  - `planner`
  - `generator`
  - `evaluator`
  - `fixer`
- Run style:
  - 多子代理协作（默认）
  - 单代理串行（Fallback）
- State owner:
  - 主控负责更新 `STATUS.md`、`BUILD_PLAN.md`、`WORKSTREAMS.md` 和下一张 TASK 文件

## Progress
- [x] M1 Not started
- [ ] M1 Doing
- [ ] M1 Done
- [ ] M2 Doing
- [ ] M2 Done
- [ ] M3 Doing
- [ ] M3 Done
- [ ] M4 Doing
- [ ] M4 Done
- [ ] M5 Doing
- [ ] M5 Done

## Readiness
- [x] Ready for Task
