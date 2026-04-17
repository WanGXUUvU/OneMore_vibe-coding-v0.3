<p align="right"><a href="./README.md">EN</a> | <strong>简体中文</strong></p>

# Agent Workflow Skills

<p align="center">
  <img src="./docs/assets/workflow-skills-overview.svg" alt="Agent Workflow Skills overview" width="100%" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/hosts-4-1f6feb?style=flat-square" alt="4 hosts" />
  <img src="https://img.shields.io/badge/skills-8-0f766e?style=flat-square" alt="8 skills" />
  <img src="https://img.shields.io/badge/variants-full%20%2B%20lite-c084fc?style=flat-square" alt="full and lite variants" />
  <img src="https://img.shields.io/badge/languages-English%20%7C%20中文-eab308?style=flat-square" alt="English and Chinese" />
</p>

一套面向现代 AI coding agent 的项目工作流 skills 集合。

这个仓库把同一套 workflow family 分别适配到了多个宿主上，让你在切换工具时，仍然可以保持一致的项目推进方式。

## Quick Start

1. 先选择你使用的宿主：Codex、Claude Code、GitHub Copilot 或 CodeBuddy。
2. 从 `agent-skills/<host>/` 复制对应的 skill 目录到本机 skills 目录。
3. 在 agent 提示词中触发 `full` 或 `lite` 版本的 workflow skill。

常见安装目录：

- Codex：`~/.codex/skills/`
- Claude Code：`~/.claude/skills/`
- GitHub Copilot：`~/.copilot/skills/` 或仓库内 `.github/skills/`
- CodeBuddy：`~/.codebuddy/skills/`

## 支持宿主

- Codex
- Claude Code
- GitHub Copilot
- CodeBuddy

每个宿主都提供两个版本：

- `full`：强调文档骨架、车道选择、验证、评审和人工 gate 的完整工作流
- `lite`：保留同样心智模型，但减少默认流程负担的轻量工作流

## 为什么做这个仓库

大多数 agent 都会写代码，但不是每个 agent 都会按稳定的节奏把项目推进下去。

这套 skills 的目标，是给 agent 一个可重复的项目执行方式：

1. 先读仓库现状
2. 把模糊任务收敛成可执行任务
3. 选择合适的交付车道
4. 在收口前完成验证与评审
5. 在关键节点停下来等待人工决策

它不是为了增加流程感，而是为了让执行更干净、更稳定。

## Workflow Model

这 8 个 skills 共享同一套核心结构：

1. 先读取当前仓库状态
2. 当任务还不可执行时，先走 `TASK-000`
3. 记录范围、约束和完成标准
4. 在支持的宿主里选择 `Fast`、`Standard`、`Strict`
5. 每次实施结束都必须补 `Verify` 和 `Review`
6. 在 `Brainstorm Review`、`Plan Review`、`Sync Review` 等节点停下来

实际效果上，它更像是一个给 agent 用的小型项目操作系统。

## Full vs Lite

### Full

适合这些场景：

- 从 0 到 1 启动项目
- 希望明确维护 `SPEC.md`、`DECISIONS.md`、`BUILD_PLAN.md`、`STATUS.md`
- 需要更强的可追踪性
- 多步骤、高风险任务希望显式经过 `Plan Review`

### Lite

适合这些场景：

- 想保留任务卡与关卡，但不想默认流程太重
- 不需要一开始就维护太多根文档
- 更强调快速闭环
- 希望把它作为小中型项目的默认模式

## 安装

### Codex

```bash
cp -R agent-skills/codex/codex-native-project-workflow ~/.codex/skills/
cp -R agent-skills/codex/codex-native-lite-project-workflow ~/.codex/skills/
```

### Claude Code

```bash
cp -R agent-skills/claude/claude-native-project-workflow ~/.claude/skills/
cp -R agent-skills/claude/claude-native-lite-project-workflow ~/.claude/skills/
```

### GitHub Copilot

```bash
cp -R agent-skills/copilot/copilot-native-project-workflow ~/.copilot/skills/
cp -R agent-skills/copilot/copilot-native-lite-project-workflow ~/.copilot/skills/
```

Copilot 也可以按仓库级放在：

```text
.github/skills/
```

### CodeBuddy

```bash
cp -R agent-skills/codebuddy/codebuddy-native-project-workflow ~/.codebuddy/skills/
cp -R agent-skills/codebuddy/codebuddy-native-lite-project-workflow ~/.codebuddy/skills/
```

## 使用示例

### Codex

```text
Use $codex-native-project-workflow to bootstrap this repo.
Use $codex-native-lite-project-workflow to continue in lite mode.
```

### Claude Code

```text
Use $claude-native-project-workflow to continue the current task.
Use $claude-native-lite-project-workflow to run the repo in lite mode.
```

### GitHub Copilot

```text
Use $copilot-native-project-workflow to set up the full workflow for this repo.
Use $copilot-native-lite-project-workflow to keep the workflow lightweight.
```

### CodeBuddy

```text
使用 $codebuddy-native-project-workflow 启动完整项目工作流
使用 $codebuddy-native-lite-project-workflow 以精简模式继续当前任务
```

## Notes
- 这个仓库现在只保留发布用的 skill 快照和最小安装说明。
- 仓库中的这些 skill 是快照版本。如果你后续更新了本机 live 版本，发布前记得同步回来。
- 不同宿主的加载方式会略有差异，但 workflow 语义已经尽量对齐。
