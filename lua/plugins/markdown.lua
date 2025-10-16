return {
  "tadmccorkle/markdown.nvim",
  ft = "markdown", -- or 'event = "VeryLazy"'
  opts = {
    -- Better checkbox rendering
    checkboxes = {
      -- Enable checkbox features
      enabled = true,
      -- Replace default markdown checkbox symbols
      symbols = {
        -- Checkbox states and corresponding symbols (including unicode)
        pending = "[ ]",  -- Unchecked
        complete = "[x]", -- Checked
      },
      -- Highlight groups for checkbox states
      hl_groups = {
        -- Set custom highlight groups for checkboxes
        pending = nil,    -- Use default or set a custom one like "MarkdownCheckboxPending"
        complete = nil,   -- Use default or set a custom one like "MarkdownCheckboxComplete"
      },
    },
    -- Conceal settings
    conceal = {
      -- Disable conceal to keep code blocks visible
      enabled = false,
      -- Control concealing of individual elements
      checkboxes = false, -- Don't conceal checkbox markers
      -- You can add other conceal settings as needed
    },
  },
  -- Set up event to apply markdown settings when entering markdown files
  config = function(_, opts)
    require("markdown").setup(opts)
    
    -- Set up an autocmd to ensure proper conceallevel for markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- Set conceallevel to 0 to prevent code blocks from being concealed
        vim.opt_local.conceallevel = 0
        vim.opt_local.concealcursor = ""
        
        -- Force reload syntax to apply our custom checkbox syntax
        vim.cmd("syntax enable")
      end,
    })
  end,
}
