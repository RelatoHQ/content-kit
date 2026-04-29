# Relato setup

content-kit's calendar and brief management run through [Relato](https://relato.com). This doc covers activation and what changes when you connect.

## What you get with Relato

The kit's writing pipeline (writer, editor, humanizer, linter) works fully without Relato. With Relato, you also get:

- **`/brief <topic>`** creates a Relato project in your workspace's Backlog stage instead of a local markdown file
- **`/queue`**, **`/queue list`**, **`/queue next`** — surface what's coming up, sorted by publish date
- **`/queue move <slug> <date>`** — reschedule
- **`/queue stage <slug> <stage>`** — Backlog → Writing → Review → Published transitions
- **`/draft <brief-id>`** — fetch a brief from your Relato workspace and run the writer against it
- **Publisher's stage transition** — articles that originated from a Relato brief get moved to "Review" automatically when the publisher skill finishes

## How the integration works

The Relato MCP server runs as a hosted service tied to your Relato workspace. When your Claude Code session connects to it (via your standard MCP config), the kit's commands invoke MCP tools by name:

- `mcp__claude_ai_Relato__llmProjectQuery` for read operations
- `mcp__claude_ai_Relato__setProjectDateCommand` for scheduling
- `mcp__claude_ai_Relato__changeProjectStageCommand` for stage transitions
- `mcp__claude_ai_Relato__createProjectCommand` for new briefs

Auth and entitlement happen Relato-side. The kit doesn't ship MCP code or credentials.

## Activating

1. Sign up or log in at [relato.com](https://relato.com).
2. Create a workspace for your content (or use an existing one). Note the workspace ID — visible in the URL or in workspace settings.
3. Enable the Claude integration in your Relato workspace settings. Relato issues the MCP endpoint.
4. Add the Relato MCP to your Claude Code MCP config (via `claude mcp add` or the config UI). Follow the workspace-specific instructions Relato provides.
5. Add your workspace ID to `content-kit.config.md`:

```yaml
relato:
  workspaceId: "<your-workspace-id>"
```

6. Verify by running `/queue` in a Claude session — it should list the items in your Backlog.

## Stage configuration

content-kit assumes the standard Relato content workflow stages:

- **Backlog** — new briefs land here
- **Research** — sources gathered, angle confirmed
- **Writing** — actively drafting
- **Review** — drafted, awaiting publish
- **Published** — live on the brand's site
- **Distributed** — promoted across channels
- **Archived** — historical reference

If your workspace uses different stage names, declare them in `content-kit.config.md`:

```yaml
relato:
  workspaceId: "..."
  stages:
    backlog: "Inbox"
    review: "Drafted"
    published: "Live"
```

The kit looks up stage IDs by name, so the names must match exactly (case-insensitive).

## Without Relato

Every kit command degrades gracefully:

| Command | Without Relato |
|---|---|
| `/draft <topic>` | Works fully. Briefer synthesizes a brief locally. |
| `/draft <brief-id>` | Returns "Relato workspace required" |
| `/draft <local-path>` | Works fully. |
| `/brief <topic>` | Writes to `briefs/<slug>.md` instead of creating a Relato project |
| `/queue *` | Returns "Relato workspace required" |
| `/revise` | Works fully. |
| `/lint` | Works fully. |
| `/humanize` | Works fully. |

So the kit is genuinely useful without Relato — you just lose the calendar layer.

## Troubleshooting

**`/queue` says "Relato workspace required" even though I'm a Relato user.**
Check that the Relato MCP is in your Claude Code MCP list (`claude mcp list`). It should show as connected. If not, re-add it from the Relato workspace settings.

**`/queue` returns 401.**
The MCP server is reachable but your workspace credential is invalid or expired. Refresh from Relato settings.

**`/draft <brief-id>` can't find the brief.**
The brief is in a workspace other than the one declared in `content-kit.config.md`. Either move the brief or change the configured workspace.

**The MCP tools aren't named the way the kit expects.**
The kit calls tools like `mcp__claude_ai_Relato__llmProjectQuery`. If your Relato MCP exposes a different naming scheme, edit the relevant skill (briefer.md, publisher.md, queue command) to use the names your MCP actually publishes.
