# Evals 目录

存放项目的评估定义。每个 `.yaml` 文件定义一组评估用例。

## 结构

```text
evals/
├── README.md           ← 本文件
├── grader-schema.yaml  ← grader 通用 schema 定义
├── capability/         ← 功能评估（新能力是否工作）
│   └── example.yaml
└── regression/         ← 回归评估（旧功能是否仍然正常）
    └── example.yaml
```

## 用法

```bash
# 运行单个 eval
bash <your-eval-runner> evals/capability/example.yaml

# 运行全部 eval
bash <your-eval-runner> evals/

# 查看结果
cat artifacts/<run_id>/eval-results.jsonl
```

## 术语（对齐 Anthropic eval 框架）

| 概念 | 说明 |
|------|------|
| **Task** | 一组评估的集合（对应一个 .yaml 文件） |
| **Trial** | Task 中的单个测试用例 |
| **Grader** | 判断 Trial 是否通过的逻辑（脚本/命令/人工） |
| **Transcript** | Agent 执行过程中的完整工具调用链 |
| **Outcome** | Trial 的最终结果：pass / fail / error / skip |
