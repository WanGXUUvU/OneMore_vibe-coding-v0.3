# Extensions

可选扩展包。主流程不依赖它们。

大多数项目只需要 `project-base/`。

只有在你明确需要时再装：

```bash
# Claude Code 适配
cp -r /path/to/OneMore_vibe-coding_v1.0/extensions/claude-code/. .

# Eval 示例文档
cp -r /path/to/OneMore_vibe-coding_v1.0/extensions/eval-harness/evals/ evals/
```

---

## 两个扩展包

### 1. `claude-code/` — Claude Code 原生适配

**解决什么问题**：Claude Code 通过 `.claude/agents/*.md` 识别子代理。这个包提供四角色子代理定义 + `CLAUDE.md` 入口文件。

**包含文件**：
| 文件 | 用途 |
|------|------|
| `CLAUDE.md` | Claude Code 项目入口，引用关键文件 |
| `.claude/agents/planner.md` | planner 子代理定义 |
| `.claude/agents/generator.md` | generator 子代理定义 |
| `.claude/agents/evaluator.md` | evaluator 子代理定义 |
| `.claude/agents/fixer.md` | fixer 子代理定义 |

**安装**：
```bash
cp -r extensions/claude-code/. your-project/
```

**依赖**：需要 Claude Code。Codex 用户不需要此包。

---

### 2. `eval-harness/` — 评估示例

**解决什么问题**：当你需要定义结构化 eval case 时，这个包提供 YAML 结构和 grader schema 参考。

**包含文件**：
| 文件 | 用途 |
|------|------|
| `evals/README.md` | eval 框架说明 |
| `evals/grader-schema.yaml` | 5 维 grader 定义 |
| `evals/capability/example.yaml` | 功能评估示例 |
| `evals/regression/example.yaml` | 回归评估示例 |

**安装**：
```bash
cp -r extensions/eval-harness/evals/ your-project/evals/
```

**依赖**：无强制依赖；你可以按自己的执行器实现这些 eval。

---

## 什么时候需要

| 用户场景 | core | claude-code | eval-harness |
|---------|------|-------------|-------------|
| 个人 MVP（Codex） | ✓ | — | — |
| 个人 MVP（Claude Code） | ✓ | ✓ | — |
| 模板开发/调优 | ✓ | ✓ | ✓ |
