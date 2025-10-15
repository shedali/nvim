local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Pin LazyVim to v14.x for stability (works with Neovim 0.10+)
    { "LazyVim/LazyVim", version = "14.x", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = {
    -- Lazy-load all plugins by default for faster startup
    lazy = true,
    -- Use lazy-lock.json to pin versions (committed to git for reproducibility)
    version = false, -- don't auto-update to latest versions
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = false, -- disable auto-checking for updates (less noise)
    notify = false, -- no update notifications
  }, -- manually update with :Lazy sync when you want to
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
