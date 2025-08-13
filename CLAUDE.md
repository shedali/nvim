# Neovim Configuration Instructions

## Overview
This is a Neovim configuration using:
- **Package Manager**: Nix
- **Plugin Manager**: Lazy.nvim
- **OS**: macOS (Darwin)

## Key Information
- Configuration directory: `~/.config/nvim/`
- Main configuration file: `init.lua`
- Plugin specifications: `lua/plugins/` directory
- Lock file: `lazy-lock.json`

## Debugging Commands
When debugging or testing changes:
```bash
# Check for startup errors
nvim --headless +qa 2>&1

# Start Neovim with minimal config for testing
nvim -u NONE

# Check health status
nvim --headless "+checkhealth" "+qa" 2>&1
```

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