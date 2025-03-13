return {
  'lexay/telescope-zoxide.nvim',
  config = function()
    require('telescope').load_extension 'zoxide'
  end,
}
