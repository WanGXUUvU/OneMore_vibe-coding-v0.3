<p align="right"><strong>EN</strong> | <a href="./README.zh-CN.md">简体中文</a></p>

# Agent Workflow Skill Generator

<p align="center">
  <img src="./docs/assets/workflow-skills-overview.svg" alt="Agent Workflow Skills overview" width="100%" />
</p>

An interactive generator that builds bootstrap-first project-workflow skills for AI coding agents.
Run one script, pick your host and language, and generate skill files that initialize a repo workflow and hand off future sessions to durable project files.

## Supported Hosts

| Host | Full | Lite |
|------|------|------|
| GitHub Copilot | ✓ | ✓ |
| Claude Code | ✓ | ✓ |
| Codex | ✓ | ✓ |
| CodeBuddy | ✓ (zh) | ✓ (zh) |

- **full** — bootstrap a project operating model, then continue later sessions from the full durable file set
- **lite** — bootstrap a minimal workflow, then continue later sessions from a small durable file set

## Product Model

These skills are designed as bootstrap tools, not permanent runtime dependencies.

- **lite** produces a minimal continuation model centered on the host config file (`CLAUDE.md` / `AGENTS.md` / `.github/copilot-instructions.md` / `CODEBUDDY.md`), `STATUS.md`, `specs/TASK-000.md`, and `specs/TASK-001.md`
- **full** produces a project-governance continuation model centered on the host config file, `STATUS.md`, `SPEC.md`, `DECISIONS.md`, `BUILD_PLAN.md`, and task cards
- After bootstrap, normal new conversations should continue from those files instead of explicitly re-calling the skill

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/WanGXUUvU/OneMore_vibe-coding/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone --depth 1 https://github.com/WanGXUUvU/OneMore_vibe-coding.git && cd OneMore_vibe-coding && ./generate.sh
```

The script walks you through four steps: language, host, generate mode, and install target.

Common install targets:

- Codex: `~/.codex/skills/`
- Claude Code: `~/.claude/skills/`
- GitHub Copilot: `~/.copilot/skills/` or `.github/skills/` inside a repo
- CodeBuddy: `~/.codebuddy/skills/`
