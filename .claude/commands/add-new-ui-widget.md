---
name: add-new-ui-widget
description: Workflow command scaffold for add-new-ui-widget in rentify.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /add-new-ui-widget

Use this workflow when working on **add-new-ui-widget** in `rentify`.

## Goal

Adds new UI widget components for a screen, typically as part of building out a screen's interface.

## Common Files

- `lib/screens/*/widgets/*.dart`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Create new Dart files for each widget in the appropriate widgets/ directory under the screen.
- Implement the widget logic and UI.
- (Optionally) Update the parent screen to use the new widgets.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.