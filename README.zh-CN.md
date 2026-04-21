<p align="right"><a href="./README.md">EN</a> | <strong>简体中文</strong></p>

# Agent Workflow Skill Generator

<p align="center">
  <img src="./docs/assets/workflow-skills-overview.svg" alt="Agent Workflow Skills overview" width="100%" />
</p>

一个交互式生成器，为 AI coding agent 构建 bootstrap-first 的项目工作流 skill。
运行一个脚本，选择宿主和语言，就能生成用于初始化仓库工作流、并把后续会话交给持久化项目文件继续运行的 skill 文件。

## 支持宿主

| 宿主 | Full | Lite |
|------|------|------|
| GitHub Copilot | ✓ | ✓ |
| Claude Code | ✓ | ✓ |
| Codex | ✓ | ✓ |
| CodeBuddy | ✓ (中文) | ✓ (中文) |

- **full** — 先 bootstrap 项目治理工作台，后续会话从完整文件集继续
- **lite** — 先 bootstrap 最小工作流，后续会话从最小文件集继续

## 产品模型

这些 skill 的定位是 bootstrap 工具，而不是长期运行时依赖。

- **lite** 产出一个最小续跑模型，核心围绕宿主配置文件（`CLAUDE.md` / `AGENTS.md` / `.github/copilot-instructions.md` / `CODEBUDDY.md`）、`STATUS.md`、`specs/TASK-000.md`、`specs/TASK-001.md`
- **full** 产出一个项目治理续跑模型，核心围绕宿主配置文件、`STATUS.md`、`SPEC.md`、`DECISIONS.md`、`BUILD_PLAN.md` 和任务卡
- bootstrap 完成后，后续正常新对话应优先从这些文件继续，而不是再次显式调用 skill

## 快速开始

```bash
curl -fsSL https://raw.githubusercontent.com/WanGXUUvU/OneMore_vibe-coding/main/install.sh | bash
```

或手动克隆运行：

```bash
git clone --depth 1 https://github.com/WanGXUUvU/OneMore_vibe-coding.git && cd OneMore_vibe-coding && ./generate.sh
```

脚本会引导你完成四个步骤：语言、宿主、生成模式、安装目标。

常见安装目录：

- Codex：`~/.codex/skills/`
- Claude Code：`~/.claude/skills/`
- GitHub Copilot：`~/.copilot/skills/` 或仓库内 `.github/skills/`
- CodeBuddy：`~/.codebuddy/skills/`
