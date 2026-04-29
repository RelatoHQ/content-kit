---
description: Apply specific feedback to an existing draft. Surgical edits, not a rewrite.
---

# /revise

Usage:

```
/revise <path-to-file> <feedback>
```

Example:

```
/revise content-kit/articles/lethal-trifecta.md "the opening is too generic — lead with the January 2026 incident week"
```

## What this does

1. Invokes the `editor` skill to parse the feedback and identify what changes.
2. Applies surgical edits to the named file using exact-string replacements.
3. Re-validates voice and structure after every change.
4. Invokes the `linter` skill to confirm no new findings introduced.

## What you get back

A summary of changes applied:

- One-line description of each change
- Word count before and after
- Lint status

## What revise does not do

- Does not rewrite the article. If you want a rewrite, use `/draft <slug>` to start fresh.
- Does not change frontmatter fields the feedback didn't mention.
- Does not "improve" passages the feedback didn't flag.
- Does not delete citations, facts, or modules without asking.

## When to use revise vs draft

- **Revise**: targeted feedback, keeping the architecture in place
- **Draft**: the angle is wrong, the brief was wrong, or the article needs a structural redo
