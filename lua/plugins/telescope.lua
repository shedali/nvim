-- In your plugins config file (e.g. lua/plugins/telescope.lua)
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {},
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        -- Add any extensions configuration here
      },
    })

    -- Enable telescope extension for marks
    telescope.load_extension("marks")

    -- Set up keymaps for marks
    vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Find marks", silent = true })
  end,
}
