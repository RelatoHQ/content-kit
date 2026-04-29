---
description: Turn a raw idea into a structured brief the writer skill can execute. Creates a Relato project if a workspace is connected, otherwise writes a local markdown brief.
---

# /brief

Usage:

```
/brief <topic>                                 — synthesize a brief from a topic
/brief <news-url>                              — synthesize from a news article
/brief "<angle>"                               — synthesize from a specific angle
/brief <path-to-thin-brief>                    — sharpen an existing brief
```

Examples:

```
/brief "the lethal trifecta in agent governance"
/brief https://www.federalreserve.gov/supervisionreg/srletters/SR2602.htm
/brief "why banks should ignore SR 26-2 and act anyway"
/brief briefs/eu-ai-act-article-50.md
```

## What this does

Invokes the `briefer` skill, which:

1. Researches the topic or fetches the URL.
2. Identifies the news peg, freshness window, and counterintuitive angle.
3. Surveys existing coverage to find non-commodity gaps.
4. Lists candidate primary sources, internal links, and cite-able experts.
5. Composes a structured brief with HOOK, NEWS PEG, PILLAR, FORMAT, TARGET KEYWORDS, INTERNAL LINKS, KEY SOURCES, CANDIDATE EXPERTS, GEO STANDARDS, CONSTRAINTS, NON-COMMODITY ANGLE.

## Where the brief goes

- **Relato workspace connected**: creates a new project in your workspace's Backlog stage. Returns the project ID.
- **No Relato workspace**: writes the brief to `briefs/<slug>.md` at the project root.

## What you get back

```
✓ Brief created
  - Path: <Relato project ID or local file path>
  - Title: <working title>
  - Pillar: <pillar from taxonomy.md>
  - Sources identified: <count>
  - Candidate experts: <count from your experts.md>

Next: /draft <id-or-slug>
```

## Behavior without Relato

`/brief` works fully without a Relato workspace. Output is a local markdown file you can edit, version, and feed to `/draft` later.

If a Relato workspace IS connected, `/brief` defaults to creating a Relato project. Pass `--local` to override and write a local file instead.
