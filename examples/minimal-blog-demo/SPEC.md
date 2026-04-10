# SPEC

## Project Name
Minimal Blog Demo

## Goal
用最少文件做一个可直接在浏览器打开的个人 blog demo，能展示首页文章列表和文章详情页。

## Context

### Current State
当前目录还是空白 demo 项目，只有流程模板文档，没有任何实际页面或前端代码。

### Why Now
这个项目用于验证 `vibe coding` 流程中的“网页大语言模型阶段”是否能把一个最小产品收敛到可执行的 `TASK-001`，再顺利交接给 coding agent。

### Users / Roles
- 个人创作者：希望快速展示自己的文章和个人简介
- 访客：浏览文章列表并查看单篇内容

## Constraints

### Product Constraints
- 首版只做展示型 blog，不做 CMS
- 首版必须能展示个人简介、文章列表、文章详情
- 首版至少提供 3 篇示例文章
- 首版不做登录、评论、搜索、后台管理

### Technical Constraints
- 纯静态前端
- 浏览器可直接打开，不依赖本地服务或后端
- 不引入数据库
- 优先使用原生 HTML、CSS、JavaScript 完成 MVP

### Engineering Constraints
- 优先最小闭环
- 不做无关优化
- 保持当前阶段可验证
- `TASK-001` 预期变更文件不超过 10 个

## Done when
- [ ] 项目产出一个可直接打开的 blog 首页
- [ ] 首页能展示个人简介和至少 3 篇文章卡片
- [ ] 至少有一个可直接打开的文章详情页，能展示标题、日期和正文
- [ ] 页面在桌面端和手机宽度下都能正常阅读

## Out of Scope
- 文章发布后台
- 评论、点赞、订阅
- 登录鉴权
- 服务端渲染
- SEO 深度优化

## Assumptions
- 文章内容可以先用本地静态数据维护
- 文章详情页可以使用静态文件或前端读取本地数据生成
- 视觉风格以简洁、可读为主，不追求品牌化设计

## Open Questions

### Blocking
- 无

### Non-blocking
- 首版文章封面是否需要占位图
- 第二轮是否增加按标签筛选

## Readiness
- [ ] 信息不足，继续 Clarify
- [x] Ready for Decisions
- [ ] Ready for Build Plan
