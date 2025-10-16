# Neovim TODO Management

This document describes the TODO management features available in your Neovim configuration.

## Keybindings

| Keybinding    | Mode | Description                                       |
|---------------|------|---------------------------------------------------|
| `<leader>tt`  | n    | Insert TODO comment (context-aware)               |
| `<leader>tn`  | n    | Create a new TODO note in Obsidian                |
| `<leader>tl`  | n    | List all TODOs in the project via Telescope       |
| `]T`          | n    | Jump to next TODO in the current buffer           |
| `[T`          | n    | Jump to previous TODO in the current buffer       |

## Features

### Insert TODO Comment (`<leader>tt`)
- Automatically detects the appropriate comment syntax based on file type
- Maintains current indentation level
- Positions cursor at the end of the TODO placeholder
- Enters insert mode ready for you to type the todo description
- Works in all major file types with proper comment syntax

### Create TODO Note in Obsidian (`<leader>tn`)
- Creates a structured TODO note in your Obsidian vault
- Includes proper frontmatter with aliases and tags
- Provides a template with Description, Tasks, and Notes sections
- Automatically positions cursor at the first task item
- Prompts for a title (defaults to timestamp-based name)

### List All TODOs (`<leader>tl`)
- Uses Telescope to provide an interactive list of all TODOs
- Searches for:
  - Standard TODO comments (`TODO:`)
  - Test todos (`test.todo`, `it.todo`)
- Shows file path, line number, and content
- Allows quick navigation to any TODO in the project

### Navigation Between TODOs (`]T` and `[T`)
- Jump to the next/previous TODO in the current buffer
- Works with:
  - Standard TODO comments (`TODO:`)
  - Test todos (`test.todo`, `it.todo`)
- Provides notification when no more TODOs are found

## Examples

### Using TODO Comments in Code

```typescript
function calculateTotal() {
  // TODO: Add tax calculation
  return price * quantity;
}
```

### Test TODOs

```typescript
describe('Payment Module', () => {
  test.todo('should calculate taxes correctly');
  
  it('should apply discounts', () => {
    // test code here
  });
  
  it.todo('should handle international currencies');
});
```

### Obsidian TODO Note Structure

```markdown
---
aliases: [Project Refactoring, todo20240515120023]
tags: [todo]
---

# Project Refactoring

## Description

<!-- What needs to be done? -->
Refactor the payment processing module to improve maintainability

## Tasks

- [ ] Extract payment processor into separate class
- [ ] Add unit tests for edge cases
- [ ] Update documentation

## Notes

<!-- Additional context, ideas, references -->
Reference the PaymentAPI docs at https://example.com/docs
```