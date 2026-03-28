return {
  'stevearc/oil.nvim',
  enabled = true,
  opts = {},
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons', lazy = false },
}
