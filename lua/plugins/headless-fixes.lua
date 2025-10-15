-- Silence noisy plugins globally
return {
  -- Disable gitsigns in headless mode only
  {
    "lewis6991/gitsigns.nvim",
    cond = function()
      return #vim.api.nvim_list_uis() > 0
    end,
  },
}
