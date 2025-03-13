-- oerride the lazy.nvim leader key to be ; instead of space
vim.g.lazy_leader = ";"
vim.g.lazy_localleader = ";"

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', '<leader>r', ':Neotree filesystem reveal left<CR><CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })

-- obsidian
vim.api.nvim_set_keymap("n", "<leader>o<", ":ObsidianYesterday<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o#", ":ObsidianTags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ol", ":ObsidianLink<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ob", ":ObsidianBacklinks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>or", ":ObsidianRename<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oe", ":ObsidianExtractNote<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o>", ":ObsidianTomorrow<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ox", ":ObsidianToggleCheckbox<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ofv", ":ObsidianFollowLink vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ofh", ":ObsidianFollowLink hsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oe", ":ObsidianExtractNote<CR>", { noremap = true, silent = true })

-- ObsidianSearch
-- ObsidianQuickSwitch
vim.api.nvim_set_keymap("n", "<leader>oO", ":ObsidianOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oo", ":ObsidianSearch<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", { noremap = true, silent = true })
--This mapping sets up fc (find

-- Telescope
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
--
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<space>fz", ":Telescope zoxide<CR>")

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- Alternatively, using lua API
-- vim.keymap.set("n", "<space>fb", function()
-- 	require("telescope").extensions.file_browser.file_browser()
-- end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>tt", ":lua require('toggle-checkbox').toggle()<CR>")

vim.api.nvim_set_keymap(
  "n",
  "<leader>twr",
  "<cmd>lua require('neotest').run.run({ vitestCommand = 'pnpm vitest --watch' })<cr>",
  { desc = "Run Watch" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tr",
  "<cmd>lua require('neotest').run.run({ vitestCommand = 'pnpm vitest run' })<cr>",
  { desc = "Run test" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ts",
  "<cmd>lua require('neotest').summary.toggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle Neotest Summary" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>to",
  "<cmd>lua require('neotest').output_panel.toggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle Neotest Output" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>td",
  "<cmd>lua require('neotest').diagnostic.config()<CR>",
  { noremap = true, silent = true, desc = "Toggle Neotest Output" }
)
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- GIT

--vim.keymap.set("n", "<leader>gs", require("neogit").open, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gB", ":Telescope git_branches<CR>", { silent = true, noremap = true })
--vim.keymap.set("n", "<leader>gb", ":Neogit blame<CR>", { silent = true, noremap = true })
--vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
--vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
--ivim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })
