```markdown
# rentify Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches you the core development conventions and workflows used in the `rentify` TypeScript codebase. You'll learn how to structure files, write imports and exports, follow commit message patterns, and run or write tests according to the project's standards.

## Coding Conventions

### File Naming
- Use **snake_case** for all file names.
  - Example: `user_service.ts`, `rental_utils.ts`

### Imports
- Use **relative imports** for referencing other modules.
  - Example:
    ```typescript
    import { calculateRent } from './rental_utils';
    ```

### Exports
- Use **named exports** for module members.
  - Example:
    ```typescript
    // rental_utils.ts
    export function calculateRent(...) { ... }
    ```

### Commit Messages
- Commit messages are **freeform** (no enforced prefix), but are typically concise (average 64 characters).
  - Example:
    ```
    Add validation for rental period in booking form
    ```

## Workflows

### Adding a New Feature
**Trigger:** When implementing a new functionality
**Command:** `/add-feature`

1. Create a new file using snake_case (e.g., `feature_name.ts`).
2. Write your code using named exports.
3. Use relative imports to include dependencies.
4. Write corresponding tests in a `feature_name.test.ts` file.
5. Commit your changes with a clear, concise message.

### Running Tests
**Trigger:** When verifying code correctness
**Command:** `/run-tests`

1. Locate test files matching the `*.test.*` pattern.
2. Use the project's test runner (framework unknown; check project scripts or documentation).
3. Run all tests and ensure they pass before committing changes.

### Refactoring Code
**Trigger:** When improving or restructuring existing code
**Command:** `/refactor`

1. Update file and variable names to follow snake_case and named exports.
2. Change imports to use relative paths if not already.
3. Update associated tests if needed.
4. Commit with a message describing the refactor.

## Testing Patterns

- Test files use the `*.test.*` naming pattern (e.g., `user_service.test.ts`).
- The testing framework is not specified; check for scripts or documentation for details.
- Place tests alongside or near the code they test.
- Example test file:
  ```typescript
  // user_service.test.ts
  import { getUser } from './user_service';

  describe('getUser', () => {
    it('returns user data for a valid ID', () => {
      // test implementation
    });
  });
  ```

## Commands
| Command       | Purpose                                   |
|---------------|-------------------------------------------|
| /add-feature  | Start the process of adding a new feature |
| /run-tests    | Run all test files in the codebase        |
| /refactor     | Begin a code refactor workflow            |
```