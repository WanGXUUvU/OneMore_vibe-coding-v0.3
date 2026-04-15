<p align="right"><strong>EN</strong> | <a href="./README.zh-CN.md">简体中文</a></p>

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

A curated set of project-workflow skills for modern AI coding agents.

This repository packages the same workflow family across multiple hosts so you can keep one project-operating model while switching between tools.

Supported hosts:

- Codex
- Claude Code
- GitHub Copilot
- CodeBuddy

Each host includes two variants:

- `full`: a structured workflow with planning documents, task cards, lane selection, verification, review, and human gates
- `lite`: a lighter version that keeps the same mental model with less process overhead

## Quick Start

1. Choose your host: Codex, Claude Code, GitHub Copilot, or CodeBuddy.
2. Copy the matching skill folders from `agent-skills/<host>/` into your local skills directory.
3. Trigger either the `full` or `lite` workflow skill in your agent prompt.

Common install targets:

- Codex: `~/.codex/skills/`
- Claude Code: `~/.claude/skills/`
- GitHub Copilot: `~/.copilot/skills/` or repo-local `.github/skills/`
- CodeBuddy: `~/.codebuddy/skills/`

Detailed install commands and examples live in [agent-skills/README.md](./agent-skills/README.md).

## Why This Repo Exists

Most agents are good at generating code. Fewer are guided by a stable delivery rhythm.

These skills are designed to give agents a repeatable way to move a project forward:

1. read the repo state first
2. turn vague work into executable tasks
3. choose the right delivery lane
4. verify and review before closure
5. stop at explicit human decision points

The goal is not more ceremony. The goal is cleaner execution.

## Included Skills

### Codex
- `codex-native-project-workflow`
- `codex-native-lite-project-workflow`

### Claude Code
- `claude-native-project-workflow`
- `claude-native-lite-project-workflow`

### GitHub Copilot
- `copilot-native-project-workflow`
- `copilot-native-lite-project-workflow`

### CodeBuddy
- `codebuddy-native-project-workflow`
- `codebuddy-native-lite-project-workflow`

## Repository Layout

```text
agent-skills/
├── README.md
├── codex/
│   ├── codex-native-project-workflow/
│   └── codex-native-lite-project-workflow/
├── claude/
│   ├── claude-native-project-workflow/
│   └── claude-native-lite-project-workflow/
├── copilot/
│   ├── copilot-native-project-workflow/
│   └── copilot-native-lite-project-workflow/
└── codebuddy/
    ├── codebuddy-native-project-workflow/
    └── codebuddy-native-lite-project-workflow/
```

For installation details, host-specific notes, and usage examples, see [agent-skills/README.md](./agent-skills/README.md).

## Workflow Model

All eight skills share the same core shape:

1. Read the current repo before acting.
2. Use `TASK-000` when the task is not yet executable.
3. Record scope, constraints, and done conditions.
4. Choose a lane such as `Fast`, `Standard`, or `Strict` where supported.
5. Finish every implementation step with `Verify` and `Review`.
6. Pause at gates such as `Brainstorm Review`, `Plan Review`, and `Sync Review`.

In practice, this gives you a small project operating system for agent-driven work.

## Full vs Lite

### Full

Choose the full workflow when you want:

- stronger structure from idea to delivery
- explicit repo docs such as `SPEC.md`, `DECISIONS.md`, `BUILD_PLAN.md`, and `STATUS.md`
- clearer planning checkpoints
- better traceability for multi-step or higher-risk work

### Lite

Choose the lite workflow when you want:

- the same task-driven discipline with less overhead
- fewer required docs
- faster iteration loops
- a simpler default for small and medium-sized work

## Quick Start

Copy the skill folders for your host into its local skills directory.

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

You can also vendor the Copilot skills inside a repo under:

```text
.github/skills/
```

### CodeBuddy

```bash
cp -R agent-skills/codebuddy/codebuddy-native-project-workflow ~/.codebuddy/skills/
cp -R agent-skills/codebuddy/codebuddy-native-lite-project-workflow ~/.codebuddy/skills/
```

## Example Invocations

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

## Design Principles

- One workflow family, adapted across hosts
- Clear host-specific naming
- Symmetry between `full` and `lite`
- Shared semantics without forcing one metadata format everywhere

## Publishing Scope

If you want this repository to stay clean and GitHub-friendly, the recommended publish scope is:

- `README.md`
- `agent-skills/`

That keeps the repo focused on the skills themselves rather than local experiments, working directories, or host-specific personal setup.

## Notes

- The skill folders in this repo are snapshots of live local skills.
- If you continue iterating on your local versions, sync the updated copies back here before publishing a new revision.
- Host loading behavior differs slightly, but the workflow semantics are intentionally aligned.
