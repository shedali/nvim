return {
  "lewis6991/gitsigns.nvim",
  keys = {
    {
      "<leader>gm",
      function()
        require("gitsigns").change_base("main", true)
      end,
      desc = "Gitsigns diff against main",
    },
    {
      "<leader>gM",
      function()
        require("gitsigns").reset_base(true)
      end,
      desc = "Gitsigns reset to index",
    },
    {
      "<leader>gD",
      function()
        local buf = vim.api.nvim_create_buf(false, true)
        local lines = vim.fn.systemlist("GIT_EXTERNAL_DIFF=difft git diff main...HEAD")
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_set_option_value("filetype", "diff", { buf = buf })
        vim.cmd("tabnew")
        vim.api.nvim_win_set_buf(0, buf)
      end,
      desc = "Difftastic diff against main",
    },
  },
}
