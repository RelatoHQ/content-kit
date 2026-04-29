# Forbidden words

This file lists vocabulary the brand has banished. The `writer` and `linter` skills consult it on every draft and audit. The kit already bans the universal AI-pattern catalog (delve, leverage, robust, seamlessly, unprecedented, transformative, ecosystem, navigate the, in today's landscape, crucial, pivotal, serves as, functions as, represents a, etc.). This file ADDS to that list — it does not replace it.

Format: one word or phrase per line, lowercase. Optionally followed by `→ replacement` for direct substitutions, or `# reason` for context.

## Brand-specific bans

```
# competitors and adjacent vendors (do not name in articles)
[competitor name]                # do not promote them
[competitor name]                # adjacent vendor, route around

# sales-y phrases the brand has banished
end-to-end                       # vague, almost always meaningless
best-in-class                    # impossible to verify
turn-key                         # implies more than is true
holistic                         # vague
synergy                          # corporate cliche
empower                          # promotional
unlock                           # promotional

# words that contradict the brand voice
[word] → [replacement]           # e.g. "users → operators" if the brand prefers a specific term
[word] → [replacement]
```

## How this gets used

The `writer` skill scans this file before drafting and avoids every entry. The `linter` skill flags any instance that slipped through with the suggested replacement (if provided). The `humanizer` skill applies the same list during AI-pattern removal.

## Adding to the list

Whenever you find yourself rewriting the same word repeatedly, add it here. The writer learns once.
