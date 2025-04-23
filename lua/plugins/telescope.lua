-- In your plugins config file (e.g. lua/plugins/telescope.lua)
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {},
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },
}
