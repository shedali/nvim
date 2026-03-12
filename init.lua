-- bootstrap lazy.nvim, LazyVim and your plugins
vim.opt.wrap = true
vim.opt.linebreak = true

-- Silence noisy plugin messages in headless mode
require("config.silence")

-- MCP Hub CLI path configuration
vim.g.mcp_cli = "mcp-hub"

require("config.lazy")


vim.env.OPENAI_API_KEY = os.getenv("ANTHROPIC_API_KEY")

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.cmd("ZenMode")
--   end,
-- })
