<p align="right"><a href="./README.md">EN</a> | <strong>简体中文</strong></p>

# Agent Workflow Skills

这个目录收录了仓库中的 workflow skills 快照，方便统一发布、迁移和版本管理。

## Included Skills

### Codex
- `codex-native-project-workflow`
- `codex-native-lite-project-workflow`

### Claude
- `claude-native-project-workflow`
- `claude-native-lite-project-workflow`

### GitHub Copilot
- `copilot-native-project-workflow`
- `copilot-native-lite-project-workflow`

### CodeBuddy
- `codebuddy-native-project-workflow`
- `codebuddy-native-lite-project-workflow`

## 目录结构

```text
agent-skills/
├── README.md
├── README.zh-CN.md
├── claude/
│   ├── claude-native-project-workflow/
│   └── claude-native-lite-project-workflow/
├── codebuddy/
│   ├── codebuddy-native-project-workflow/
│   └── codebuddy-native-lite-project-workflow/
├── codex/
│   ├── codex-native-project-workflow/
│   └── codex-native-lite-project-workflow/
└── copilot/
    ├── copilot-native-project-workflow/
    └── copilot-native-lite-project-workflow/
```

## Full vs Lite

- `*-native-project-workflow`：完整工作流，包含 `SPEC.md`、`DECISIONS.md`、`BUILD_PLAN.md`、`STATUS.md`、任务卡、车道和人工关卡
- `*-native-lite-project-workflow`：轻量工作流，减少默认文档负担，但仍保留任务卡、验证和 stop gate

如果你希望更强的计划感、可追踪性和交付纪律，选 full。
如果你希望保留同样心智模型但少一些流程负担，选 lite。

## 推荐安装路径

### Codex

复制到：

```text
~/.codex/skills/
```

示例：

```bash
cp -R agent-skills/codex/codex-native-project-workflow ~/.codex/skills/
cp -R agent-skills/codex/codex-native-lite-project-workflow ~/.codex/skills/
```

### Claude Code

复制到：

```text
~/.claude/skills/
```

示例：

```bash
cp -R agent-skills/claude/claude-native-project-workflow ~/.claude/skills/
cp -R agent-skills/claude/claude-native-lite-project-workflow ~/.claude/skills/
```

### GitHub Copilot

复制到：

```text
~/.copilot/skills/
```

也可以按仓库级放在：

```text
.github/skills/
```

示例：

```bash
cp -R agent-skills/copilot/copilot-native-project-workflow ~/.copilot/skills/
cp -R agent-skills/copilot/copilot-native-lite-project-workflow ~/.copilot/skills/
```

### CodeBuddy

复制到：

```text
~/.codebuddy/skills/
```

示例：

```bash
cp -R agent-skills/codebuddy/codebuddy-native-project-workflow ~/.codebuddy/skills/
cp -R agent-skills/codebuddy/codebuddy-native-lite-project-workflow ~/.codebuddy/skills/
```

## 如何使用

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

## Workflow Model

这 8 个 skills 共享同一套核心思路：

1. 先读取仓库状态
2. 当任务还不可执行时，先走 `TASK-000`
3. 在实施前记录范围与边界
4. 在支持的宿主里选择 `Fast`、`Standard`、`Strict`
5. 实施后必须补 `Verify` 和 `Review`
6. 在 `Brainstorm Review`、`Plan Review`、`Sync Review` 等节点停下

## Notes

- 仓库中的这些 skill 是快照版本。如果你后续更新了本机 live 版本，发布前记得同步回来。
- 不同宿主支持的 metadata 能力不同，所以这里保留了各自宿主原生风格，而不是强行压成完全一样的格式。
