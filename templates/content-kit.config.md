# content-kit.config

Optional. Override the kit's path conventions or declare your Relato workspace. Most projects don't need this file — the kit's defaults work for the majority of layouts.

## Defaults

| Setting | Default | Purpose |
|---|---|---|
| voice file | `content-kit/voice.md` | Brand voice and perspective |
| forbidden-words file | `content-kit/forbidden-words.md` | Brand-specific banned vocabulary |
| taxonomy file | `content-kit/taxonomy.md` | Categories, authors, frontmatter |
| experts file | `content-kit/experts.md` | Citable people |
| articles output directory | `content-kit/articles/` | Where publisher writes finalized markdown |
| briefs output directory | `briefs/` | Where briefer writes local briefs |
| relato workspace ID | (none) | Required for `/queue`, `/brief --relato`, etc. |
| em-dash policy | from voice.md | `allow` if voice.md doesn't declare |
| oxford-comma policy | from voice.md | `ap` if voice.md doesn't declare |

## Format

```yaml
voice: "./content/guides/voice.md"
forbiddenWords: "./content/guides/forbidden-words.md"
taxonomy: "./content/guides/taxonomy.md"
experts: "./content/guides/experts.md"

articles:
  directory: "./src/content/blog"
  filename: "{slug}.md"

briefs:
  directory: "./briefs"

relato:
  workspaceId: "019d39a9-262c-7ba4-894d-060974d819eb"

# Optional rule severity overrides for the linter
lint:
  oxford-comma: "warn"     # downgrade from default error
  em-dash-density: "off"   # disable a rule entirely
```

## When to use this file

- Your existing project layout doesn't match the kit's conventions and you don't want to migrate paths
- You have multiple Relato workspaces and want to be explicit about which one this project uses
- You want to override default lint severities for your team's preferences

## When to skip it

- You're starting fresh and following the kit conventions — the four guideline files at `content-kit/` are enough
- You only want to use the writer/editor/humanizer/linter skills (no calendar integration) — voice.md, forbidden-words.md, taxonomy.md, experts.md cover everything

## Where this file lives

Project root: `./content-kit.config.md`. The skills look for it there first.
