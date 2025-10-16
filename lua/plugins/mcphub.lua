return {
  "ravitemer/mcphub.nvim",
  enabled = false, -- Disabled until mcp-hub can be installed properly
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "/Users/franz/.nix-profile/bin/npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  config = function()
    require("mcphub").setup({
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
    })
  end,
}

