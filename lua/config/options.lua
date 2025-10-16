-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable conceal globally to ensure code blocks are visible
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

-- Ensure code blocks are visible in markdown
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
