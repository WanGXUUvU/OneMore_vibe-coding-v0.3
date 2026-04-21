<p align="right"><a href="./README.md">EN</a> | <strong>简体中文</strong></p>

# Agent Workflow Skill Generator

<p align="center">
  <img src="./docs/assets/workflow-skills-overview.svg" alt="Agent Workflow Skills overview" width="100%" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/hosts-4-1f6feb?style=flat-square" alt="4 hosts" />
  <img src="https://img.shields.io/badge/variants-full%20%2B%20lite-c084fc?style=flat-square" alt="full and lite variants" />
  <img src="https://img.shields.io/badge/source-core--template-0f766e?style=flat-square" alt="template source" />
  <img src="https://img.shields.io/badge/output-local%20only-eab308?style=flat-square" alt="local output only" />
</p>

这个仓库现在只保留工作流 skill 的生成器和模板源码。

它不再把已生成的 skill 快照作为主要维护对象。当前唯一真源是：

- `core-template/`
- `generate.sh`

生成产物会写到本地 `_internal/agent-skills/`，然后再按需要安装到对应宿主目录。

## 仓库包含内容

- `core-template/`：full / lite 工作流模板，以及共享 references
- `generate.sh`：4 个宿主统一使用的交互式生成器和安装器
- `docs/assets/`：README 配图资源

## 支持宿主

- Codex
- Claude Code
- GitHub Copilot
- CodeBuddy

每个宿主都有两个版本：

- `full`：带仓库文档、任务卡、车道、验证、评审和人工关卡的完整流程
- `lite`：保留同一套交付心智模型，但默认流程更轻

## 快速开始

1. 运行 `./generate.sh`
2. 选择语言、宿主、生成模式，以及是否安装
3. 如果选择“仅生成”，产物会写到 `_internal/agent-skills/`
4. 如果选择“安装”，脚本会把生成后的 skill 复制到对应宿主目录

常见安装目录：

- Codex：`~/.codex/skills/`
- Claude Code：`~/.claude/skills/`
- GitHub Copilot：`~/.copilot/skills/` 或仓库内 `.github/skills/`
- CodeBuddy：`~/.codebuddy/skills/`

## 目录结构

```text
core-template/
  references/
  workflow-full.md.template
  workflow-full.zh.md.template
  workflow-lite.md.template
  workflow-lite.zh.md.template
generate.sh
docs/assets/
_internal/
  agent-skills/        # 本地生成产物
  claude-local/        # 本地杂项文件
```

## Workflow Model

所有生成出的 skill 共享同一条核心主链：

1. 先读仓库状态
2. 当任务还不可执行时，先走 `TASK-000`
3. 记录范围、约束和完成标准
4. 选择满足需要的最小车道
5. 实现结束必须补 `Verify` 和 `Review`
6. 在 `Brainstorm Review`、`Plan Review`、`Sync Review` 等人工关卡停下来

## 说明

- 不要把 `_internal/agent-skills/` 当成源码维护。
- 需要修改时，请改 `core-template/`，然后重新生成。
- 已生成的各宿主产物有意不再作为仓库主展示面的一部分。
