return {
  {
    "grddavies/tidal.nvim",
    ft = { "tidal", "haskell" }, -- Load for Tidal and Haskell files
    cmd = { "TidalLaunch", "TidalQuit" }, -- Load on these commands
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("tidal").setup({
        -- Boot Tidal and SuperCollider processes
        boot = {
          tidal = {
            enable = true,
            args = {}, -- Additional arguments for ghci
          },
          sclang = {
            enable = false, -- Set to true if you use SuperCollider
            args = {},
          },
        },
        
        -- Keymaps configuration
        mappings = {
          send_line = "<S-Return>", -- Send current line
          send_visual = "<S-Return>", -- Send visual selection
          send_block = "<M-Return>", -- Send code block
          send_expression = "<leader><Return>", -- Send expression under cursor
          silence_d = "<leader>d", -- Silence specific pattern (d1, d2, etc.)
          silence_all = "<leader><Esc>", -- Silence all patterns
        },
        
        -- Highlight sent code
        highlight = {
          enable = true,
          duration = 150, -- milliseconds
        },
        
        -- Terminal configuration
        terminal = {
          direction = "horizontal", -- or "vertical", "float"
          size = 10, -- Terminal height (for horizontal) or width (for vertical)
        },
      })
      
      -- Additional keymaps for TidalCycles workflow
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tidal", "haskell" },
        callback = function()
          local opts = { buffer = true, silent = true }
          
          -- Launch/Quit Tidal
          vim.keymap.set("n", "<leader>tl", ":TidalLaunch<CR>", vim.tbl_extend("force", opts, { desc = "Launch Tidal" }))
          vim.keymap.set("n", "<leader>tq", ":TidalQuit<CR>", vim.tbl_extend("force", opts, { desc = "Quit Tidal" }))
          
          -- Pattern control
          vim.keymap.set("n", "<leader>th", function()
            -- Hush all patterns
            vim.cmd("normal! O")
            vim.api.nvim_put({"hush"}, "c", false, true)
            vim.cmd("normal! <S-Return>")
            vim.cmd("normal! dd")
          end, vim.tbl_extend("force", opts, { desc = "Hush all patterns" }))
          
          -- Solo pattern
          vim.keymap.set("n", "<leader>ts", function()
            vim.ui.input({ prompt = "Solo pattern (e.g., d1): " }, function(pattern)
              if pattern then
                vim.cmd("normal! O")
                vim.api.nvim_put({"solo " .. pattern}, "c", false, true)
                vim.cmd("normal! <S-Return>")
                vim.cmd("normal! dd")
              end
            end)
          end, vim.tbl_extend("force", opts, { desc = "Solo pattern" }))
          
          -- Mute pattern
          vim.keymap.set("n", "<leader>tm", function()
            vim.ui.input({ prompt = "Mute pattern (e.g., d1): " }, function(pattern)
              if pattern then
                vim.cmd("normal! O")
                vim.api.nvim_put({"mute " .. pattern}, "c", false, true)
                vim.cmd("normal! <S-Return>")
                vim.cmd("normal! dd")
              end
            end)
          end, vim.tbl_extend("force", opts, { desc = "Mute pattern" }))
          
          -- Unmute pattern
          vim.keymap.set("n", "<leader>tu", function()
            vim.ui.input({ prompt = "Unmute pattern (e.g., d1): " }, function(pattern)
              if pattern then
                vim.cmd("normal! O")
                vim.api.nvim_put({"unmute " .. pattern}, "c", false, true)
                vim.cmd("normal! <S-Return>")
                vim.cmd("normal! dd")
              end
            end)
          end, vim.tbl_extend("force", opts, { desc = "Unmute pattern" }))
        end,
      })
    end,
  },
  
  -- Ensure TreeSitter parsers are installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "haskell", "supercollider" })
    end,
  },
  
  -- Optional: vim-tidal for additional functionality
  {
    "tidalcycles/vim-tidal",
    enabled = false, -- Enable if you want legacy vim-tidal features
    ft = "tidal",
  },
}