-- Adding yazi keybindings to Neovim without a plugin
-- This file is loaded directly by Neovim's init process

-- Define the path to yazi binary
local yazi_bin = "/Users/franz/.nix-profile/bin/yazi"

-- Create keybindings for yazi operations
-- Use <leader>j prefix for yazi commands

-- Open yazi at current file's directory
vim.keymap.set("n", "<leader>jf", function()
  local current_file = vim.fn.expand("%:p")
  local parent_dir = vim.fn.fnamemodify(current_file, ":h")
  -- Use a new buffer for the terminal to avoid interference from other plugins
  vim.cmd("enew")
  vim.cmd("terminal " .. yazi_bin .. " " .. vim.fn.shellescape(parent_dir))
  vim.cmd("startinsert")
end, { desc = "Yazi: Open file directory", silent = true })

-- Open yazi at current working directory
vim.keymap.set("n", "<leader>jc", function()
  local cwd = vim.fn.getcwd()
  -- Use a new buffer for the terminal to avoid interference from other plugins
  vim.cmd("enew")
  vim.cmd("terminal " .. yazi_bin .. " " .. vim.fn.shellescape(cwd))
  vim.cmd("startinsert")
end, { desc = "Yazi: Open current directory", silent = true })

-- Open yazi directly
vim.keymap.set("n", "<leader>jd", function()
  -- Use a new buffer for the terminal to avoid interference from other plugins
  vim.cmd("enew")
  vim.cmd("terminal " .. yazi_bin)
  vim.cmd("startinsert")
end, { desc = "Yazi: Open directly", silent = true })

-- Add mappings for moving files with existing command
vim.keymap.set("n", "<leader>jm", ":MoveCurrentFileYazi<CR>", { desc = "Yazi: Move current file", silent = true })
vim.keymap.set("n", "<leader>jy", ":MoveCurrentFileYazi<CR>", { desc = "Yazi: Move current file (alt)", silent = true })

-- Return an empty table as this is not a plugin
return {}
