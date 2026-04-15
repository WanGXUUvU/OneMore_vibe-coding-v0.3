<p align="right"><strong>EN</strong> | <a href="./README.zh-CN.md">简体中文</a></p>

# Agent Workflow Skills

This directory vendors the workflow skills used by the templates in this repo so they can be versioned and published together.

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

## Directory Layout

```text
agent-skills/
├── README.md
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

## Full Vs Lite

- `*-native-project-workflow`: full workflow with `SPEC.md`, `DECISIONS.md`, `BUILD_PLAN.md`, `STATUS.md`, task cards, lane selection, and human gates.
- `*-native-lite-project-workflow`: lighter workflow with fewer required docs and a faster delivery loop, while still keeping task cards, verification, and stop gates.

Use the full version when you want explicit planning, stronger review structure, and better traceability.
Use the lite version when you want the same mental model with less process overhead.

## Recommended Install Paths

### Codex

Copy the skill folders into:

```text
~/.codex/skills/
```

Example:

```bash
cp -R agent-skills/codex/codex-native-project-workflow ~/.codex/skills/
cp -R agent-skills/codex/codex-native-lite-project-workflow ~/.codex/skills/
```

### Claude Code

Copy the skill folders into:

```text
~/.claude/skills/
```

Example:

```bash
cp -R agent-skills/claude/claude-native-project-workflow ~/.claude/skills/
cp -R agent-skills/claude/claude-native-lite-project-workflow ~/.claude/skills/
```

### GitHub Copilot

Copy the skill folders into:

```text
~/.copilot/skills/
```

Or vendor them repo-locally under:

```text
.github/skills/
```

Example:

```bash
cp -R agent-skills/copilot/copilot-native-project-workflow ~/.copilot/skills/
cp -R agent-skills/copilot/copilot-native-lite-project-workflow ~/.copilot/skills/
```

### CodeBuddy

Copy the skill folders into:

```text
~/.codebuddy/skills/
```

Example:

```bash
cp -R agent-skills/codebuddy/codebuddy-native-project-workflow ~/.codebuddy/skills/
cp -R agent-skills/codebuddy/codebuddy-native-lite-project-workflow ~/.codebuddy/skills/
```

## How To Use

### Codex

Call the skill by name in the prompt:

```text
Use $codex-native-project-workflow to bootstrap this repo.
Use $codex-native-lite-project-workflow to continue in lite mode.
```

### Claude Code

Use the skill name in the prompt or slash-style invocation, depending on your setup:

```text
Use $claude-native-project-workflow to continue the current task.
Use $claude-native-lite-project-workflow to run the repo in lite mode.
```

### GitHub Copilot

Reference the skill directly in the chat instruction:

```text
Use $copilot-native-project-workflow to set up the full workflow for this repo.
Use $copilot-native-lite-project-workflow to keep the workflow lightweight.
```

### CodeBuddy

Reference the skill name in the prompt:

```text
使用 $codebuddy-native-project-workflow 启动完整项目工作流
使用 $codebuddy-native-lite-project-workflow 以精简模式继续当前任务
```

## Workflow Model

All eight skills share the same core ideas:

1. Read repo state first.
2. Use `TASK-000` when the task is not yet executable.
3. Record scope before implementation.
4. Choose a lane: `Fast`, `Standard`, or `Strict` where supported.
5. Finish with `Verify` and `Review`.
6. Stop at human gates such as `Brainstorm Review`, `Plan Review`, or `Sync Review`.

## Template Mapping

These skills are designed to pair with the templates in this repository:

- `project-base-codex-native/`
- `project-base-claude-native/`

The Copilot and CodeBuddy variants follow the same workflow family, adapted to their own skill formats and host conventions.

## Notes

- The copied skill folders in this repo are snapshots. If you later update the live versions under your home directory, copy them back in before publishing a new release.
- Some hosts support richer metadata or host-specific conventions. Those differences are preserved instead of forcing all skills into one file format.
