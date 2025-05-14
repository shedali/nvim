return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = function()
    require('neogit').setup {
      kind = "split",
      -- Enable the following setting to allow staging visually selected lines
      mappings = {
        -- Modify the status buffer mappings
        status = {
          -- Stage visually selected lines
          ["s"] = "Stage",
        },
      },
    }
    vim.keymap.set('n', '<leader>gs', require('neogit').open, { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>gB', ':Telescope git_branches<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>gb', ':Neogit blame<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>gP', ':Neogit push<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { silent = true, noremap = true })

    -- Add the visual mode mapping for staging selected lines
    vim.keymap.set('v', '<leader>gs', ':Neogit kind=split action=stage<CR>', { silent = true, noremap = true })
  end,
}
