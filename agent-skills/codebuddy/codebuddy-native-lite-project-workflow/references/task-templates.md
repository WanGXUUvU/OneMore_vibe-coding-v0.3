# 任务卡模板

## TASK-000：项目头脑风暴

```markdown
# TASK-000: 项目头脑风暴

## 1. 项目名称 + 目标
[项目名称]：[一句话目标]

## 2. 现状与背景
[当前项目状态、已有代码/资源、背景信息]

## 3. 用户角色
[谁使用这个系统？主要角色和职责]

## 4. 技术约束
[技术栈、框架、数据库、部署环境等约束]

## 5. Out of Scope
[明确排除的范围，不做的事情]

## 6. Done when
[完成的判定条件，可验证的验收标准]
```

## TASK-xxx：实施任务卡

```markdown
# TASK-xxx: [任务标题]

## 目标
[本任务要达成什么]

## In Scope
- [包含的工作项1]
- [包含的工作项2]
- [包含的工作项3]

## Out of Scope
- [不包含的工作项1]
- [不包含的工作项2]

## 实施计划
[Standard/Strict 车道需要，Fast 车道可省略]

### 步骤1: [描述]
- 改动文件: [文件路径]
- 改动内容: [具体改动]

### 步骤2: [描述]
- 改动文件: [文件路径]
- 改动内容: [具体改动]

## 车道
[Fast / Standard / Strict]

## 验证标准
- [ ] [验证项1]
- [ ] [验证项2]
- [ ] [验证项3]

## Review
### What changed
[改了什么]

### How verified
[如何验证的]

### Status
[✅ Pass / 🚫 Blocked]

### Remaining risk
[剩余风险或 None]
```

## PATCH-TASK：补丁任务卡

```markdown
# PATCH-TASK: [补丁标题]

## 问题描述
[简短描述要修补的问题]

## 修复方案
[一句话描述修复方式]

## 车道
[Fast / Standard / Strict]

## 验证
- [ ] [验证项]

## Review
### What changed
[改了什么]
### Status
[✅ Pass / 🚫 Blocked]
```

## STATUS.md：项目状态

```markdown
# Project Status

## Current Phase
[Brainstorm / Planning / Implementation / Verification / Review / Sync]

## Current Task
[TASK-xxx 或 None]

## Current Gate
[Brainstorm Review / Plan Review / Sync Review 或 None]

## Selected Lane
[Fast / Standard / Strict]

## Blocking Issue
[阻塞问题或 None]

## Next Action
[下一步行动]

## Task History
| Task | Lane | Status | Date |
|------|------|--------|------|
| TASK-000 | - | ✅ Done | YYYY-MM-DD |
| TASK-001 | Standard | 🔄 In Progress | YYYY-MM-DD |
```

## SPEC.md：范围说明（可选）

```markdown
# SPEC: [项目名称]

## 项目概述
[一段话描述项目]

## 核心功能
1. [功能1]
2. [功能2]
3. [功能3]

## 技术架构
- 前端: [技术栈]
- 后端: [技术栈]
- 数据库: [类型]
- 部署: [方式]

## 关键约束
1. [约束1]
2. [约束2]

## 里程碑
| 里程碑 | 目标日期 | 关联任务 |
|--------|---------|---------|
| M1 | YYYY-MM-DD | TASK-001 ~ TASK-003 |
| M2 | YYYY-MM-DD | TASK-004 ~ TASK-006 |
```

## BUILD_PLAN.md：构建计划（可选）

```markdown
# BUILD PLAN

## 当前里程碑
[M1: 里程碑名称]

## 进度
- [x] TASK-001: [任务描述] ✅
- [ ] TASK-002: [任务描述] 🔄
- [ ] TASK-003: [任务描述] ⏳

## 构建注意事项
[部署/构建相关的特殊注意点]

## 更新日志
| 日期 | 更新内容 |
|------|---------|
| YYYY-MM-DD | 初始创建 |
```
