return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Ensure the HTTP treesitter parser is available (avoids luarocks tree-sitter-http build failure on Nix)
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "http" })
        end,
      },
    },
    config = function()
      vim.g.rest_nvim = {
        request = {
          hooks = {
            encode_url = true,
            set_content_type = true,
          },
        },
        response = {
          hooks = {
            format = true,
          },
        },
        env = {
          enable = true,
          -- match http-client.env.json (JetBrains format) as well as .env.*
          pattern = "http%-client%.env%.json$",
        },
      }

      -- Keymaps: only active in .http files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function()
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = true, silent = true, desc = desc })
          end
          map("<leader>rr", "<cmd>Rest run<cr>",         "Run request under cursor")
          map("<leader>rl", "<cmd>Rest last<cr>",        "Re-run last request")
          map("<leader>ro", "<cmd>Rest open<cr>",        "Open result pane")
          map("<leader>re", "<cmd>Rest env select<cr>",  "Select env file")
        end,
      })
    end,
  },
}
