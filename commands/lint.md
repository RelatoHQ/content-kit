---
description: Audit a markdown article against universal writing rules and the brand's forbidden-words list. Reports findings, applies auto-fixable changes.
---

# /lint

Usage:

```
/lint <path-to-file>           — audit and apply auto-fixable findings
/lint <path-to-file> --check   — audit only, no changes
```

## What this does

Invokes the `linter` skill on the named file. Walks every rule:

- Banned words (universal AI patterns + your `forbidden-words.md`)
- Empty intensifiers, AI significance phrases, copula chains
- Oxford commas, heading case, em-dash density and placement
- Long paragraphs, monotone rhythm, same-start sequences
- Module spacing
- Citation integrity (no fabrication, avatars present where available)
- Internal link integrity
- Frontmatter completeness against your `taxonomy.md`

Auto-fixable findings (banned-word swaps, Oxford commas, sentence-case headings, em-dash-in-title) are applied in place.

Other findings are surfaced for your review with line numbers and suggestions.

## What you get back

```
Lint report for <path>

Auto-fixed (N):
  L<line>  <rule>  <summary of fix>
  ...

Surfaced for your review (M):
  L<line>  <rule>  <severity>  <message>
  ...

Summary: <count> applied, <count> for review.
Status: clean / warnings / errors
```

## CI usage

`/lint <file> --check` runs in audit-only mode. Pair it with Claude's `--print` flag in a CI job:

```yaml
- run: claude --print "/lint $CHANGED_FILE --check"
```

Exit code is non-zero if any error-level findings remain.
