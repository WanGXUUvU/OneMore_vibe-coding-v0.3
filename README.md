<p align="right"><strong>EN</strong> | <a href="./README.zh-CN.md">简体中文</a></p>

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

This repository now keeps only the generator and template sources for the workflow skills.

It does not use committed published skill snapshots as the primary source anymore. The source of truth is:

- `core-template/`
- `generate.sh`

Generated outputs are written locally to `_internal/agent-skills/` and can then be installed into the matching host directory.

## What This Repo Contains

- `core-template/`: full and lite workflow templates plus shared references
- `generate.sh`: interactive generator and installer for all 4 hosts
- `docs/assets/`: README assets only

## Supported Hosts

- Codex
- Claude Code
- GitHub Copilot
- CodeBuddy

Each host has two variants:

- `full`: structured workflow with repo docs, task cards, lanes, verification, review, and human gates
- `lite`: lighter workflow with the same core delivery model and less process overhead

## Quick Start

1. Run `./generate.sh`
2. Choose language, host, generation mode, and optional install target
3. If you choose generate-only mode, outputs are written to `_internal/agent-skills/`
4. If you choose install mode, the script copies the generated skills into the correct host directory

Common install targets:

- Codex: `~/.codex/skills/`
- Claude Code: `~/.claude/skills/`
- GitHub Copilot: `~/.copilot/skills/` or repo-local `.github/skills/`
- CodeBuddy: `~/.codebuddy/skills/`

## Repo Layout

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
  agent-skills/        # generated locally
  claude-local/        # local-only misc files
```

## Workflow Model

All generated skills share the same core shape:

1. Read the repo state first
2. Use `TASK-000` when the task is not yet executable
3. Record scope, constraints, and done conditions
4. Choose the smallest valid lane
5. End implementation with `Verify` and `Review`
6. Stop at explicit human gates such as `Brainstorm Review`, `Plan Review`, and `Sync Review`

## Notes

- Do not treat `_internal/agent-skills/` as source code.
- Change templates in `core-template/`, then regenerate.
- The generated host outputs are intentionally kept out of the main repo surface.
