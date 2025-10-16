-- bootstrap lazy.nvim, LazyVim and your plugins
vim.opt.wrap = true
vim.opt.linebreak = true

-- Silence noisy plugin messages in headless mode
require("config.silence")

-- MCP Hub CLI path configuration
vim.g.mcp_cli = "mcp-hub"

require("config.lazy")

-- Enhanced formatting on save for multiple languages
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.lua", "*.py", "*.json", "*.md", "*.yaml", "*.yml" },
  callback = function()
    local filetype = vim.bo.filetype
    
    -- JavaScript/TypeScript files use ESLint
    if filetype == "javascript" or filetype == "typescript" or 
       filetype == "javascriptreact" or filetype == "typescriptreact" then
      vim.cmd("EslintFixAll")
    else
      -- Other filetypes use LSP formatting if available
      local client = vim.lsp.get_active_clients({ bufnr = 0 })
      for _, c in ipairs(client) do
        if c.supports_method("textDocument/formatting") then
          vim.lsp.buf.format({ async = false })
          break
        end
      end
    end
  end,
})

vim.env.OPENAI_API_KEY = os.getenv("ANTHROPIC_API_KEY")

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.cmd("ZenMode")
--   end,
-- })
