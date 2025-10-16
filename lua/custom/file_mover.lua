-- File mover module
local M = {}

-- Move current file using Telescope
M.move_file_telescope = function()
  local current_file = vim.fn.expand("%:p")
  local current_name = vim.fn.expand("%:t")
  
  if current_file == "" then
    vim.notify("No file is currently open", vim.log.levels.ERROR)
    return
  end
  
  -- Check if file has been saved
  if vim.bo.modified then
    vim.notify("Please save the file before moving it", vim.log.levels.WARN)
    return
  end
  
  -- Use Telescope for directory selection
  local telescope_ok, _ = pcall(require, "telescope")
  if not telescope_ok then
    vim.notify("Telescope is not available", vim.log.levels.ERROR)
    return
  end
  
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  
  -- Get current file directory as starting point
  local current_dir = vim.fn.expand("%:p:h")
  
  -- Find all directories recursively starting from the current file's directory
  -- or fallback to home directory if there's an issue
  local cmd
  if vim.fn.isdirectory(current_dir) == 1 then
    cmd = string.format("find %s -type d -not -path '*/\\.*' | sort", vim.fn.shellescape(current_dir))
  else
    -- Fallback to home directory
    cmd = string.format("find %s -type d -not -path '*/\\.*' | sort", vim.fn.shellescape(vim.fn.expand("~")))
  end
  
  local handle = io.popen(cmd)
  if not handle then
    vim.notify("Failed to execute directory search", vim.log.levels.ERROR)
    return
  end
  
  local result = handle:read("*a")
  handle:close()
  
  local dirs = {}
  for dir in string.gmatch(result, "([^\n]+)") do
    -- Convert relative path to absolute path
    local abs_path = vim.fn.fnamemodify(dir, ":p")
    table.insert(dirs, abs_path)
  end
  
  -- Create a custom picker that only shows directories
  pickers.new({}, {
    prompt_title = "Select Target Directory",
    finder = finders.new_table({
      results = dirs,
      entry_maker = function(entry)
        -- Get the relative path for display (more readable)
        local display = vim.fn.fnamemodify(entry, ":~:.")
        return {
          value = entry,
          display = display,
          ordinal = display,
          path = entry
        }
      end
    }),
    sorter = conf.generic_sorter({}),
    previewer = conf.file_previewer({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        
        if selection then
          local target_path = selection.path
          
          -- Ensure path is a directory (should always be true with our picker)
          if vim.fn.isdirectory(target_path) == 0 then
            vim.notify("Selected path is not a directory", vim.log.levels.ERROR)
            return
          end
          
          -- Ask for confirmation
          vim.ui.input({
            prompt = string.format("Move '%s' to '%s'? (y/N): ", current_name, target_path)
          }, function(input)
            if input and (input:lower() == "y" or input:lower() == "yes") then
              -- Build target file path
              local target_file = target_path .. "/" .. current_name
              
              -- Check if target file already exists
              if vim.fn.filereadable(target_file) == 1 then
                vim.notify("File already exists at target location", vim.log.levels.ERROR)
                return
              end
              
              -- Remember the current buffer number
              local current_buf = vim.api.nvim_get_current_buf()
              
              -- Move the file
              local success = os.rename(current_file, target_file)
              
              if success then
                -- Close the current buffer
                vim.cmd("bdelete " .. current_buf)
                
                -- Open the new file location
                vim.cmd("edit " .. target_file)
                
                vim.notify(string.format("Moved file to %s", target_file), vim.log.levels.INFO)
              else
                vim.notify("Failed to move file", vim.log.levels.ERROR)
              end
            end
          end)
        end
      end)
      return true
    end
  })
end

-- Move current file using Yazi
M.move_file_yazi = function()
  local current_file = vim.fn.expand("%:p")
  local current_name = vim.fn.expand("%:t")
  
  if current_file == "" then
    vim.notify("No file is currently open", vim.log.levels.ERROR)
    return
  end
  
  -- Check if file has been saved
  if vim.bo.modified then
    vim.notify("Please save the file before moving it", vim.log.levels.WARN)
    return
  end
  
  -- Remember the current buffer number
  local current_buf = vim.api.nvim_get_current_buf()
  
  -- Define the path to yazi binary
  local yazi_bin = "/Users/franz/.nix-profile/bin/yazi"
  
  -- Create a temporary file to store the selection
  local temp_file = vim.fn.tempname()
  
  -- Get the parent directory of the current file as starting point
  local start_dir = vim.fn.fnamemodify(current_file, ":h")
  
  -- Create a new buffer for terminal to avoid oil.vim triggering
  vim.cmd("enew")
  
  -- Open Yazi in the terminal buffer
  vim.cmd(string.format("terminal cd %s && %s --chooser-file='%s'", 
                      vim.fn.shellescape(start_dir), yazi_bin, temp_file))
  
  -- Enter terminal mode
  vim.cmd("startinsert")
  
  -- Set up autocmd to process the result when the terminal closes
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      -- Check if the temp file exists and read the selected path
      if vim.fn.filereadable(temp_file) == 1 then
        local target_path = vim.fn.readfile(temp_file)[1]
        
        -- Cleanup the temp file
        os.remove(temp_file)
        
        -- Ensure path is a directory
        if vim.fn.isdirectory(target_path) == 1 then
          -- Build target file path
          local target_file = target_path .. "/" .. current_name
          
          -- Check if target file already exists
          if vim.fn.filereadable(target_file) == 1 then
            vim.notify("File already exists at target location", vim.log.levels.ERROR)
            return
          end
          
          -- Move the file
          local success = os.rename(current_file, target_file)
          
          if success then
            -- Close the terminal buffer
            vim.cmd("bdelete!")
            
            -- Close the source buffer if it still exists
            if vim.api.nvim_buf_is_valid(current_buf) then
              pcall(vim.cmd, "bdelete " .. current_buf)
            end
            
            -- Open the new file location
            vim.cmd("edit " .. target_file)
            
            vim.notify(string.format("Moved file to %s", target_file), vim.log.levels.INFO)
          else
            vim.notify("Failed to move file", vim.log.levels.ERROR)
          end
        else
          vim.notify("Selected path is not a directory", vim.log.levels.ERROR)
        end
      else
        vim.notify("No directory selected", vim.log.levels.INFO)
      end
    end,
    once = true
  })
end

return M