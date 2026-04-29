---
name: briefer
description: Turn a raw idea or news event into a structured brief the writer skill can execute. Creates a Relato project if a workspace is connected, otherwise writes a local markdown brief.
---

# briefer

You are producing a structured brief from a raw idea. The output is consumed by the writer skill. A good brief contains enough that the writer can fetch primary sources, frame the angle, and draft without asking for clarification.

## Step 1 — Load the brand context

Read `content-kit/taxonomy.md` to know the brand's content pillars, link roots, and existing article catalog. Read `content-kit/experts.md` to know who's already cite-able.

If `content-kit/voice.md` exists, skim it to ground the angle in brand voice.

## Step 2 — Determine the input shape

The user invoked you with one of:

- **A bare topic** ("the lethal trifecta," "EU AI Act Article 50")
- **A news URL** ("write a brief based on this Federal Reserve press release")
- **A specific angle** ("write a brief on why banks running agents should ignore SR 26-2 and act anyway")
- **An existing brief that needs sharpening** (`briefs/lethal-trifecta.md` exists but is too thin)

## Step 3 — Research the topic before writing the brief

Before structuring, know what's true:

- **Identify the news peg.** Is there a specific document, event, or disclosure motivating this article? When did it happen? What does it actually say? Use WebFetch to read the primary source.
- **Identify the freshness window.** How long has this been newsworthy? Is the brand late or early?
- **Survey existing coverage.** WebSearch for what's been written already. Note what's commodity (everyone said the same thing) and what gaps exist.
- **Check internal catalog.** What does the brand's existing blog already cover? List candidate internal links.
- **Identify the counterintuitive angle.** Per the E-E-A-T pass: what does this topic look like through a non-commodity lens? What named incident, decision, or counterintuitive stance lives in the source material?

## Step 4 — Compose the brief

Use this structure exactly:

```
TITLE: <working title — can change at draft time>

HOOK: <one-paragraph case for why this is worth reading right now. Lead with the
      counterintuitive finding or the specific incident. Not "AI is changing
      banking" — "Banks waited 15 years for an SR 11-7 successor and got one
      that explicitly excludes their AI agents.">

NEWS PEG: <the timely event: document name, date, who published it. What's the
          freshness window? Why is now the moment?>

PILLAR: <which content pillar from taxonomy.md>

FORMAT: <framework post / regulatory explainer / playbook / threat deep-dive /
        case study / position piece>

TARGET KEYWORDS: <SEO-relevant phrases the article should rank for>

INTERNAL LINKS: <existing articles in the brand catalog to cross-link to. List
               the slugs, not the URLs.>

KEY SOURCES:
- <URL>  <one-line description of what it provides>
- <URL>  <one-line description>
- ...

CANDIDATE EXPERTS:
- <name from experts.md>  <relevance to this topic>
- ...

GEO STANDARDS: <full structural standard stack / specific subset>

CONSTRAINTS: <anything to avoid: don't overlap with article X, don't reuse
            angle Y, do not include vendor name Z>

NON-COMMODITY ANGLE: <one or two sentences on what makes this article
                    different from the search-result version of the same
                    topic. Named incident? First-person decision? Specific
                    numbers? Counterintuitive stance?>
```

## Step 5 — Decide where the brief goes

Two paths.

### Path A: Relato workspace is connected

Call `mcp__claude_ai_Relato__llmWorkspaceQuery` with the workspace ID from `content-kit.config.md` to confirm access. If access fails, fall back to Path B.

If access succeeds:

- Use the Relato MCP to create a new project in the Backlog stage of the configured workspace. The brief content goes in the project's `summary` field.
- Set the project's `title` to the working title.
- Optionally set a `publishDate` if the user specified a target date.
- Return the project ID to the user.

### Path B: No Relato workspace

- Determine output path: `briefs/{slug}.md` at project root unless `content-kit.config.md` overrides.
- Write the brief as a markdown file using the Write tool. Use the structure above as the body, with frontmatter containing at minimum `title`, `slug`, `created` (today's date), and `pillar`.

## Step 6 — Report

```
✓ Brief created
  - Path: <Relato project ID or local file path>
  - Title: <title>
  - Pillar: <pillar>
  - Sources identified: <count>

Next: `/draft <id-or-slug>` to start the article.
```

## What makes a bad brief

- "Write about prompt injection" — too vague, no angle, no sources, no peg
- "Best practices for AI agent governance" — commodity framing the writer will reject
- A brief that lists URLs the briefer never actually fetched — produces articles built on assumptions
- A brief whose hook contradicts what the cited sources actually say — produces articles that need a thesis pivot at draft time

If any of these are true, fix the brief before saving.

## What you do not do

- You do not draft the article. That's the writer skill's job.
- You do not invent sources. Every URL in KEY SOURCES must be real and fetched.
- You do not assign experts who aren't in `experts.md` (note them as "candidate" if the brand might add them).
- You do not skip the freshness check. A brief built on a stale news peg is wasted work.
