return {
  -- Go language support with gopls and tools
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Disable auto-format on save (we'll use conform.nvim for this)
        goimports = "gopls",
        gofmt = "gopls",
        tag_transform = false,
        test_template = "",
        test_template_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = false, -- Don't override LSP config, let LazyVim handle it
        lsp_gofumpt = true,
        lsp_on_attach = false, -- Let LazyVim handle LSP attach
        dap_debug = true,
        dap_debug_gui = true,
        dap_debug_keymap = false, -- We'll set custom keymaps
        trouble = true,
        luasnip = true,
      })

      -- Auto-organize imports on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoImports", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- Additional Go tools and commands
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    opts = {},
  },

  -- LSP configuration for Go
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
  },

  -- Treesitter configuration for Go
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gosum" })
      end
    end,
  },

  -- DAP configuration for Go debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup({
            dap_configurations = {
              {
                type = "go",
                name = "Attach remote",
                mode = "remote",
                request = "attach",
              },
            },
            delve = {
              path = "dlv",
              initialize_timeout_sec = 20,
              port = "${port}",
              args = {},
              build_flags = "",
            },
          })
        end,
      },
    },
  },

  -- Neotest configuration for Go
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-go"] = {
        experimental = {
          test_table = true,
        },
        args = { "-count=1", "-timeout=60s" },
      }
    end,
  },

  -- Formatting and linting with conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },

  -- Linting with nvim-lint (disabled - golangci-lint not installed)
  -- Uncomment and install golangci-lint if you want linting
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       go = { "golangcilint" },
  --     },
  --   },
  -- },

  -- Go-specific keybindings
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { ";g", group = "go", mode = { "n", "v" } },
      },
    },
  },
}