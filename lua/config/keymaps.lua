--vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
-- oerride the lazy.nvim leader key to be ; instead of space
vim.g.lazy_leader = ";"
vim.g.lazy_localleader = ";"

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', '<leader>r', ':Neotree filesystem reveal left<CR><CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })

-- timestamps in insert mode
vim.keymap.set("i", "<C-d>", "<C-R>=strftime('%Y-%m-%d %H:%M')<CR>", { noremap = true, silent = true })

-- obsidian
vim.api.nvim_set_keymap("n", "<leader>o<", ":ObsidianYesterday<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o#", ":ObsidianTags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ol", ":ObsidianLink<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ob", ":ObsidianBacklinks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>or", ":ObsidianRename<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o>", ":ObsidianTomorrow<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ox", ":ObsidianToggleCheckbox<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ofv", ":ObsidianFollowLink vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ofh", ":ObsidianFollowLink hsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oe", ":ObsidianExtractNote<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ow", ":ObsidianWorkspace<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>od", ":ObsidianDailies<CR>", { noremap = true, silent = true })
-- ObsidianSearch
-- ObsidianQuickSwitch
vim.api.nvim_set_keymap("n", "<leader>oO", ":ObsidianQuickSwitch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oo", ":ObsidianSearch<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", { noremap = true, silent = true })

local builtin = require("telescope.builtin") -- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#vim-pickers
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope find references" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, { desc = "Telescope find document symbols" })
vim.keymap.set("n", "<leader>fs", function()
  builtin.treesitter()
end, { desc = "Find symbols with Treesitter" })

vim.keymap.set("n", "gd", function()
  builtin.lsp_definitions()
end, { desc = "Go to definition" })

vim.keymap.set("n", "gi", function()
  builtin.lsp_implementations()
end, { desc = "Go to implementation" })

vim.keymap.set("n", "gy", function()
  builtin.lsp_type_definitions()
end, { desc = "Go to type definition" })
--
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

-- vim.keymap.set("n", "<leader>tt", ":lua require('toggle-checkbox').toggle()<CR>")

vim.api.nvim_set_keymap(
  "n",
  "<leader>twr",
  "<cmd>lua require('neotest').run.run({ vitestCommand = 'pnpm vitest --watch' })<cr>",
  { desc = "Run Watch" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>twf",
  "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'vitest --watch' })<cr>",
  { desc = "Run Watch File" }
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

vim.keymap.set("n", "<leader>dn", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Jump to next issue in Trouble" })

vim.keymap.set("n", "<leader>dp", function()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "Jump to previous issue in Trouble" })

vim.keymap.set("n", "<leader>dw", function()
  require("trouble").next({ skip_groups = false, jump = true })
end, { desc = "Jump to next workspace issue" })

-- GIT

vim.keymap.set("n", "<leader>gO", require("neogit").open, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gB", ":Telescope git_branches<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gb", ":Neogit blame<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })

vim.keymap.set("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true, noremap = true })
vim.keymap.set("v", "<leader>gu", ":Gitsigns unstage_hunk<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gv", ":Gitsigns preview_hunk<CR>", { silent = true, noremap = true })
--
--- https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#commands
--
--- Octo.nvim
vim.api.nvim_set_keymap("n", "<leader>pl", ":Octo pr list<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pr", ":Octo pr ready<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pC", ":Octo pr checkout<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pc", ":Octo pr commits<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pu", ":Octo pr url<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pd", ":Octo pr diff<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pf", ":Octo pr diff<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pD", ":Octo pr draft<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pb", ":Octo pr browser<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>ca", ":Octo comment add<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>cd", ":Octo comment delete<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>tr", ":Octo thread resolve<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>tu", ":Octo thread unresolve<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>rs", ":Octo review start<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>rS", ":Octo review submit<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>rr", ":Octo review resume<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>rc", ":Octo review comments<CR>", {
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>rV", ":Octo mark-unviewed<CR>", {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap("n", "<leader>pp", ":Octo actions<CR>", {
  noremap = true,
  silent = true,
})

vim.keymap.set("i", "@", "@<C-x><C-o>", {
  silent = true,
  buffer = true,
})
vim.keymap.set("i", "#", "#<C-x><C-o>", {
  silent = true,
  buffer = true,
})

vim.keymap.set("n", "<leader>rv", function()
  require("octo").toggle_viewed()
end)
