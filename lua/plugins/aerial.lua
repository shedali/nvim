return {
  "stevearc/aerial.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}