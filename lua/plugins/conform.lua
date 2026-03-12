return {
  "stevearc/conform.nvim",
  opts = {
    -- Use a fast timeout so :wq doesn't hang; falls back to LSP if formatter unavailable
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      javascript = { "eslint_d", stop_after_first = true },
      typescript = { "eslint_d", stop_after_first = true },
      javascriptreact = { "eslint_d", stop_after_first = true },
      typescriptreact = { "eslint_d", stop_after_first = true },
      lua = { lsp_format = "prefer" },
      python = { "ruff_format", lsp_format = "fallback" },
      json = { "prettierd", lsp_format = "fallback" },
      yaml = { "prettierd", lsp_format = "fallback" },
      markdown = { lsp_format = "prefer" },
    },
  },
}
