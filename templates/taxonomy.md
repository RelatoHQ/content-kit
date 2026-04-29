# Taxonomy

This file declares the brand's content structure: categories, authors, frontmatter requirements, link conventions. The writer, editor, publisher, and linter skills all read it.

## Categories

The set of allowable values for the `category` frontmatter field. One per article.

```
- governance
- compliance
- operations
- security
- [your category]
```

Replace with your brand's pillars. Three to seven is typical.

## Content pillars

If your editorial strategy organizes content into pillars (separate from `category`), declare them here. The writer uses pillars to decide article shape, length, and angle. Skip this section if you don't use pillars.

```
- Governance Gap         framework / position pieces
- Operational Intelligence  playbooks / control deep-dives
- Compliance & Regulation   regulatory explainers / sector-specific
```

## Default author

The author value applied when the writer doesn't ask. Should match an entry in your team's profile system.

```
defaultAuthor: [your-author-id]
```

## Internal link roots

Paths the writer is allowed to link to internally. The linter flags links that fall outside these roots.

```
- /research/blog          your existing blog catalog
- /platform              product capability pages
- /solutions             solution / industry pages
- /docs                  documentation
```

## Product link requirement

The writer must include at least one link to a path under one of these roots in every article. The linter errors if missing.

```
productLinkRoots:
  - /platform
  - /solutions

productLinkRequired: true
productLinkMin: 1
productLinkMax: 3
```

## Frontmatter

Fields every article must have, with their requirements. The writer populates these on draft. The publisher and linter validate them at publish time.

```
required:
  - title              string, no em dashes, sentence case
  - date               ISO YYYY-MM-DD
  - author             must equal defaultAuthor or be in authors list
  - excerpt            1-3 sentences
  - category           one of the category values above
  - tags               array, lowercase, at least one
  - draft              boolean, must be false at publish
  - tldr               one-paragraph article summary
  - seo.title          string, no em dashes
  - seo.description    string, 50-160 characters
  - faqs               array of {question, answer}, minimum 5

optional:
  - updated            ISO YYYY-MM-DD if revised after publish
  - briefId            Relato project ID if originated there
  - pillar             one of the pillars above
```

## Slug format

How URL slugs are generated from titles.

```
slugFormat: kebab-case        # lowercase, hyphens, no special chars
slugMaxLength: 80
```

## Output destination

Where the publisher writes the final markdown. Override in `content-kit.config.md` if you don't want the default.

```
output:
  directory: content-kit/articles
  filename: "{slug}.md"
```
