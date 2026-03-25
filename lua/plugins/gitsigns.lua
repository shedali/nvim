return {
  "lewis6991/gitsigns.nvim",
  keys = {
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
