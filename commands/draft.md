---
description: Draft a long-form article from a topic, brief ID, or local brief file. Outputs a markdown file ready for review.
---

# /draft

Usage:

```
/draft <topic-or-slug>             — synthesize a brief, then draft
/draft <relato-brief-id>           — fetch brief from Relato, then draft
/draft <path-to-brief.md>          — read local brief, then draft
```

## What this does

1. If the input is a Relato brief ID and a Relato workspace is connected, fetch the brief via the Relato MCP. Otherwise treat the input as a topic or path.
2. Invoke the `briefer` skill to either parse the existing brief or synthesize a working brief from the topic.
3. Invoke the `writer` skill to fetch primary sources, draft the article in brand voice, and write to disk.
4. Invoke the `humanizer` skill to scrub AI tells.
5. Invoke the `linter` skill to apply auto-fixes and surface remaining findings.

## What you (the user) get back

A markdown file at the configured output path (default `content-kit/articles/{slug}.md`), plus a summary:

- Word count
- Module inventory (fact, cite, cta)
- Citation count
- Lint status
- Word count

## What's next

After review:

- `/revise <file> <feedback>` to apply specific changes
- `/lint <file>` to re-run the audit
- `/humanize <file>` to re-run AI-pattern removal
- Commit and push when you're ready (content-kit doesn't deploy)

## Behavior without Relato

`/draft <topic>` works fully without a Relato workspace. The briefer skill synthesizes a working brief locally and the writer skill executes from there.

`/draft <relato-brief-id>` requires a connected Relato workspace and fails politely if absent.
