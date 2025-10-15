-- bootstrap lazy.nvim, LazyVim and your plugins
vim.opt.wrap = true
vim.opt.linebreak = true

-- Silence noisy plugin messages in headless mode
require("config.silence")

require("config.lazy")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" }, -- Add more file types if needed
  command = "EslintFixAll",
})
