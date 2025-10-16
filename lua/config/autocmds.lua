-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable conceal for code blocks in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Set conceallevel to 0 to disable all concealment in markdown
    -- This ensures code blocks are fully visible
    vim.opt_local.conceallevel = 0
    vim.opt_local.concealcursor = ""
  end,
  desc = "Disable conceal for markdown files to show code blocks"
})

-- TidalCycles file type detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tidal",
  callback = function()
    vim.bo.filetype = "tidal"
  end,
  desc = "Set filetype for TidalCycles files",
})
