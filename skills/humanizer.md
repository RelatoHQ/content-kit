---
name: humanizer
description: Strip AI patterns and inflated language from a draft. Run after writer or editor, or stand-alone on text someone else wrote. Does not change voice, only removes AI tells.
---

# humanizer

You are detecting and removing the patterns that mark text as AI-generated. The brand voice is whatever it is — your job is not to change it, only to remove the residue that makes the text obviously machine-written.

## Step 1 — Read the file

Open the file the user named (or the file the calling skill passed in). Read it end to end before changing anything.

## Step 2 — Scan for AI tells

These patterns are the strongest signals of AI authorship. Find every instance and rewrite.

### Inflated symbolism and stakes

| Pattern | Why it's an AI tell | Fix |
|---|---|---|
| "stands as a testament to" | empty inflation | cut entirely or rephrase as fact |
| "in an era of" / "in today's landscape" | preamble inflation | cut |
| "as we navigate" | hand-waving futurism | cut |
| "the dawn of a new" | grandiose framing | cut |
| "underscores the importance of" | meta-commentary | just make the point |
| "highlights the need for" | meta-commentary | state the need directly |

### Rule-of-three padding

AI loves three-item lists where two would do, or where one specific item would be stronger. Read every list of three. Ask: is each item carrying weight, or is the third one filler? Cut the filler.

### Vague attributions

| Pattern | Fix |
|---|---|
| "experts say" | name the expert or cut the claim |
| "research shows" | name the study with date and sample size |
| "studies have found" | same |
| "many believe" | who? |
| "it is widely understood" | by whom? |

### Negative parallelism

| Pattern | Fix |
|---|---|
| "not just X but also Y" | rewrite as a positive statement leading with Y |
| "not only X — Y as well" | same |
| "X is not Y; X is Z" (when Y is a strawman) | cut the negation, lead with Z |

### -ing analyses

AI gerunds pile up like "ensuring," "leveraging," "facilitating," "enabling." Convert to active voice with a subject doing the verb.

| Pattern | Fix |
|---|---|
| "ensuring compliance with regulations" | "the policy enforces compliance" |
| "leveraging AI to drive outcomes" | "the agent reads the records and updates the database" |
| "facilitating better collaboration" | "the team uses Slack" |

### Copula chains

| Pattern | Fix |
|---|---|
| "X serves as a Y" | "X is a Y" |
| "X functions as a Y" | "X is a Y" |
| "X represents a Y" | "X is a Y" or "X means Y" |

### Anthropomorphization of systems

| Pattern | Fix |
|---|---|
| "the AI understands" | "the system detects" / "the model classifies" |
| "the model knows" | "the model returns" / "the model predicts" |
| "the agent decides" | "the agent's policy permits" / "the agent's policy blocks" |

(Exception: when discussing capability claims, "decides" or "reasons" can be accurate. Use judgment.)

### Em-dash overuse

AI loves em dashes — sometimes — for emphasis — too much. Universal default: max one em dash per three paragraphs. None in headlines or SEO titles. If voice.md bans them entirely, follow that.

### Conjunctive throat-clearing

| Pattern | Fix |
|---|---|
| "Before we dive in," | cut |
| "Let's take a step back," | cut |
| "It's worth noting that" | cut, just note it |
| "In this article, we'll explore" | cut, the title and TL;DR already say what's coming |
| "First, let's understand" | cut |

### Vocabulary that screams AI

The kit's writer skill has the canonical list (delve, leverage, robust, seamlessly, unprecedented, transformative, ecosystem, navigate, crucial, pivotal, serves as). Apply the same fixes here. Add any words listed in `content-kit/forbidden-words.md`.

### Flat sentence rhythm

Read each paragraph aloud. If every sentence is the same length, vary it. Mix short (3-7 words) with medium (10-18) with long (20+). The pattern matters more than any individual length.

## Step 3 — Apply fixes with the Edit tool

One fix per Edit. Surgical, reviewable.

## Step 4 — Don't over-correct

Some constructions look AI-ish but are actually appropriate:

- Technical terminology used precisely is not "jargon to remove."
- Lists of three are fine when each item is doing real work.
- Em dashes used sparingly are punctuation, not a tell.
- Active voice is not always better — "the agent was blocked" can be the right framing.

The goal is to remove residue, not to flatten everything into the same neutral register.

## Step 5 — Report

```
✓ Humanizer applied <N> fixes to <path>:
  - <count> banned-word swaps
  - <count> -ing conversions to active voice
  - <count> rule-of-three trims
  - <count> em-dash reductions
  - <count> other (one-line summary each)
✓ Word count: <before> → <after>
```

## What you do not do

- You do not change the article's argument or structure.
- You do not change frontmatter unless the AI tell is in a frontmatter string (rare but possible — e.g. an inflated `excerpt`).
- You do not delete citations or facts.
- You do not rewrite passages that are clean.
