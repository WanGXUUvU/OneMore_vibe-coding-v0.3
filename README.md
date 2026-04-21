<p align="right"><strong>EN</strong> | <a href="./README.zh-CN.md">简体中文</a></p>

# Agent Workflow Skill Generator

<p align="center">
  <img src="./docs/assets/workflow-skills-overview.svg" alt="Agent Workflow Skills overview" width="100%" />
</p>

An interactive generator that builds project-workflow skills for AI coding agents.
Run one script, pick your host and language, and get ready-to-install skill files.

## Supported Hosts

| Host | Full | Lite |
|------|------|------|
| GitHub Copilot | ✓ | ✓ |
| Claude Code | ✓ | ✓ |
| Codex | ✓ | ✓ |
| CodeBuddy | ✓ (zh) | ✓ (zh) |

- **full** — structured workflow with repo docs, task cards, lanes, and human gates
- **lite** — same delivery model with less process overhead

## Quick Start

```bash
./generate.sh
```

The script walks you through four steps: language, host, generate mode, and install target.

Common install targets:

- Codex: `~/.codex/skills/`
- Claude Code: `~/.claude/skills/`
- GitHub Copilot: `~/.copilot/skills/` or `.github/skills/` inside a repo
- CodeBuddy: `~/.codebuddy/skills/`

