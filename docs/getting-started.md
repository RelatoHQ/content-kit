# Getting started

Five steps to a working content-kit setup.

## 1. Install

Pick one. The first option is the most common — skills travel with your repo, your team gets them automatically.

```bash
# A. Inside your project (committed, team-shared)
cd your-project
git clone git@github.com:relato/content-kit.git .claude/content-kit
ln -s ../content-kit/skills .claude/skills/content-kit
ln -s ../content-kit/commands .claude/commands/content-kit

# B. User-wide (across all your projects)
git clone git@github.com:relato/content-kit.git ~/.claude/content-kit
ln -s ~/.claude/content-kit/skills ~/.claude/skills/content-kit
ln -s ~/.claude/content-kit/commands ~/.claude/commands/content-kit

# C. Submodule (versioned with your repo)
cd your-project
git submodule add git@github.com:relato/content-kit.git .claude/content-kit
ln -s ../content-kit/skills .claude/skills/content-kit
ln -s ../content-kit/commands .claude/commands/content-kit
```

## 2. Create your guideline files

The kit needs four markdown files at `content-kit/` in your project. Copy the templates and edit.

```bash
mkdir -p content-kit
cp .claude/content-kit/templates/voice.md content-kit/voice.md
cp .claude/content-kit/templates/forbidden-words.md content-kit/forbidden-words.md
cp .claude/content-kit/templates/taxonomy.md content-kit/taxonomy.md
cp .claude/content-kit/templates/experts.md content-kit/experts.md
```

Edit each:

- **voice.md** — the brand soul. What makes your content different, voice adjectives, perspective. Most important file.
- **forbidden-words.md** — vocabulary you've banished. The kit's universal AI-pattern list applies on top.
- **taxonomy.md** — categories, default author, internal link roots, frontmatter requirements.
- **experts.md** — citable people with name, title, LinkedIn, headshot path.

If you skip `voice.md`, the writer skill stops with an error. The other three are also required but have less impact if minimal.

## 3. (Optional) Connect Relato

If you have a Relato workspace, the calendar/brief commands (`/queue`, `/brief`, `/draft <brief-id>`) become available. See [relato-setup.md](relato-setup.md).

If you don't, the writer/editor/humanizer/linter pipeline still works fully. `/draft <topic>` produces articles end to end without any Relato dependency.

## 4. Draft your first article

Start Claude Code in your project root:

```bash
claude
```

Then in the session:

```
/draft "the lethal trifecta in agent governance"
```

The writer will:

1. Synthesize a working brief from the topic
2. Fetch primary sources via WebFetch
3. Verify the brief's premise against what the sources actually say
4. Draft a markdown article in your voice
5. Run humanizer and linter passes
6. Write the file to `content-kit/articles/<slug>.md`
7. Report back with word count, modules, citations, lint status

Read the file. If it's good, commit. If you want changes:

```
/revise content-kit/articles/lethal-trifecta.md "the opening is too generic — lead with the January 2026 incidents"
```

## 5. Iterate

The kit doesn't deploy. What you do with the markdown file — Astro build, Next.js, Hugo, paste into Notion, copy to a CMS — is your existing pipeline's job.

Common loop:

1. `/brief <topic>` to plan
2. `/draft <brief-id>` (or `/draft <topic>` if no Relato) to produce v1
3. Review on the live site (your renderer's preview, not the kit's concern)
4. `/revise <file> <feedback>` until it's right
5. Commit and push to wherever your site lives

## Where to go next

- [Customization](customization.md) — fork and edit skills, override lint rules, adapt the writer
- [Relato setup](relato-setup.md) — activate the calendar / brief integration
