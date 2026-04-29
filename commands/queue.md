---
description: Calendar operations against your Relato workspace. List the queue, see what's next, move publish dates, change stages.
---

# /queue

Usage:

```
/queue                              — show the next 7 items in the publish calendar
/queue list                         — list all Backlog/Writing/Review items with dates
/queue next                         — show the single next item due
/queue move <slug> <YYYY-MM-DD>     — reschedule an item
/queue stage <slug> <stage-name>    — move an item between stages
```

Examples:

```
/queue
/queue list
/queue move lethal-trifecta-containment-architecture 2026-05-02
/queue stage sr-26-2-agentic-ai-carve-out Published
```

## What this does

Calls the Relato MCP to query and update the workspace declared in your `content-kit.config.md`:

- `mcp__claude_ai_Relato__llmProjectQuery` for read operations
- `mcp__claude_ai_Relato__setProjectDateCommand` for `move`
- `mcp__claude_ai_Relato__changeProjectStageCommand` for `stage`

## Output

For `/queue` (default, next 7):

```
Date       Pillar             Title                                                  Stage
2026-04-30 Governance Gap     The lethal trifecta: containment architecture          Review
2026-05-02 Governance Gap     Agent memory poisoning (OWASP ASI06)                   Backlog
2026-05-04 Compliance         90 Days to Aug 2: EU AI Act Article 50 checklist       Backlog
...
```

For `/queue next`:

```
Next up:
  Date:  2026-04-30
  Title: The lethal trifecta: governing the three capabilities you can't remove
  Stage: Review
  Brief: <Relato project ID>

To start drafting: /draft <id>
```

## Required: Relato workspace

This command requires a connected Relato workspace. Without one, you'll see:

```
content-kit /queue requires a Relato workspace.
Activate at https://relato.com or contact your workspace admin.
The rest of content-kit (writer, editor, humanizer, linter) works without Relato.
```

## Stage names

Stage names are case-insensitive and match the names in your Relato workspace. Standard stages: `Backlog`, `Research`, `Writing`, `Review`, `Published`, `Distributed`, `Archived`. Your workspace may have customized them.
