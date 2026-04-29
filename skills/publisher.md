---
name: publisher
description: Finalize a draft for publication. Validates frontmatter, writes the file to the configured output path, optionally updates Relato stage. Pipeline ends here.
---

# publisher

You are finishing the pipeline. The draft is complete and reviewed; your job is to make sure the file is shippable and to put it where the user wants it.

## Step 1 — Load the brand context

Read `content-kit/taxonomy.md` for the frontmatter requirements and `content-kit.config.md` for output path overrides.

Default output path is `content-kit/articles/{slug}.md`.

## Step 2 — Validate the file

Open the draft. Check:

### Frontmatter completeness

Every field listed `required` in `taxonomy.md` must be present and non-empty. Common required fields:

- `title` (no em dashes, sentence case unless taxonomy says otherwise)
- `date` (ISO `YYYY-MM-DD` format)
- `author` (string from taxonomy's authors list, or default)
- `excerpt` (1-3 sentences)
- `category` (from taxonomy categories)
- `tags` (array, at least one tag, lowercase)
- `draft` (boolean — almost always `false` at publish time)
- `tldr` (one-paragraph article summary)
- `seo.title` and `seo.description`
- `faqs` (array — count must meet `taxonomy.md` minimum, typically 5)

If any field is missing or malformed, stop and tell the user what to fix. Don't guess values.

### Content checks

- The article has a hook in the opening paragraph (no preamble, no definition opener).
- At least one `:::cite` block, with avatar and LinkedIn where the expert has them.
- At least one `:::fact` callout.
- At least one `:::cta` at the close.
- A sources table with at least one external citation.
- Internal link count between the brand's `taxonomy.md` minimum and maximum (typically 1-3).
- At least one product link to the link roots in `taxonomy.md` (e.g. `/platform/*`, `/solutions/*`).

If any structural check fails, stop and tell the user.

### Lint and humanizer pass

Invoke the `linter` skill. Block on any error-level findings. Pass on warnings.

Invoke the `humanizer` skill. If it makes changes, run the linter again. (Some humanizer fixes can introduce structural issues.)

## Step 3 — Decide on output location

If the file is already at the configured output path, no move needed.

If the file is in `briefs/`, `drafts/`, or any other staging location, move it (or write a copy) to the configured output path. Use the Write tool to write the validated content. Don't shell-move — the validated copy is canonical.

If the file is at the configured output path under a different slug than the article's frontmatter title suggests, ask the user whether to rename.

## Step 4 — Update the calendar (if Relato is connected)

If the user invoked publisher with a brief ID, or if the article's frontmatter contains a `briefId` field linking to a Relato project:

- Move the project from its current stage to the brand's "Review" stage (look up the stage ID from the workspace's stages).
- If the user explicitly said "ship today" or used `/publish`, move to "Published" instead.
- Set the publishDate if the article's `date` differs from the existing publishDate.

If Relato isn't connected, skip this step.

## Step 5 — Report

```
✓ Published-ready: <output path>
  - Title: <title>
  - Date: <date>
  - Word count: <count>
  - Modules: <fact: N, cite: N, cta: N, figures: N>
  - Citations: <count>
  - Lint: clean
  - Humanizer: clean

Calendar update: <Relato project ID moved to <stage>, or "skipped (no Relato workspace)">

The file is ready. Commit and push when you're ready — content-kit does not deploy.
```

## When to stop and ask

- A required frontmatter field is missing → list the fields, ask the user to fill them
- The article fails a structural check → name the failure, ask whether to fix or override
- A `:::cite` block references a person not in `experts.md` AND has no public-quote URL → stop, ask
- Lint reports an error-level finding the humanizer can't auto-fix → stop, ask
- The output path already has a file at this slug → ask whether to overwrite

## What you do not do

- You do not deploy. The kit ends at writing the markdown file. The user's deploy is their concern.
- You do not commit, push, or run any git command.
- You do not move a Relato project to "Published" unless the user explicitly published (used `/publish` or said "ship today" / "ship it"). Default to "Review."
- You do not regenerate the article. If validation fails badly enough that a rewrite is needed, send the user back to `/revise` or `/draft`.
