# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration based on LazyVim with custom plugins and settings. The configuration is organized following LazyVim conventions with modifications for specific workflows:

- Knowledge management with Obsidian integration
- GitHub-centric development with Neogit and Octo
- Testing workflow with Neotest
- Enhanced navigation with Telescope, marks, and zoxide

## Technical Details

### System Information
- **Package Manager**: Nix
- **Plugin Manager**: Lazy.nvim
- **OS**: macOS (Darwin)
- Configuration directory: `~/.config/nvim/`
- Main configuration file: `init.lua`
- Plugin specifications: `lua/plugins/` directory
- Lock file: `lazy-lock.json`

## Configuration Structure

- `init.lua`: Bootstrap file that initializes the configuration
- `lua/config/`: Core configuration files
  - `lazy.lua`: Plugin manager setup
  - `keymaps.lua`: Custom key mappings
  - `options.lua`: Neovim options
  - `autocmds.lua`: Autocommands
- `lua/plugins/`: Individual plugin configurations

## Key Plugins and Features

### Plugin Management
- Uses lazy.nvim for plugin management with LazyVim preset
- Leader key is `;` instead of space

### Git Integration
- Neogit for Git operations
  - Visual staging with `<leader>gs` in visual mode
  - Git status with `<leader>gs` in normal mode

### Knowledge Management
- Obsidian integration with extensive mappings
  - `<leader>ot`: Open today's note
  - `<leader>ob`: Open backlinks
  - `<leader>om`: Move notes between folders

### Navigation
- Telescope with extensions:
  - Find files: `<leader><leader>`
  - Live grep: `<leader>fg`
  - Marks navigation: `<leader>fm`
- Marks management:
  - Add/remove mark: `<leader>ma`
  - Jump to next/prev mark: `<leader>mj`/`<leader>mk`

### GitHub PR Management
- Octo.nvim for GitHub operations
  - PR list: `<leader>pl`
  - PR checkout: `<leader>pC`

### Testing
- Neotest integration with vitest
  - Run test: `<leader>trt`
  - Toggle summary: `<leader>ts`

### Session Management
- Persistence.nvim for session handling
  - Load session: `<leader>ql`
  - Save session: `<leader>qs`

## Development Commands

### Debugging Commands
When debugging or testing changes:
```bash
# Check for startup errors
nvim --headless +qa 2>&1

# Start Neovim with minimal config for testing
nvim -u NONE

# Check health status
nvim --headless "+checkhealth" "+qa" 2>&1
```

### Configuration Management
To configure Neovim:
1. Edit configuration files in `~/.config/nvim/`
2. Source the changes with `:so %` or restart Neovim
3. Check for plugin updates with `:Lazy update`
4. Install new plugins by adding them to the appropriate file in `lua/plugins/`

## Important Notes
- This configuration uses Nix for system package management
- Lazy.nvim handles plugin installation and management
- Always check `lazy-lock.json` when debugging plugin issues
- Use `:Lazy` command in Neovim to manage plugins
- Use `:checkhealth` to diagnose issues

## Common Issues
- Plugin dependencies might need to be installed via Nix
- Binary dependencies (language servers, formatters, etc.) should be managed through Nix
- Check that all required Lua modules are properly loaded
- **nil_ls/null-ls errors**: LazyVim now uses conform.nvim and nvim-lint instead of null-ls. Mason integration is handled in `lua/plugins/mason-fix.lua`
- **obsidian.nvim path errors**: Check workspace paths exist in `lua/plugins/obsidian.lua`
- **render-markdown Snacks errors**: Fixed with custom config in `lua/plugins/render-markdown-fix.lua`
- **octo.nvim configuration errors**: Ensure `timeline_indent` is a number, not a string. Fixed in `lua/plugins/octo.lua`

## Customization Guidelines

When adding new plugins or features:
1. Follow the LazyVim plugin structure
2. Maintain the current keybinding scheme (`;` as leader)
3. Group related functionality with consistent prefixes
4. Place plugin-specific configurations in separate files in `lua/plugins/`
