return {
  'NeogitOrg/neogit',
  version = "*", -- Use stable releases
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = function()
    -- Set up highlight groups before initializing Neogit
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Ensure highlight groups exist
        vim.api.nvim_set_hl(0, "NeogitDiffAdd", { link = "DiffAdd" })
        vim.api.nvim_set_hl(0, "NeogitDiffDelete", { link = "DiffDelete" })
        vim.api.nvim_set_hl(0, "NeogitDiffContext", { link = "Normal" })
        vim.api.nvim_set_hl(0, "NeogitHunkHeader", { link = "Function" })
        vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", { link = "Function" })
      end,
    })
    
    -- Trigger ColorScheme to set up highlights
    vim.cmd("doautocmd ColorScheme")
    
    require('neogit').setup {
      kind = "split",
      disable_commit_confirmation = false,
      disable_builtin_notifications = false,
      disable_insert_on_commit = false,
      -- Enable the following setting to allow staging visually selected lines
      mappings = {
        -- Modify the status buffer mappings
        status = {
          -- Stage visually selected lines
          ["s"] = "Stage",
        },
      },
      -- Ensure highlight groups are properly initialized
      highlight = {
        italic = true,
        bold = true,
        underline = true
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
