---
description: Strip AI patterns and inflated language from a draft. Stand-alone pass; also runs at the end of /draft.
---

# /humanize

Usage:

```
/humanize <path-to-file>
```

## What this does

Invokes the `humanizer` skill on the named file. Detects and removes:

- Inflated symbolism: "stands as a testament to," "in an era of," "underscores the importance of"
- Empty intensifiers: very, really, truly, extremely, significantly
- Vague attributions: "experts say," "research shows," "many believe"
- Negative parallelism: "not only X but also Y"
- -ing analyses: "ensuring compliance," "leveraging AI to drive outcomes"
- Copula chains: "X serves as a Y," "X functions as a Y"
- System anthropomorphization: "the AI understands," "the model knows"
- Em-dash overuse
- Conjunctive throat-clearing: "Before we dive in," "It's worth noting that"
- AI vocabulary residue (delve, leverage, robust, seamlessly, etc.)
- Flat sentence rhythm

## When to use

- After drafting from a non-content-kit source (someone wrote it elsewhere and pasted it in)
- When `/draft` produced a clean-on-lint file that still reads AI-ish
- Periodically on existing articles you want to refresh

## What humanize does not do

- Does not change the article's argument or structure.
- Does not delete citations or facts.
- Does not flatten technical terminology that's used precisely.
- Does not rewrite passages that are already clean.

## What you get back

```
✓ Humanizer applied <N> fixes to <path>:
  - <count> banned-word swaps
  - <count> -ing conversions
  - <count> rule-of-three trims
  - <count> em-dash reductions
  - <count> other
✓ Word count: <before> → <after>
```
