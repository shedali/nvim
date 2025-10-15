return {
  lazy = false,
  log_level = vim.log.levels.DEBUG,
  "nvim-neotest/neotest",
  enabled = true,
  dependencies = {
    "marilari88/neotest-vitest",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      ["neotest-vitest"] = {
        vitestCommand = "bun test", -- Using Bun instead of pnpm (faster!)
        cwd = vim.fn.getcwd(), -- Ensures it runs in the project root,
        testPattern = { "*.spec.tsx", "./**/*.spec.tsx", "**/*.spec.tsx" },
        filter_dir = function(name, rel_path, root)
          return name ~= "node_modules"
        end,
      },
    },
  },
}
