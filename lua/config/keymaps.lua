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

-- Aerial keybindings
vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial Outline" })
vim.keymap.set("n", "<leader>an", "<cmd>AerialNavToggle<CR>", { desc = "Toggle Aerial Navigator" })
vim.keymap.set("n", "[s", "<cmd>AerialPrev<CR>", { desc = "Previous Symbol" })
vim.keymap.set("n", "]s", "<cmd>AerialNext<CR>", { desc = "Next Symbol" })

-- Keybindings for todo navigation
vim.keymap.set("n", "]T", ":NextTodo<CR>", { desc = "Next TODO or todo test", silent = true })
vim.keymap.set("n", "[T", ":PrevTodo<CR>", { desc = "Previous TODO or todo test", silent = true })

-- List all TODOs in project with two separate commands
vim.api.nvim_create_user_command("ListAllTodos", function()
  -- Create a buffer to collect todos
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  
  -- Function to add results to our buffer
  local function append_data(_, data)
    if data then
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
    end
  end
  
  -- Function to handle process completion
  local function on_exit(_, _, _)
    -- Get buffer content
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    
    -- If we have results, show them in telescope
    if #lines > 0 then
      vim.defer_fn(function()
        require("telescope.pickers").new({}, {
          prompt_title = "All TODOs",
          finder = require("telescope.finders").new_table({
            results = lines,
            entry_maker = function(entry)
              -- Parse the ripgrep output format
              local _, filename, lnum, text = string.match(entry, "([^:]+):([^:]+):([^:]+):(.*)")
              if not filename then
                return nil
              end
              return {
                value = entry,
                ordinal = entry,
                display = entry,
                filename = filename,
                lnum = tonumber(lnum),
                text = text
              }
            end,
          }),
          sorter = require("telescope.config").values.generic_sorter({}),
          previewer = require("telescope.config").values.grep_previewer({}),
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = require("telescope.actions.state").get_selected_entry()
              if selection then
                vim.cmd("edit " .. selection.filename)
                vim.api.nvim_win_set_cursor(0, {selection.lnum, 0})
                vim.cmd("normal! zz")
              end
            end)
            return true
          end,
        }):find()
      end, 100)
    else
      vim.notify("No TODOs found", vim.log.levels.INFO)
    end
  end
  
  -- First search for TODO:
  vim.fn.jobstart("rg --no-heading --line-number 'TODO:' --glob '**/*.{js,jsx,ts,tsx,lua,md}'", {
    on_stdout = append_data,
    on_exit = function()
      -- Then search for test.todo and it.todo
      vim.fn.jobstart("rg --no-heading --line-number '(test|it)\\.todo\\(' --glob '**/*.{js,jsx,ts,tsx}'", {
        on_stdout = append_data,
        on_exit = on_exit
      })
    end
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
vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load()
end, { desc = "Load session for current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
  require("persistence").select()
end, { desc = "Select session to load" })

-- load the last session
vim.keymap.set("n", "<leader>qL", function()
  require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- save session manually
vim.keymap.set("n", "<leader>qs", function()
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
