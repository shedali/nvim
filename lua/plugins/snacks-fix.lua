-- Fix Snacks loading order to prevent errors
-- LazyVim v14 expects Snacks to be available, but we're lazy-loading by default
-- This ensures Snacks is loaded before any LSP keymaps try to use it
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    -- Ensure Snacks is loaded before LSP attaches
    if not package.loaded["snacks"] and not _G.Snacks then
      pcall(require, "snacks")
    end
  end,
})

return {
  {
    "folke/snacks.nvim",
    priority = 10000, -- Load VERY early
    lazy = false, -- Never lazy-load
    config = function(_, opts)
      local snacks = require("snacks")
      snacks.setup(opts)
      -- Make it globally available for LazyVim
      _G.Snacks = snacks
    end,
  },
}
