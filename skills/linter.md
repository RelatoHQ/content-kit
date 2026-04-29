---
name: linter
description: Audit pass against the kit's universal writing rules and the brand's forbidden-words list. Reports findings, applies auto-fixable changes, surfaces the rest.
---

# linter

You are auditing a markdown article against editorial rules. The writer skill applies these at draft time; the linter catches what slipped through and verifies what humans wrote. Output is a findings report and (optionally) applied fixes.

## Step 1 — Load the brand context

Read `content-kit/forbidden-words.md` for brand-specific banned vocabulary. Read `content-kit/taxonomy.md` for frontmatter requirements and link roots. Read `content-kit/voice.md` for any voice-specific rule overrides (em-dash policy, sentence-rhythm preferences).

If `content-kit.config.md` declares per-rule severity overrides, honor them. Default severity for each rule is listed below.

## Step 2 — Read the file

Open the file the user named. Strip the frontmatter and treat the body separately for content rules; some rules also apply to frontmatter strings (`title`, `excerpt`, `tldr`).

## Step 3 — Apply the rules

Walk each rule. Record findings as `(line, rule, severity, message, auto-fixable: yes/no, suggested fix)`.

### Lexical rules

**banned-word** (error). Match every entry in `content-kit/forbidden-words.md` and the universal AI-pattern list (delve, leverage, robust, seamlessly, unprecedented, transformative, ecosystem, navigate the, in today's landscape, crucial, pivotal, serves as, functions as, represents a). Suggest the fix from the appropriate list. Auto-fixable for direct substitutions.

**intensifier** (error). Empty intensifiers: very, really, quite, truly, extremely, significantly, just (when filler), actually (when filler), basically. Auto-fixable: cut the word.

**ai-significance** (error). Inflated significance phrases: "stands as a testament to," "underscores the importance of," "highlights the need for," "in an era of," "as we navigate," "the dawn of." Auto-fixable: cut or rewrite suggestion.

**ai-copula** (error). "X serves as a Y," "X functions as a Y," "X represents a Y." Auto-fixable: replace with "X is a Y."

**ai-ing** (warn). Excessive -ing analyses. Find sentences where the subject is a participle phrase doing real work the active voice would do better. Hard to auto-fix; surface for review.

**ai-anthropomorphize** (warn). "The AI understands," "the model knows," "the system thinks." Auto-fixable: replace "understands" → "detects," "knows" → "returns," "thinks" → "computes."

**ai-negative-parallel** (warn). "Not only X but also Y," "X is not Y; X is Z" patterns. Hard to auto-fix; surface for review.

### Structural rules

**oxford-comma** (error). Serial comma before `and`/`or` in lists of 3+. Auto-fixable: remove the comma. (Only flag when the article's voice is AP style; voice.md may declare Chicago style which keeps the Oxford comma.)

**heading-case** (error). H2 and H3 headings must be sentence case (only first word and proper nouns capitalized). Auto-fixable.

**em-dash-title** (error). No em dashes in `title` or `seo.title` frontmatter strings. Auto-fixable: replace with comma or colon.

**em-dash-density** (warn). Maximum one em dash per three paragraphs in body. Hard to auto-fix; surface affected paragraphs.

**module-spacing** (error). Each module (`:::fact`, `:::cta`, `:::cite`, `<figure>`, `<img>`, `<iframe>`) must have at least 2 prose paragraphs between it and the previous module. Hard to auto-fix; surface affected modules.

**long-paragraph** (error). Maximum 6 sentences per paragraph. Auto-fixable: suggest a split point.

**long-sentence** (warn). Sentences over 40 words. Surface for review.

**monotone** (warn). Paragraph where all sentence lengths are within 4 words of each other. Surface for review.

**same-start** (warn). Three or more consecutive sentences starting with the same word or pattern. Surface for review.

### Citation and link rules

**no-product-link** (error). Body must contain at least one link to a path under `taxonomy.md`'s `productLinkRoots` (e.g. `/platform/*`, `/solutions/*`).

**fabricated-cite** (error). Every `:::cite` block must reference a person in `content-kit/experts.md` OR include an external URL where the quote is publicly verifiable. If neither, error.

**missing-avatar** (warn). `:::cite` block with a person who has an `avatar` path in `experts.md` but no `avatar` attribute on the cite directive.

**missing-linkedin** (warn). Same pattern with `linkedin`.

**broken-internal-link** (error). Internal links must match `taxonomy.md`'s link roots and reference articles that exist in the configured articles directory.

### Frontmatter rules

**frontmatter-missing** (error). Any field listed `required` in `taxonomy.md` is absent or empty.

**frontmatter-malformed** (error). `date` is not ISO format. `tags` is not an array. `faqs` count is below the taxonomy minimum.

## Step 4 — Apply auto-fixable findings

For each finding marked `auto-fixable: yes`, apply the suggested fix using the Edit tool. One fix per Edit. Re-check the surrounding paragraph after each fix to make sure the edit didn't break something else (an Oxford comma removal can leave a clause-joining "and" that needs a comma elsewhere).

## Step 5 — Report

```
Lint report for <path>

Auto-fixed (N):
  L<line>  <rule>  <one-line summary of fix>
  ...

Surfaced for your review (M):
  L<line>  <rule>  <severity>  <message>
                    Suggested: <one-line fix or "rewrite needed">
  ...

Summary: <auto-fixed count> applied, <surfaced count> for your review.
Status: <clean / warnings / errors>
```

If invoked with `--check` (no auto-fix), do not apply any changes. Just report.

## When to stop and ask

- Voice.md has rule overrides the linter doesn't recognize → ask whether to honor or ignore
- A finding's auto-fix would change the article's argument → surface, don't auto-apply
- The forbidden-words list is empty (file exists but no words) → ask whether the user actually has no banned words or whether the file needs filling in

## What you do not do

- You do not change the article's structure, argument, modules, citations, or facts.
- You do not invent rule violations the catalog doesn't include.
- You do not silently rewrite. Every change is logged in the report with a line number.
