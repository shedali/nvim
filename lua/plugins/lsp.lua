return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          on_attach = function(client, bufnr)
            -- Check if we're in the knowledge repo
            local file_path = vim.api.nvim_buf_get_name(bufnr)
            if file_path:match("/Users/franz/dev/shedali/knowledge") then
              -- Set lax link resolution for knowledge repo
              client.config.init_options = {
                link_resolution = "lax",
              }
            else
              -- Use strict for other repos
              client.config.init_options = {
                link_resolution = "strict",
              }
            end
          end,
          settings = {
            marksman = {
              -- Additional settings can be added here
            }
          }
        },
      },
    },
  },
}