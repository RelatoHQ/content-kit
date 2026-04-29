# Customization

The skills are markdown. Edit them.

## Forking the writer skill

The most common reason to fork is to add brand-specific structural requirements the universal writer doesn't have. Examples:

- Your articles always include a "TL;DR for executives" section before the body
- Your articles use a custom directive (`:::case-study`) the universal writer doesn't know
- Your articles have a specific opening pattern (always start with a customer scenario)

To fork: edit `.claude/content-kit/skills/writer.md` (or the equivalent path from your install). The skill is loaded fresh on every invocation, so changes take effect immediately.

To pull future updates while keeping your edits: rebase your fork on upstream. If your edits are in clearly-marked sections (use `## Brand override:` headers), conflicts will be obvious.

## Adding a custom directive

The kit ships with `:::fact`, `:::cta`, `:::cite`, `:::subscribe`, `:::download`. To add `:::case-study`:

1. Add the directive to your renderer's MDX plugin (Astro, Next, etc.). The kit doesn't render — that's your stack's responsibility.
2. Add a section to writer.md telling the writer when to use it: "When the article contains a specific customer outcome with named company, dates, and measurable results, wrap that paragraph in a `:::case-study` block."
3. Update the linter skill's module list to include `case-study` for module-spacing checks.
4. Optionally add styling and hydration in your renderer.

## Overriding lint rules

Two paths.

### Per-project, via config

In `content-kit.config.md`:

```yaml
lint:
  oxford-comma: "warn"     # downgrade from error to warning
  em-dash-density: "off"   # disable entirely
  my-custom-rule: "error"  # add a new rule (must be implemented in linter.md)
```

The linter skill reads this and adjusts.

### Per-fork, via skill edit

Edit `linter.md`. Add a new rule section, remove an existing one, change auto-fix behavior. Skills are markdown — there's nothing to compile.

## Custom voice without forking

If you only need to change voice and rules (not skill behavior), edit `content-kit/voice.md` and `content-kit/forbidden-words.md`. Don't touch the skills. The writer reads voice.md every draft.

This is the path 90% of users should take. Forking skills is for cases where the writing PROCESS differs, not just the writing VOICE.

## Adding a new skill

Drop a markdown file in `.claude/content-kit/skills/your-skill.md`. Frontmatter:

```yaml
---
name: your-skill
description: One-sentence description of what this skill does and when to invoke it.
---
```

Then the body — instructions for Claude written like the existing skills. Use the existing skills as patterns. Reference other skills by name.

## Adding a new slash command

Drop a markdown file in `.claude/content-kit/commands/your-command.md`. Frontmatter:

```yaml
---
description: One-sentence description shown in `/` autocomplete.
---
```

Body: invocation syntax, what the command does, what skills it composes, what the user gets back, behavior with/without Relato.

## Removing what you don't need

You don't need to use every skill or every command. Delete what you don't use. The kit doesn't break if `briefer.md` is missing — the writer skill simply can't fall back to brief synthesis when called with a bare topic.

## Sharing your customizations upstream

If your customization is generally useful (a new universal rule, a better AI-pattern, a structural requirement everyone needs), open a PR at `relato/content-kit`. Brand-specific edits stay in your fork.
