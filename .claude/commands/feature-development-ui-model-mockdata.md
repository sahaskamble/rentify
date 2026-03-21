---
name: feature-development-ui-model-mockdata
description: Workflow command scaffold for feature-development-ui-model-mockdata in rentify.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /feature-development-ui-model-mockdata

Use this workflow when working on **feature-development-ui-model-mockdata** in `rentify`.

## Goal

Implements a new feature by adding model classes, mock data, and integrating them into the UI.

## Common Files

- `lib/models/*.dart`
- `lib/data/*.dart`
- `lib/screens/*/*.dart`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Create or update model class in lib/models/
- Add or update mock data in lib/data/
- Update or create UI screen to use the new model/data

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.