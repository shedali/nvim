return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  dependencies = {
    "tom-anders/telescope-vim-bookmarks.nvim", -- For Telescope integration
  },
  config = function()
    require("marks").setup({
      -- default_mappings = true,   -- Uncomment if you want default mappings
      builtin_marks = { ".", "<", ">", "^" }, -- Enable builtin marks
      cyclic = true,                        -- Cycle through marks
      force_write_shada = false,            -- Write shada when creating marks
      refresh_interval = 250,               -- Update marks relatively quickly
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      excluded_filetypes = {},              -- Exclude no filetypes
      bookmark_0 = {                        -- Configure the appearance of bookmark signs
        sign = "⚑",
        virt_text = "bookmark",
        annotate = false,
      },
    })

    -- We'll use Telescope for searching marks, so we don't need to add specific mark keymaps here
  end,
}
