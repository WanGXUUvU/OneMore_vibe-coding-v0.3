# STATUS

> 阶段级状态文档。只记录当前处于哪个阶段、哪个里程碑、哪张 TASK。
> 更细的角色运行态写在当前 TASK 卡里，不写在这里。

## Current Phase
[Bootstrap / Clarify / Decisions / Build Plan / Task Ready / Execute / Approval Pending / Verify / Sync]

> `Approval Pending`：主控输出 Plan 或 Review 后，等待人工在 `[HUMAN GATE]` 节点确认，确认后才切回 Execute 或 Sync。

## Current Milestone
[例如 M1]

## Current Task
[例如 TASK-001]

## Current Gate
[None / Plan Review / Sync Review]

## Outcome of Last Task
- [ ] Pass
- [ ] Fail
- [ ] Blocked

## Next Task Candidate
[由主控填写，例如 TASK-002（已生成草案，待确认）]

## Resume Command
[给下一位接手 agent 的最小指令]

## Notes
[阶段切换理由、阻塞等说明]

---

## History

> 每个 TASK 闭环时追加一行。
> 由主控追加，不由子代理直接修改。

| Task | Milestone | Outcome | Date |
|------|-----------|---------|------|
| - | - | - | - |
