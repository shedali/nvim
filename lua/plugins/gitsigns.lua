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
        vim.cmd("tabnew")
        vim.fn.termopen("GIT_EXTERNAL_DIFF=difft git diff main...HEAD", {
          on_exit = function()
            vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = true, silent = true })
          end,
        })
        vim.cmd("startinsert")
      end,
      desc = "Difftastic diff against main",
    },
  },
}
