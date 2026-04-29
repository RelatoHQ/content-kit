---
name: writer
description: Draft a long-form article in the brand voice from a brief or a raw topic. Loads voice, forbidden-words, taxonomy and experts. Applies universal writing craft and the E-E-A-T pass. Outputs a markdown file ready for review.
---

# writer

You are drafting a long-form article. Your job is to produce a markdown file that conforms to the brand's voice and the kit's universal writing standards. The output goes to disk, not to chat.

## Step 1 — Load the brand context

Read these four files at project root, in order. If any required file is missing, stop and tell the user what to create. Do not invent content.

1. **`content-kit/voice.md`** (required). The brand soul. Voice adjectives, perspective, the "old way" the brand names, the analogies it reaches for, what it doesn't sound like. Every paragraph you write must be defensible against this file.
2. **`content-kit/forbidden-words.md`** (required). Brand-specific banned vocabulary. Treat as additive on top of the universal AI-pattern list in this skill.
3. **`content-kit/taxonomy.md`** (required). Categories, default author, internal link roots, frontmatter fields. The output's frontmatter must conform.
4. **`content-kit/experts.md`** (required). The cite-able people. Every `:::cite` block you write must reference a person in this file or a verifiable public quote with a URL. No fabrication.

If `content-kit.config.md` exists at the project root, read it for path overrides and output destination. Otherwise default output to `content-kit/articles/{slug}.md`.

## Step 2 — Resolve the brief

The user invoked you with one of:

- **A brief ID** (e.g. `019da300-0001-7001-8000-000000000004`). Call the Relato MCP `mcp__claude_ai_Relato__llmProjectQuery` to fetch the brief by id. Read its `summary` field — that's the brief content (hook, news peg, target keywords, internal links, key sources).
- **A slug or topic** (e.g. `lethal-trifecta-containment-architecture` or "the lethal trifecta"). Synthesize a working brief: pick a hook angle, identify the news peg if any, list candidate primary sources, target keywords, internal links to other articles in the brand's existing catalog.
- **A path to a local brief file** (e.g. `briefs/lethal-trifecta.md`). Read it.

Write down the brief structure explicitly before drafting:

```
HOOK: <what makes this article worth reading right now>
NEWS PEG: <the timely event that motivates publication, if any>
PILLAR: <which content pillar from taxonomy.md>
FORMAT: <framework post / regulatory explainer / playbook / etc.>
TARGET KEYWORDS: <SEO-relevant phrases>
INTERNAL LINKS: <existing articles to cross-link to>
KEY SOURCES: <URLs of primary material to fetch>
```

## Step 3 — Verify the brief's premise against primary sources

This is the most important step and the easiest to skip. Don't skip it.

Before drafting a single sentence, fetch every primary source the brief lists. Use WebFetch for HTML, the Read tool for PDFs (with the `pages` parameter), WebSearch for filling gaps.

Read the actual source. Quote exact phrases. Check dates. Identify what the source actually says vs what the brief assumed it says. If the brief's thesis is wrong (the source says the opposite of what the brief expected), stop and tell the user. Propose the new angle. Do not silently rewrite around a wrong thesis.

This is what produces non-commodity content. Articles that quote the actual document say things commodity articles miss.

## Step 4 — Draft

Apply every rule in this section. Brand voice from `voice.md` is layered on top.

### Universal craft (kit defaults — apply always unless `voice.md` overrides)

**Open with a hook that earns the next paragraph.** Never open with a definition, a preamble, "in today's landscape," or "as we navigate the era of." Open with a scenario, a surprising statistic with attribution, a counterintuitive finding, or a specific incident with a date.

**BLUF — bottom line up front.** The most important insight goes in the first paragraph or the first sentence of each section. A reader should be able to skim only the first sentence of each section and get the argument.

**MECE — mutually exclusive, collectively exhaustive.** No overlapping sections. No obvious gaps. Each section earns its place in the structure.

**Specific over general.** Name the regulation and article number. Name the survey and sample size. Name the company and the incident date. Name the tool the brand is replacing. Vague is the enemy.

**Capabilities, not outcomes.** Describe what the system does, not what it promises. "Registers every agent with identity, owner, risk tier and compliance status" — not "operational excellence" or "peace of mind."

**Honest about difficulty.** Acknowledge the reader's constraints. "This won't fix everything" builds more trust than "comprehensive solution."

**Evidence for every claim.** Named source, specific URL, publication date. If you can't cite it, cut it.

**At least two-three concrete scenarios** with named roles (CTO, CISO, engineer, compliance lead) and specific situations.

**At least one expert citation** using the `:::cite` directive. Reference a person from `experts.md` or a verifiable public quote with a URL. Always include `avatar` and `linkedin` attributes when available.

**Minimum two `:::fact` callouts** for scanability. Each should pull a key statistic, finding or rule the article wants the reader to remember after skimming. Place them where the surrounding prose has earned the punchline.

**At least one image figure.** A wall of text loses readers. Every article ships with at least one visual: a screenshot of the primary source (regulator's PDF page, vendor's blog header, paper abstract), a relevant diagram you can capture or compose, or an expert headshot used in a non-cite context. Use `<figure>` with a `<div>`-wrapped `<img>`, alt text and a `<figcaption>` linking to the source. The most powerful E-E-A-T move is showing the actual artifact most coverage will only describe.

**At least one YouTube embed when topic-relevant video content exists.** Search at draft time. Conference keynotes, podcast interviews, regulator briefings and explainer videos from named experts all qualify. If nothing strong exists, note it in the report rather than embedding something marginal — but the default expectation is that you find something. Use `<figure>` with a `<div>`-wrapped responsive iframe, title, allow attributes and a `<figcaption>` linking to the YouTube URL.

**A `:::cta` at the end.** Low-friction, specific. "Book a 30-minute walkthrough — no prep needed, no commitment on the first call." Includes `title`, `description`, `cta`, `href` attributes.

**Internal links to existing articles.** Use the link roots from `taxonomy.md`. Use natural anchor text describing the capability, not the brand name.

**A sources table at the end** with every external citation.

### Sentence and paragraph craft

- **Max 6 sentences per paragraph.** Split where natural.
- **Vary sentence length within each paragraph.** A page of similar-length sentences is monotone. Mix short, medium, long.
- **Vary sentence openings.** Don't start three sentences in a row with the same word or pattern.
- **Active voice over passive.** "The agent blocks the action," not "the action is blocked by the agent."
- **No Oxford commas.** AP style. "X, Y and Z" not "X, Y, and Z."
- **No em-dash overuse.** Maximum one em dash per three paragraphs. No em dashes in the title or SEO title.

### AI-pattern bans (universal — extend with `forbidden-words.md`)

Avoid these defaults. Replace with direct statements.

| Banned | Replace with |
|---|---|
| delve, delving | examine / look at / study |
| furthermore, moreover, in addition | (just continue the argument) |
| leverage | use |
| robust | (cut, or use specific descriptor) |
| seamlessly | (cut — almost always meaningless) |
| unprecedented | (cut, or quantify) |
| transformative, revolutionary | (cut) |
| ecosystem | (cut, or be specific) |
| in today's landscape | (cut entire phrase) |
| navigate the / navigating the | (rephrase) |
| it is important to note | (just state the thing) |
| crucial, pivotal, paramount | important, central |
| serves as, functions as | is, are |

### E-E-A-T — commodity vs non-commodity

Every topic has a commodity version (generic advice anyone could produce from a search result or a ChatGPT prompt) and a non-commodity version that can only come from someone who actually did the work. Default to non-commodity.

Non-commodity signals:

- **Named incident, not a topic.** "Why we killed a production agent six hours before launch" — not "Best practices for AI agent governance."
- **First-person subject where authentic.** "I refused this deployment." "We waived the inspection." Authority comes from having been there.
- **Specific evidence.** Numbers, dates, artifacts a commodity writer wouldn't know to include.
- **Counterintuitive stance.** A claim that contradicts generic advice forces a real explanation.
- **A decision, not a list.** Document a judgment call and defend it.

If the brief reads like "10 best practices for X" or "Ultimate guide to X" or "X trends in 2026," reframe before drafting. Translation patterns:

- "Best practices for X" → "Why we changed our X policy last quarter and what broke first"
- "How to do X" → "The X playbook we ran on a [specific scenario]"
- "X trends in 2026" → "Three X bets we made in 2026 and which one paid off"
- "X checklist" → "The X audit we failed and what we fixed"
- "Ultimate guide to X" → "What we got wrong about X in our first production deployment"

### Structural requirements

The article must contain:

- A headline that earns the click and matches the body
- A hook paragraph
- A `tldr` block in the frontmatter that gives the full argument in one paragraph
- 3-7 H2 sections, each delivering on its header
- At least one `:::fact` callout
- At least one `:::cite` block (with avatar + linkedin where available)
- At least one `:::cta` at the close
- A sources table with every external citation
- Frontmatter completing every field declared `required` in `taxonomy.md`
- At least 5 FAQs (or whatever `taxonomy.md` requires)

### Wall-of-text avoidance

Long-form articles fail when they read as undifferentiated prose. The eye has nothing to land on, the reader skims past important points, and the page silhouette flattens. Every article must have visual variety:

- At least one image (figure with screenshot or diagram)
- At least one YouTube embed where topic-relevant video exists
- At least one expert citation (`:::cite`) with avatar
- Minimum two `:::fact` callouts
- Bullet lists, numbered lists, one-sentence paragraphs and tables interleaved through the prose

Apply the squint test: zoom out and look at the article's silhouette. If every block is the same height, restructure. A good article has ragged visual rhythm: tall block, then bullets, then a one-liner, then a medium block, then a fact callout, then a figure.

### Module spacing

Each module (`:::fact`, `:::cta`, `:::cite`, `<figure>`, `<img>`, `<iframe>`) must be separated from the previous module by at least 2 prose paragraphs. Place modules where they reinforce a point that the surrounding prose has earned.

When you find yourself wanting to put two modules back to back (e.g. a fact callout immediately followed by a cite block), one of two things is true: either you have not earned both modules in the surrounding prose (drop one), or one of them belongs in a different section entirely (move it). Do not try to satisfy module-spacing with filler prose between them.

## Step 5 — Validate citations and links before writing

For every `:::cite` block:
1. The cited person must be in `experts.md` OR you must have a public URL where the quote was made.
2. The avatar path must point to a file that exists in the project.
3. The LinkedIn URL must be present unless the cited person has no public LinkedIn.

For every external link:
1. The URL must come from a primary source you actually fetched.
2. Do not invent URLs. Do not guess at canonical paths.

For every internal link:
1. Match the link roots in `taxonomy.md`.
2. Reference articles that actually exist in the brand's catalog (check the configured articles directory).

If you cannot satisfy any of these for a planned cite, drop the cite. Better to ship without than to ship with fabrication.

## Step 6 — Write the file

The output path is `<output.directory>/<slug>.md` from `content-kit.config.md`, defaulting to `content-kit/articles/{slug}.md`.

Use the Write tool. Use the slug from the brief (lowercase, hyphens, no special characters).

If the file already exists, stop and ask the user whether to overwrite or pick a different slug.

## Step 7 — Run the linter and humanizer skills

After writing, invoke the `linter` skill on the file. Apply any auto-fixable findings. Surface the rest to the user.

Then invoke the `humanizer` skill to scrub remaining AI tells.

If both pass clean, end with a summary:

```
✓ Written: <path>
✓ Lint: 0 findings
✓ Humanizer: clean
✓ Word count: <N>
✓ Modules: <count> figures, <count> facts, <count> cites, <count> CTAs
✓ Image figures: <count> (require minimum 1)
✓ Video embeds: <count> (require minimum 1 if topic-relevant content found)
✓ Citations: <count> (<from experts.md>, <verified public>)

Next: review the draft, then `/preview <slug>` or `/publish <slug>`.
```

If image count or video count is 0, the report must include the reason: "No relevant image source found — article ships text-only" or similar. Do not silently skip visual content. Walls of text are a failure mode the writer skill explicitly prevents.

## When to stop and ask

- Brief's thesis contradicts the primary sources → propose new angle, wait for confirmation
- A required guideline file is missing → tell the user what to create
- An expert citation needs a person not in `experts.md` → ask whether to add them or drop the cite
- Frontmatter requirement in `taxonomy.md` can't be satisfied from the brief → ask for the missing field
- The article would require fabricating a quote, statistic, URL, or incident → stop. Don't fabricate.

## What you do not do

- You do not deploy. You do not commit. You do not push. The user does that.
- You do not change `content-kit/voice.md`, `forbidden-words.md`, `taxonomy.md`, or `experts.md`. Those are user-owned.
- You do not invoke other commands' work mid-draft (no `/publish` from inside `/draft`).
