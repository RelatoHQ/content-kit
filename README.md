# content-kit

AI-assisted blog production for Claude Code. A set of skills and slash commands that draft, revise, lint, and ship long-form articles in your brand voice.

The pipeline ends at a markdown file. What you do with that file (Astro, Next, Hugo, Notion, paste-and-publish) is entirely up to you.

## What you get

- 6 skills (`writer`, `editor`, `humanizer`, `briefer`, `publisher`, `linter`)
- 6 slash commands (`/draft`, `/revise`, `/lint`, `/humanize`, `/brief`, `/queue`)
- Universal writing craft baked in: E-E-A-T enforcement, AI-pattern removal, BLUF/MECE structure, sentence rhythm, evidence requirements
- Brand voice loaded from four markdown files you maintain

## What this is not

- A renderer. No theme, no Astro/Next/Hugo adapter. The kit writes markdown to a path you specify.
- A deploy tool. No CI, no cron, no build step.
- A CMS. Calendar and brief management live in [Relato](https://relato.com), accessed through your Relato MCP.

## Install

One command from your project root:

```bash
curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh | bash
```

That clones the kit into `.claude/content-kit/`, symlinks the skills and commands into `.claude/`, copies the four guideline templates into `content-kit/`, and adds the cloned kit to your `.gitignore`. Idempotent — safe to re-run to update.

Edit `content-kit/voice.md` (the only required customization) and you're ready to draft.

### Variants

| Use case | Command |
|---|---|
| In-project (default) — kit lives in `.claude/`, gitignored | `curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh \| bash` |
| User-wide — one install for all projects | `curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh \| bash -s -- --user` |
| Submodule — kit version pinned in your repo | `curl -fsSL https://raw.githubusercontent.com/RelatoHQ/content-kit/main/install.sh \| bash -s -- --submodule` |

### Manual install

If you'd rather run the steps yourself:

```bash
git clone git@github.com:RelatoHQ/content-kit.git .claude/content-kit
ln -s ../content-kit/skills   .claude/skills/content-kit
ln -s ../content-kit/commands .claude/commands/content-kit
mkdir content-kit
cp .claude/content-kit/templates/{voice,forbidden-words,taxonomy,experts}.md content-kit/
echo ".claude/content-kit/" >> .gitignore
```

## Calendar and briefs (Relato)

The `briefer`, `publisher` skills and the `/brief` and `/queue` slash commands integrate with Relato through the Relato MCP server. Active Relato workspaces have it provisioned automatically — no extra install.

Without a Relato workspace:
- `/draft <topic>` and the rest of the writing pipeline still work — you can produce articles end to end
- `/draft <brief-id>`, `/queue`, and `/brief` return "Relato workspace required" and stop politely
- The writer pipeline's "move to Review" step is skipped

To activate a Relato workspace: see [docs/relato-setup.md](docs/relato-setup.md).

## Configuration

Four required files, all markdown, all maintained by you. The kit looks for them at `./content-kit/<name>.md` by convention:

```
your-project/
├── content-kit/
│   ├── voice.md             What makes your content different. Voice adjectives.
│   │                        Perspective. The "old way" you name. Brand soul.
│   ├── forbidden-words.md   Brand-specific banned vocabulary. Adds to the kit's
│   │                        universal AI-pattern list — does not replace it.
│   ├── taxonomy.md          Categories, default author, internal link roots,
│   │                        frontmatter requirements.
│   └── experts.md           Citable people: name, title, LinkedIn, headshot path,
│                            optional public quote material. No fabrication.
└── (your codebase)
```

Templates with examples are in [templates/](templates/). Copy them in, replace the placeholders with your brand, you're done.

Optional fifth file:

```
content-kit/
└── content-kit.config.md    Path overrides if you don't want the conventions.
                              Output directory. Filename template.
                              Calendar workspace ID.
```

If `voice.md` is missing, the writer skill stops and tells you to create one. There is no generic-voice fallback — empty config means the kit refuses to write in someone else's voice for you.

## Slash commands

| Command | What it does |
|---|---|
| `/draft <topic-or-brief-id>` | Research primary sources, draft a markdown article in your voice, run lint and humanizer passes, write to disk |
| `/revise <file> <feedback>` | Apply feedback to an existing draft, preserving voice and structure |
| `/lint <file>` | Audit pass: checks Oxford commas, paragraph length, AI patterns, banned words, structural requirements. Reports findings, offers fixes. |
| `/humanize <file>` | AI-pattern removal pass. Strips inflated language, hedge words, AI tells |
| `/brief <topic>` | Turn a raw idea into a structured brief. Creates a Relato project if a workspace is connected, otherwise writes a local `briefs/<slug>.md` |
| `/queue [list\|next\|move]` | Calendar operations against your Relato workspace |

## Skills

The slash commands compose these skills. You can invoke skills directly too if you want finer control:

| Skill | Loaded by |
|---|---|
| [`writer`](skills/writer.md) | `/draft`, `/revise` |
| [`editor`](skills/editor.md) | `/revise` |
| [`humanizer`](skills/humanizer.md) | `/humanize`, end of `/draft` |
| [`briefer`](skills/briefer.md) | `/brief`, `/draft <topic>` |
| [`publisher`](skills/publisher.md) | end of `/draft`, end of `/revise` |
| [`linter`](skills/linter.md) | `/lint`, end of `/draft` |

## Customization

Fork the repo and edit any skill. Skills are pure markdown — no compilation, no version constraints. To pull future updates while keeping your edits, rebase or cherry-pick.

If you have generic improvements (new universal lint rule, better AI-pattern catalog, a structural requirement everyone needs), open a PR upstream.

## Docs

- [Getting started](docs/getting-started.md)
- [Customization](docs/customization.md)
- [Relato setup](docs/relato-setup.md)

## License

MIT. See [LICENSE](LICENSE).
