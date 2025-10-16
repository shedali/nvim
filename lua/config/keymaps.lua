--vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
-- oerride the lazy.nvim leader key to be ; instead of space
vim.g.lazy_leader = ";"
vim.g.lazy_localleader = ";"

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', '<leader>r', ':Neotree filesystem reveal left<CR><CR>', { noremap = true, silent = true })

-- timestamps in insert mode
vim.keymap.set("i", "<C-d>", "<C-R>=strftime('%Y-%m-%d %H:%M')<CR>", { noremap = true, silent = true })

-- obsidian
vim.api.nvim_set_keymap("n", "<leader>o<", ":ObsidianYesterday<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o#", ":ObsidianTags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ol", ":ObsidianLink<CR>", { noremap = true, silent = true, desc = "Create wiki link" })
vim.api.nvim_set_keymap("v", "<leader>ol", ":ObsidianLink<CR>", { noremap = true, silent = true, desc = "Surround with wiki link" })
vim.api.nvim_set_keymap("v", "<leader>wl", ":ObsidianLink<CR>", { noremap = true, silent = true, desc = "Wiki link selection" })
vim.api.nvim_set_keymap("n", "<leader>ob", ":ObsidianBacklinks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>or", ":ObsidianRename<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o>", ":ObsidianTomorrow<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ox", ":ObsidianToggleCheckbox<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ofv", ":ObsidianFollowLink vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ofh", ":ObsidianFollowLink hsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oe", ":ObsidianExtractNote<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>oc", ":ObsidianLinkNew<CR>", { noremap = true, silent = true, desc = "Create new note from selection" })

vim.api.nvim_set_keymap("n", "<leader>ow", ":ObsidianWorkspace<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>od", ":ObsidianDailies<CR>", { noremap = true, silent = true })
-- ObsidianSearch
-- ObsidianQuickSwitch
vim.api.nvim_set_keymap("n", "<leader>o<leader>", ":ObsidianQuickSwitch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oO", ":ObsidianOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oo", ":ObsidianSearch<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", { noremap = true, silent = true })

local builtin = require("telescope.builtin") -- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#vim-pickers
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope find references" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, { desc = "Telescope find document symbols" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Recent Files" })

vim.keymap.set("n", "<leader><leader>", function()
  builtin.find_files({
    hidden = true,
    no_ignore = false, -- keep ignoring files in .gitignore
    file_ignore_patterns = { "%.git/" }, -- explicitly ignore .git folder
  })
end)

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

-- Enhanced todo navigation
vim.api.nvim_create_user_command("NextTodo", function()
  -- Save current position
  local save_cursor = vim.fn.getcurpos()
  
  -- Try to find TODO: first in the current buffer
  vim.cmd[[/\(TODO:\|test\.todo\|it\.todo\)]]
  
  -- If not found, go back to original position
  if vim.fn.getcurpos()[2] == save_cursor[2] and vim.fn.getcurpos()[3] == save_cursor[3] then
    vim.fn.setpos('.', save_cursor)
    vim.notify("No more TODOs found", vim.log.levels.INFO)
  end
end, {})

vim.api.nvim_create_user_command("PrevTodo", function()
  -- Save current position
  local save_cursor = vim.fn.getcurpos()
  
  -- Try to find TODO: backward in the current buffer
  vim.cmd[[?\(TODO:\|test\.todo\|it\.todo\)]]
  
  -- If not found, go back to original position
  if vim.fn.getcurpos()[2] == save_cursor[2] and vim.fn.getcurpos()[3] == save_cursor[3] then
    vim.fn.setpos('.', save_cursor)
    vim.notify("No previous TODOs found", vim.log.levels.INFO)
  end
end, {})

-- Checkbox navigation commands
-- Create a Lua function that does the searching (more robust than Vim commands)
local function find_checkbox(open, forward)
  -- Save current cursor position
  local cursor_line = vim.fn.line('.')
  local cursor_col = vim.fn.col('.')
  
  -- Get all lines in the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  
  -- Define the pattern to search for
  local pattern
  if open then
    pattern = "- %[ %]"  -- Open checkbox pattern
  else
    pattern = "- %[[xX]%]"  -- Closed checkbox pattern
  end
  
  -- Variables to track the best match
  local target_line = nil
  local target_col = nil
  local distance = math.huge
  
  -- Search through all lines
  for i, line in ipairs(lines) do
    local start_idx = 1
    
    -- Find all matches in this line
    while true do
      local match_start, match_end = line:find(pattern, start_idx)
      if not match_start then break end
      
      -- Calculate position relative to current cursor
      local match_line = i
      local match_col = match_start
      
      if forward then
        -- Looking forward: match must be after cursor
        if match_line > cursor_line or (match_line == cursor_line and match_col > cursor_col) then
          local curr_distance = (match_line - cursor_line) * 1000 + (match_col - cursor_col)
          if curr_distance < distance then
            distance = curr_distance
            target_line = match_line
            target_col = match_col
          end
        end
      else
        -- Looking backward: match must be before cursor
        if match_line < cursor_line or (match_line == cursor_line and match_col < cursor_col) then
          local curr_distance = (cursor_line - match_line) * 1000 + (cursor_col - match_col)
          if curr_distance < distance then
            distance = curr_distance
            target_line = match_line
            target_col = match_col
          end
        end
      end
      
      -- Move to next potential match in this line
      start_idx = match_end + 1
    end
  end
  
  -- If we found a match, go to it
  if target_line then
    vim.api.nvim_win_set_cursor(0, {target_line, target_col - 1})
    return true
  else
    local status = open and "open" or "completed"
    local direction = forward and "next" or "previous"
    vim.notify("No " .. direction .. " " .. status .. " checkbox found", vim.log.levels.INFO)
    return false
  end
end

-- Commands for checkbox navigation
vim.api.nvim_create_user_command("NextOpenCheckbox", function()
  find_checkbox(true, true)
end, {})

vim.api.nvim_create_user_command("PrevOpenCheckbox", function()
  find_checkbox(true, false)
end, {})

vim.api.nvim_create_user_command("NextClosedCheckbox", function()
  find_checkbox(false, true)
end, {})

vim.api.nvim_create_user_command("PrevClosedCheckbox", function()
  find_checkbox(false, false)
end, {})

-- Add a function to insert a TODO comment at the current cursor position
vim.api.nvim_create_user_command("InsertTodo", function()
  -- Get the current indentation level
  local line = vim.api.nvim_get_current_line()
  local indent = line:match("^%s*")
  
  -- Get the filetype to determine comment style
  local filetype = vim.bo.filetype
  local todo_text = ""
  
  -- Determine the appropriate comment style based on filetype
  if filetype == "lua" then
    todo_text = indent .. "-- TODO: "
  elseif filetype == "vim" or filetype == "vimscript" then
    todo_text = indent .. "\" TODO: "
  elseif filetype == "markdown" or filetype == "text" then
    todo_text = indent .. "TODO: "
  elseif filetype == "python" then
    todo_text = indent .. "# TODO: "
  elseif filetype == "javascript" or filetype == "typescript" or 
         filetype == "javascriptreact" or filetype == "typescriptreact" or
         filetype == "java" or filetype == "c" or filetype == "cpp" or
         filetype == "rust" or filetype == "go" or filetype == "php" or
         filetype == "swift" or filetype == "kotlin" or filetype == "scala" then
    todo_text = indent .. "// TODO: "
  elseif filetype == "html" or filetype == "xml" then
    todo_text = indent .. "<!-- TODO: -->"
  elseif filetype == "css" or filetype == "scss" or filetype == "less" then
    todo_text = indent .. "/* TODO: */"
  else
    -- Default to a generic comment format
    todo_text = indent .. "# TODO: "
  end
  
  -- Insert the TODO comment and enter insert mode
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  
  -- Create a new line after the current one
  if vim.fn.col("$") == 1 then
    -- If line is empty, just set the content
    vim.api.nvim_set_current_line(todo_text)
    local new_pos = {row, #todo_text}
    vim.api.nvim_win_set_cursor(0, new_pos)
  else
    -- Insert a new line after current line
    vim.api.nvim_buf_set_lines(0, row, row, false, {todo_text})
    vim.api.nvim_win_set_cursor(0, {row + 1, #todo_text})
  end
  
  -- Enter insert mode at the end of the TODO comment
  vim.cmd("startinsert!")
end, {})

-- Function to create a new TODO note in Obsidian
vim.api.nvim_create_user_command("CreateTodoNote", function()
  -- Create a timestamp for unique note naming
  local timestamp = os.date("%Y%m%d%H%M%S")
  local default_title = "TODO-" .. timestamp
  
  -- Prompt the user for a title
  vim.ui.input({ prompt = "TODO Title: ", default = default_title }, function(title)
    if not title or title == "" then return end
    
    -- Check if Obsidian client is available
    local ok, obsidian = pcall(require, "obsidian")
    if not ok then
      vim.notify("Obsidian plugin not found", vim.log.levels.ERROR)
      return
    end
    
    local client = obsidian.get_client()
    if not client then
      vim.notify("Obsidian client not initialized", vim.log.levels.ERROR)
      return
    end
    
    -- Prepare the template for new TODO note
    local template = [[---
aliases: []] .. title .. [[], todo]] .. timestamp .. [[]
tags: [todo]
---

# ]] .. title .. [[

## Description

<!-- What needs to be done? -->

## Tasks

- [ ] 

## Notes

<!-- Additional context, ideas, references -->

]]
    
    -- Create the new note
    -- First try to use the built-in command if available
    vim.cmd("ObsidianNew " .. title)
    
    -- Replace content with our template (delay slightly to ensure the buffer is created)
    vim.defer_fn(function()
      local buf = vim.api.nvim_get_current_buf()
      local lines = vim.split(template, "\n")
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      
      -- Position cursor at the task list to start adding tasks
      local task_line = 0
      for i, line in ipairs(lines) do
        if line:match("^- %[ %]") then
          task_line = i - 1
          break
        end
      end
      
      if task_line > 0 then
        vim.api.nvim_win_set_cursor(0, {task_line + 1, 6})
        vim.cmd("startinsert")
      end
      
      vim.notify("Created new TODO note: " .. title, vim.log.levels.INFO)
    end, 100)
  end)
end, {})

-- Aerial keybindings
vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial Outline" })
vim.keymap.set("n", "<leader>an", "<cmd>AerialNavToggle<CR>", { desc = "Toggle Aerial Navigator" })
vim.keymap.set("n", "[s", "<cmd>AerialPrev<CR>", { desc = "Previous Symbol" })
vim.keymap.set("n", "]s", "<cmd>AerialNext<CR>", { desc = "Next Symbol" })

-- Keybindings for todo navigation and insertion
vim.keymap.set("n", "]T", ":NextTodo<CR>", { desc = "Next TODO or todo test", silent = true })
vim.keymap.set("n", "[T", ":PrevTodo<CR>", { desc = "Previous TODO or todo test", silent = true })
vim.keymap.set("n", "<leader>tt", ":InsertTodo<CR>", { desc = "Insert TODO comment", silent = true })
vim.keymap.set("n", "<leader>tn", ":CreateTodoNote<CR>", { desc = "Create TODO note in Obsidian", silent = true })

-- Keybindings for checkbox navigation - using ']b' and '[b' to avoid conflicts
vim.keymap.set("n", "]b", ":NextOpenCheckbox<CR>", { desc = "Next open checkbox", silent = true })
vim.keymap.set("n", "[b", ":PrevOpenCheckbox<CR>", { desc = "Previous open checkbox", silent = true })
vim.keymap.set("n", "]X", ":NextClosedCheckbox<CR>", { desc = "Next completed checkbox", silent = true })
vim.keymap.set("n", "[X", ":PrevClosedCheckbox<CR>", { desc = "Previous completed checkbox", silent = true })

-- Additional checkbox mappings (]c/[c for compatibility, ]x/[x reserved for Trouble diagnostics)
vim.keymap.set("n", "]c", ":NextOpenCheckbox<CR>", { desc = "Next open checkbox", silent = true })
vim.keymap.set("n", "[c", ":PrevOpenCheckbox<CR>", { desc = "Previous open checkbox", silent = true })

-- List all TODOs in project - uses live_grep_args extension
vim.api.nvim_create_user_command("ListAllTodos", function()
  -- Use the live_grep_args extension that's already configured
  require('telescope').extensions.live_grep_args.live_grep_args({
    prompt_title = "All TODOs in Project",
    default_text = "TODO:|test\\.todo\\(|it\\.todo\\(",
  })
end, {})

-- Bind the command to a key
vim.keymap.set("n", "<leader>tl", ":ListAllTodos<CR>", { desc = "List all TODOs in project", silent = true })
--
vim.keymap.set("n", "<space>fz", ":Telescope zoxide<CR>")

-- open file_browser with the path of the current buffer
--vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- Alternatively, using lua API
-- vim.keymap.set("n", "<space>fb", function()
-- 	require("telescope").extensions.file_browser.file_browser()
-- end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- vim.keymap.set("n", "<leader>tt", ":lua require('toggle-checkbox').toggle()<CR>")

local map = vim.keymap.set
-- Move lines
map("n", "<M-j>", function()
  require("mini.move").move_line("down")
end, { desc = "Move line down" })
map("n", "<M-k>", function()
  require("mini.move").move_line("up")
end, { desc = "Move line up" })
map("v", "<M-j>", function()
  require("mini.move").move_selection("down")
end, { desc = "Move selection down" })
map("v", "<M-k>", function()
  require("mini.move").move_selection("up")
end, { desc = "Move selection up" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>twr",
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), vitestCommand='pnpm vitest --watch'})<cr>",
  { desc = "Run Watch All" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>twf",
  "<cmd>lua require('neotest').run.run({ args = { 'pnpm', 'vitest', '--watch', vim.fn.expand('%') },cwd = vim.fn.getcwd()})<cr>",
  { desc = "Run Watch File" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>trt",
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
  "<leader>td",
  "<cmd>lua require('neotest').diagnostic.config()<CR>",
  { noremap = true, silent = true, desc = "Toggle Neotest Output" }
)
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>dn", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Jump to next issue in Trouble" })

vim.keymap.set("n", "<leader>dp", function()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "Jump to previous issue in Trouble" })

vim.keymap.set("n", "<leader>dw", function()
  require("trouble").next({ skip_groups = false, jump = true })
end, { desc = "Jump to next workspace issue" })

vim.keymap.set("n", "]x", function()
  require("trouble").next({ mode = "diagnostics", skip_groups = true, jump = true })
end)

vim.keymap.set("n", "[x", function()
  require("trouble").prev({ mode = "diagnostics", skip_groups = true, jump = true })
end)
-- GIT

-- Neogit keymappings are defined in neogit.lua

vim.keymap.set("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true, noremap = true, desc = "Stage selected hunk" })
vim.keymap.set("v", "<leader>gu", ":Gitsigns unstage_hunk<CR>", { silent = true, noremap = true, desc = "Unstage selected hunk" })
vim.keymap.set("v", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, noremap = true, desc = "Reset selected hunk" })
vim.keymap.set("n", "<leader>gv", ":Gitsigns preview_hunk<CR>", { silent = true, noremap = true, desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, noremap = true, desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gV", ":Gitsigns select_hunk<CR>", { silent = true, noremap = true, desc = "Select hunk" })
vim.keymap.set("n", "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, noremap = true, desc = "Select inner hunk" })
vim.keymap.set("o", "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, noremap = true, desc = "Select inner hunk" })
vim.keymap.set("x", "ih", ":<C-U>Gitsigns select_hunk<CR>", { silent = true, noremap = true, desc = "Select inner hunk" })
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
vim.api.nvim_set_keymap("n", "<leader>pf", ":Octo pr files<CR>", {
  noremap = true,
  silent = true,
  desc = "List PR files",
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
  desc = "Add comment to PR"
})
vim.api.nvim_set_keymap("n", "<leader>cd", ":Octo comment delete<CR>", {
  noremap = true,
  silent = true,
  desc = "Delete comment"
})
vim.api.nvim_set_keymap("n", "<leader>ptr", ":Octo thread resolve<CR>", {
  noremap = true,
  silent = true,
  desc = "Resolve PR thread"
})
vim.api.nvim_set_keymap("n", "<leader>ptu", ":Octo thread unresolve<CR>", {
  noremap = true,
  silent = true,
  desc = "Unresolve PR thread"
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

-- Define Obsidian note movement function separately to avoid nesting
local function move_obsidian_note()
  local scan = require("plenary.scandir")
  local obsidian = require("obsidian")
  local client = obsidian.get_client()
  
  local cwd = tostring(client.dir or client.opts.dir)
  local ok, dirs = pcall(scan.scan_dir, cwd, { only_dirs = true, depth = 3 })
  
  if not ok then
    vim.notify("Failed to scan directories", vim.log.levels.ERROR)
    return
  end
  
  if #dirs == 0 then
    vim.notify("No directories found in: " .. cwd, vim.log.levels.WARN)
    return
  end
  
  vim.ui.select(dirs, { prompt = "Move note to:" }, function(choice)
    if not choice then
      return
    end
    
    local filename = vim.fn.expand("%:t")
    local basename = filename:gsub("%.md$", "")
    local ext = ".md"
    
    local current_path = vim.fn.expand("%:p")
    local temp_name = basename .. "_moving" .. ext
    local temp_path = vim.fn.fnamemodify(choice, ":p") .. "/" .. temp_name
    local final_path = vim.fn.fnamemodify(choice, ":p") .. "/" .. filename
    
    if current_path == final_path then
      vim.notify("Note is already in that location", vim.log.levels.INFO)
      return
    end
    
    -- Step 1: Rename to temp to force move
    vim.cmd("ObsidianRename " .. temp_path)
    
    -- Step 2: Rename to original name in new location
    vim.cmd("ObsidianRename " .. final_path)
    
    vim.notify("Note moved to " .. final_path, vim.log.levels.INFO)
  end)
end

-- Assign the function to the keybinding
vim.keymap.set("n", "<leader>om", move_obsidian_note, { desc = "Move Obsidian note (preserving metadata)" })

-- PERSISTENCE
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Load session for current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>ql", function()
  require("persistence").select()
end, { desc = "Select session to load" })

-- load the last session
vim.keymap.set("n", "<leader>qL", function()
  require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- save session manually
vim.keymap.set("n", "<leader>qS", function()
  require("persistence").save()
end, { desc = "Save session for current directory" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Don't save session on exit" })

-- Fix for Ctrl+i forward jump with more intuitive custom mappings
-- Map Alt+o to act as Ctrl+i for forward jump (matching Ctrl+o for backward jump)
vim.keymap.set("n", "<M-o>", "<C-i>", { noremap = true, desc = "Jump forward in jumplist" })
-- Keep F9 as an alternative for terminals that might not support Alt key properly
vim.keymap.set("n", "<F9>", "<C-i>", { noremap = true, desc = "Jump forward in jumplist" })

-- Add command to delete current file and send to trash
vim.api.nvim_create_user_command("TrashFile", function()
  local current_file = vim.fn.expand("%:p")
  
  -- Check if the file exists and is not empty
  if current_file == "" then
    vim.notify("No file to delete", vim.log.levels.ERROR)
    return
  end
  
  -- Confirm with the user
  vim.ui.input({
    prompt = "Move \"" .. vim.fn.fnamemodify(current_file, ":t") .. "\" to trash? (y/N): "
  }, function(input)
    if input and (input:lower() == "y" or input:lower() == "yes") then
      -- Close buffer first
      vim.cmd("bdelete")
      
      -- Use macOS 'trash' command if available (brew install trash)
      local has_trash = vim.fn.executable("trash") == 1
      
      if has_trash then
        -- Use 'trash' command
        local result = vim.fn.system("trash " .. vim.fn.shellescape(current_file))
        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to trash file: " .. result, vim.log.levels.ERROR)
        else
          vim.notify("File sent to trash: " .. vim.fn.fnamemodify(current_file, ":t"), vim.log.levels.INFO)
        end
      else
        -- Fallback to macOS native 'move to trash' via osascript
        local cmd = string.format([[osascript -e 'tell application "Finder" to delete POSIX file "%s"']], current_file)
        local result = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to trash file: " .. result, vim.log.levels.ERROR)
        else
          vim.notify("File sent to trash: " .. vim.fn.fnamemodify(current_file, ":t"), vim.log.levels.INFO)
        end
      end
    end
  end)
end, {})

-- Add keybinding for TrashFile command - we use ;D for "Delete" file
vim.keymap.set("n", "<leader>D", ":TrashFile<CR>", { desc = "Move current file to trash", silent = true })

-- Function to remove wiki links from the word under the cursor
vim.api.nvim_create_user_command("RemoveWikiLinks", function()
  -- Get the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]
  
  -- Get the current line
  local line = vim.api.nvim_get_current_line()
  
  -- Find wiki links [[...]] pattern
  local pos = 1
  local start_pos, end_pos
  
  -- Scan the line for all wiki links
  while pos <= #line do
    local link_start = line:find("%[%[", pos)
    if not link_start then break end
    
    local link_end = line:find("%]%]", link_start)
    if not link_end then break end
    
    -- Check if cursor is inside this link
    if link_start <= col + 1 and link_end + 1 >= col + 1 then
      start_pos = link_start
      end_pos = link_end + 1
      break
    end
    
    pos = link_end + 1
  end
  
  if start_pos and end_pos then
    -- We're inside a wiki link
    -- Extract the content (without the brackets)
    local link_text = line:sub(start_pos + 2, end_pos - 2)
    
    -- Handle pipe syntax [[Link|Display Text]]
    local display_text = link_text
    local pipe_pos = link_text:find("|")
    if pipe_pos then
      display_text = link_text:sub(pipe_pos + 1)
    end
    
    -- Replace the wiki link with just the display text
    local new_line = line:sub(1, start_pos - 1) .. display_text .. line:sub(end_pos + 1)
    vim.api.nvim_set_current_line(new_line)
    
    -- Adjust cursor position if needed
    local new_col
    if col >= end_pos then
      -- Cursor was after the link, adjust for the change in length
      new_col = col - (end_pos - start_pos + 1) + #display_text
    elseif col < start_pos then
      -- Cursor was before the link, keep it where it was
      new_col = col
    else
      -- Cursor was inside the link, place at the beginning of the replaced text
      new_col = start_pos - 1
    end
    
    vim.api.nvim_win_set_cursor(0, {row, math.max(0, new_col)})
    vim.notify("Wiki link removed", vim.log.levels.INFO)
  else
    vim.notify("No wiki link found under cursor", vim.log.levels.WARN)
  end
end, {})

-- Keybinding to remove wiki links
vim.keymap.set("n", "<leader>wd", ":RemoveWikiLinks<CR>", { desc = "Remove wiki links from word", silent = true })

-- Close all buffers command
vim.api.nvim_create_user_command("BufCloseAll", function()
  -- Get all buffer numbers
  local buffers = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  local count = 0
  
  -- Ask for confirmation
  vim.ui.input({
    prompt = "Close all buffers? (y/N): "
  }, function(input)
    if input and (input:lower() == "y" or input:lower() == "yes") then
      -- First, create a new buffer so we don't end up with no buffers
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_set_current_buf(new_buf)
      
      -- Close all other buffers
      for _, buf in ipairs(buffers) do
        -- Ensure the buffer is valid and loaded
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
          -- Skip the newly created buffer
          if buf ~= new_buf then
            -- Try to close the buffer (with ! to avoid "no write since last change" warnings)
            pcall(vim.cmd, "bd! " .. buf)
            count = count + 1
          end
        end
      end
      
      vim.notify("Closed " .. count .. " buffer(s)", vim.log.levels.INFO)
    end
  end)
end, {})

-- Keybinding to close all buffers
vim.keymap.set("n", "<leader>ba", ":BufCloseAll<CR>", { desc = "Close all buffers", silent = true })

-- Move current file to a different directory
vim.api.nvim_create_user_command("MoveCurrentFile", function()
  -- Load our custom file_mover module
  local ok, file_mover = pcall(require, "custom.file_mover")
  if not ok then
    vim.notify("Failed to load file_mover module", vim.log.levels.ERROR)
    return
  end
  
  file_mover.move_file_telescope()
end, {})

-- Alternative command to move using Yazi file manager
vim.api.nvim_create_user_command("MoveCurrentFileYazi", function()
  -- Load our custom file_mover module
  local ok, file_mover = pcall(require, "custom.file_mover")
  if not ok then
    vim.notify("Failed to load file_mover module", vim.log.levels.ERROR)
    return
  end
  
  file_mover.move_file_yazi()
end, {})

-- Keybindings for file moving
vim.keymap.set("n", "<leader>fM", ":MoveCurrentFile<CR>", { desc = "Move current file (Telescope)", silent = true })
vim.keymap.set("n", "<leader>fy", ":MoveCurrentFileYazi<CR>", { desc = "Move current file using Yazi", silent = true })

-- Marks navigation and management
vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Find marks", silent = true, noremap = true })
vim.keymap.set("n", "<leader>ma", ":lua require('marks').toggle_mark()<CR>", { desc = "Add/remove mark", silent = true, noremap = true })
vim.keymap.set("n", "<leader>mc", ":lua require('marks').delete_buf()<CR>", { desc = "Clear marks in buffer", silent = true, noremap = true })
vim.keymap.set("n", "<leader>mj", ":lua require('marks').next()<CR>", { desc = "Jump to next mark", silent = true, noremap = true })
vim.keymap.set("n", "<leader>mk", ":lua require('marks').prev()<CR>", { desc = "Jump to previous mark", silent = true, noremap = true })
-- Allow jumping to marks by using ' (apostrophe) as normal
vim.keymap.set("n", "'", "'", { desc = "Jump to mark position" })

-- Toggle between checkbox and bullet point
vim.api.nvim_create_user_command("ToggleCheckbox", function(opts)
  local process_line = function(line)
    -- Check if line has a checkbox pattern
    if line:match("- %[.%]") then
      -- Convert checkbox to bullet
      return line:gsub("- %[.%]", "-")
    -- Check if line has a bullet pattern (consider different bullet styles)
    elseif line:match("^%s*- ") then
      -- Convert bullet to checkbox
      return line:gsub("^(%s*)-(%s+)", "%1- [ ]%2")
    else
      -- No change if it's neither
      return line
    end
  end
  
  if opts.range == 0 then
    -- Single line mode
    local line = vim.api.nvim_get_current_line()
    local new_line = process_line(line)
    vim.api.nvim_set_current_line(new_line)
  else
    -- Visual selection mode
    local start_line = opts.line1
    local end_line = opts.line2
    
    for line_num = start_line, end_line do
      local line = vim.api.nvim_buf_get_lines(0, line_num-1, line_num, false)[1]
      local new_line = process_line(line)
      vim.api.nvim_buf_set_lines(0, line_num-1, line_num, false, {new_line})
    end
  end
end, {range = true})

-- Add keybinding for toggling checkbox/bullet - normal and visual mode
vim.keymap.set("n", "<leader>cb", ":ToggleCheckbox<CR>", { desc = "Toggle checkbox/bullet", silent = true, noremap = true })
vim.keymap.set("v", "<leader>cb", ":ToggleCheckbox<CR>", { desc = "Toggle checkbox/bullet (visual)", silent = true, noremap = true })

-- Go-specific keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    -- Go.nvim commands
    vim.keymap.set("n", ";gf", ":GoFillStruct<CR>", { buffer = true, desc = "Fill struct with default values", silent = true })
    vim.keymap.set("n", ";gi", ":GoIfErr<CR>", { buffer = true, desc = "Add if err != nil", silent = true })
    vim.keymap.set("n", ";gI", ":GoImpl<CR>", { buffer = true, desc = "Generate interface implementation", silent = true })
    vim.keymap.set("n", ";gt", ":GoAddTag<CR>", { buffer = true, desc = "Add struct tags", silent = true })
    vim.keymap.set("n", ";gT", ":GoRmTag<CR>", { buffer = true, desc = "Remove struct tags", silent = true })
    vim.keymap.set("n", ";gc", ":GoCmt<CR>", { buffer = true, desc = "Add comment", silent = true })
    vim.keymap.set("n", ";ge", ":GoGenerate<CR>", { buffer = true, desc = "Run go generate", silent = true })
    vim.keymap.set("n", ";ga", ":GoAlt<CR>", { buffer = true, desc = "Switch between code and test", silent = true })
    vim.keymap.set("n", ";gA", ":GoAltV<CR>", { buffer = true, desc = "Switch between code and test (vsplit)", silent = true })

    -- Gopher.nvim commands
    vim.keymap.set("n", ";gsj", ":GoTagAdd json<CR>", { buffer = true, desc = "Add json struct tags", silent = true })
    vim.keymap.set("n", ";gsy", ":GoTagAdd yaml<CR>", { buffer = true, desc = "Add yaml struct tags", silent = true })
    vim.keymap.set("n", ";gsi", ":GoIfErr<CR>", { buffer = true, desc = "Generate if err", silent = true })

    -- Testing
    vim.keymap.set("n", ";gtr", ":GoTest<CR>", { buffer = true, desc = "Run Go tests", silent = true })
    vim.keymap.set("n", ";gtf", ":GoTestFunc<CR>", { buffer = true, desc = "Run test for current function", silent = true })
    vim.keymap.set("n", ";gtp", ":GoTestPkg<CR>", { buffer = true, desc = "Run tests for package", silent = true })
    vim.keymap.set("n", ";gta", ":lua require('neotest').run.run()<CR>", { buffer = true, desc = "Run nearest test", silent = true })
    vim.keymap.set("n", ";gtA", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { buffer = true, desc = "Run all tests in file", silent = true })
    vim.keymap.set("n", ";gts", ":lua require('neotest').summary.toggle()<CR>", { buffer = true, desc = "Toggle test summary", silent = true })
    vim.keymap.set("n", ";gto", ":lua require('neotest').output.open({ enter = true })<CR>", { buffer = true, desc = "Show test output", silent = true })

    -- Debugging
    vim.keymap.set("n", ";gdb", ":lua require('dap-go').debug_test()<CR>", { buffer = true, desc = "Debug test", silent = true })
    vim.keymap.set("n", ";gdl", ":lua require('dap-go').debug_last()<CR>", { buffer = true, desc = "Debug last test", silent = true })

    -- Build and run
    vim.keymap.set("n", ";gb", ":GoBuild<CR>", { buffer = true, desc = "Build Go project", silent = true })
    vim.keymap.set("n", ";gr", ":GoRun<CR>", { buffer = true, desc = "Run Go project", silent = true })

    -- Code coverage
    vim.keymap.set("n", ";gcv", ":GoCoverage<CR>", { buffer = true, desc = "Show code coverage", silent = true })
    vim.keymap.set("n", ";gcV", ":GoCoverageClear<CR>", { buffer = true, desc = "Clear code coverage", silent = true })
  end,
})

-- HLedger keymaps
vim.keymap.set("n", "<leader>hb", ":HledgerBalance<CR>", { desc = "HLedger balance report", silent = true })
vim.keymap.set("n", "<leader>hr", ":HledgerRegister<CR>", { desc = "HLedger register report", silent = true })
vim.keymap.set("n", "<leader>ha", ":HledgerAccounts<CR>", { desc = "HLedger accounts picker", silent = true })

-- TidalCycles keymaps (global - work in any file type)
vim.keymap.set("n", "<leader>Tl", ":TidalLaunch<CR>", { desc = "Launch TidalCycles", silent = true })
vim.keymap.set("n", "<leader>Tq", ":TidalQuit<CR>", { desc = "Quit TidalCycles", silent = true })
