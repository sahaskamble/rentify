---
name: rentify-conventions
description: Development conventions and patterns for rentify. Swift project with conventional commits.
---

# Rentify Conventions

> Generated from [sahaskamble/rentify](https://github.com/sahaskamble/rentify) on 2026-03-21

## Overview

This skill teaches Claude the development patterns and conventions used in rentify.

## Tech Stack

- **Primary Language**: Swift
- **Architecture**: hybrid module organization
- **Test Location**: separate

## When to Use This Skill

Activate this skill when:
- Making changes to this repository
- Adding new features following established patterns
- Writing tests that match project conventions
- Creating commits with proper message format

## Commit Conventions

Follow these commit message conventions based on 9 analyzed commits.

### Commit Style: Conventional Commits

### Prefixes Used

- `feat`
- `chore`
- `fix`

### Message Guidelines

- Average message length: ~40 characters
- Keep first line concise and descriptive
- Use imperative mood ("Add feature" not "Added feature")


*Commit message example*

```text
fix: use SliverPadding for ListingsGrid in CustomScrollView
```

*Commit message example*

```text
chore: final verification - build passing
```

*Commit message example*

```text
feat: add home screen with complete UI implementation
```

*Commit message example*

```text
feat: add all home screen UI widgets
```

*Commit message example*

```text
feat: add listing model and mock data
```

*Commit message example*

```text
feat: add theme files with colors and text styles
```

*Commit message example*

```text
chore: add worktree directories to gitignore
```

*Commit message example*

```text
Backend git setuped
```

## Architecture

### Project Structure: Single Package

This project uses **hybrid** module organization.

### Guidelines

- This project uses a hybrid organization
- Follow existing patterns when adding new code

## Code Style

### Language: Swift

### Naming Conventions

| Element | Convention |
|---------|------------|
| Files | camelCase |
| Functions | camelCase |
| Classes | PascalCase |
| Constants | SCREAMING_SNAKE_CASE |

### Import Style: Relative Imports

### Export Style: Named Exports


*Preferred import style*

```typescript
// Use relative imports
import { Button } from '../components/Button'
import { useAuth } from './hooks/useAuth'
```

*Preferred export style*

```typescript
// Use named exports
export function calculateTotal() { ... }
export const TAX_RATE = 0.1
export interface Order { ... }
```

## Error Handling

### Error Handling Style: Try-Catch Blocks


*Standard error handling pattern*

```typescript
try {
  const result = await riskyOperation()
  return result
} catch (error) {
  console.error('Operation failed:', error)
  throw new Error('User-friendly message')
}
```

## Common Workflows

These workflows were detected from analyzing commit patterns.

### Feature Development

Standard feature implementation workflow

**Frequency**: ~17 times per month

**Steps**:
1. Add feature implementation
2. Add tests for feature
3. Update documentation

**Files typically involved**:
- `**/*.test.*`

**Example commit sequence**:
```
chore: add worktree directories to gitignore
feat: add theme files with colors and text styles
feat: add listing model and mock data
```

### Add New Ui Widget

Adds new UI widget components for a screen, typically as part of building out a screen's interface.

**Frequency**: ~2 times per month

**Steps**:
1. Create new Dart files for each widget in the appropriate widgets/ directory under the screen.
2. Implement the widget logic and UI.
3. (Optionally) Update the parent screen to use the new widgets.

**Files typically involved**:
- `lib/screens/*/widgets/*.dart`

**Example commit sequence**:
```
Create new Dart files for each widget in the appropriate widgets/ directory under the screen.
Implement the widget logic and UI.
(Optionally) Update the parent screen to use the new widgets.
```

### Feature Development Ui Model Mockdata

Implements a new feature by adding model classes, mock data, and integrating them into the UI.

**Frequency**: ~2 times per month

**Steps**:
1. Create or update model class in lib/models/
2. Add or update mock data in lib/data/
3. Update or create UI screen to use the new model/data

**Files typically involved**:
- `lib/models/*.dart`
- `lib/data/*.dart`
- `lib/screens/*/*.dart`

**Example commit sequence**:
```
Create or update model class in lib/models/
Add or update mock data in lib/data/
Update or create UI screen to use the new model/data
```

### Add Theme Files

Adds or updates theme files for colors and text styles to maintain consistent design.

**Frequency**: ~2 times per month

**Steps**:
1. Create or update color definitions in lib/theme/app_colors.dart
2. Create or update text style definitions in lib/theme/app_text_styles.dart

**Files typically involved**:
- `lib/theme/app_colors.dart`
- `lib/theme/app_text_styles.dart`

**Example commit sequence**:
```
Create or update color definitions in lib/theme/app_colors.dart
Create or update text style definitions in lib/theme/app_text_styles.dart
```

### Project Setup Or Platform Update

Initializes or updates project/platform-specific files, such as build configs, lock files, and plugin registrants.

**Frequency**: ~2 times per month

**Steps**:
1. Update pubspec.yaml and pubspec.lock
2. Update platform-specific plugin registrant files (e.g., macos/Flutter/GeneratedPluginRegistrant.swift)
3. Update .gitignore as needed

**Files typically involved**:
- `pubspec.yaml`
- `pubspec.lock`
- `macos/Flutter/GeneratedPluginRegistrant.swift`
- `.gitignore`

**Example commit sequence**:
```
Update pubspec.yaml and pubspec.lock
Update platform-specific plugin registrant files (e.g., macos/Flutter/GeneratedPluginRegistrant.swift)
Update .gitignore as needed
```


## Best Practices

Based on analysis of the codebase, follow these practices:

### Do

- Use conventional commit format (feat:, fix:, etc.)
- Use camelCase for file names
- Prefer named exports

### Don't

- Don't write vague commit messages
- Don't deviate from established patterns without discussion

---

*This skill was auto-generated by [ECC Tools](https://ecc.tools). Review and customize as needed for your team.*
