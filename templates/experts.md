# Experts

This file is the kit's source of truth for who can be cited. The `writer` skill picks experts from this list when adding `:::cite` blocks. The `linter` skill flags any cite that references someone not in this file (unless the cite includes a verifiable public-quote URL).

No fabrication. Every expert here must be a real person who has consented (explicitly or by virtue of public quote material being public) to being cited.

## Format

YAML-like markdown blocks, one per expert. Required fields: `name`, `title`. Strongly recommended: `linkedin`, `avatar`. Optional: `quotes` (verified public quotes you've vetted).

```yaml
- name: "Vasu Jakkal"
  title: "Corporate Vice President, Microsoft Security"
  linkedin: "https://www.linkedin.com/in/vasu-jakkal"
  avatar: "/images/experts/vasu-jakkal.jpg"
  topics:
    - AI agent security
    - observability
    - runtime governance
  quotes:
    - text: "We cannot protect what we cannot see. In the era of agentic AI, organizations need an observability control plane."
      source: "RSAC 2026 keynote, March 23 2026"
      url: "https://www.youtube.com/watch?v=BTGHBzQ4q9Y"
    - text: "AI agents must be governed much like human employees, assigned identities, permissions, and accountability."
      source: "Microsoft Security blog, March 2026"
      url: "https://www.microsoft.com/en-us/security/blog/2026/03/20/secure-agentic-ai-end-to-end/"
```

## Conventions

- **`name`**: full name as the expert publishes it.
- **`title`**: current role + company. Update when they change roles.
- **`linkedin`**: full URL, not handle.
- **`avatar`**: path relative to your project's public-assets directory. The image file must exist.
- **`topics`**: short list of subjects the expert is qualified to speak on. The writer matches articles to experts using this.
- **`quotes`**: only quotes that are publicly attributable (the expert said them on a record — keynote, blog, podcast, paper). Each quote must have a URL where it can be verified. Don't paraphrase here — quote exactly.

## Adding experts

Whenever an article needs a cite from someone new:

1. Verify the person is publicly quotable on the topic.
2. Find a public headshot the brand can use (their own LinkedIn photo, conference photo, or a published interview thumbnail). Save to your `public/images/experts/` directory.
3. Add an entry here with name, title, LinkedIn, avatar path.
4. If you have a specific quote in mind, add it to `quotes` with the source URL.
5. Commit.

## Removing experts

If an expert disavows their quote, leaves a role you cited them in, or you simply outgrow the citation, remove the entry. Existing articles that cite them will still render — the `:::cite` block has the data inline. New articles won't pick them.

## What this is not

- Not a press list. Don't include people you want to pitch.
- Not aspirational. Don't include people you'd like to cite eventually but haven't verified.
- Not a contact CRM. No email addresses or phone numbers in this file.
