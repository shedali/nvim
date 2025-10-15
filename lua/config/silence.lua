-- Silence noisy startup messages in headless mode only
-- This runs before lazy.nvim loads

-- Only apply silence in headless mode to avoid breaking plugin initialization
if #vim.api.nvim_list_uis() == 0 then
  -- Override print to filter INFO messages in headless mode
  local original_print = print
  _G.print = function(...)
    local args = {...}
    local msg = table.concat(vim.tbl_map(tostring, args), " ")
    -- Filter out LuaSnip INFO messages
    if msg:match("INFO: plugin") and msg:match("not loaded") then
      return
    end
    original_print(...)
  end

  -- Redirect stderr in headless mode
  local devnull = io.open("/dev/null", "w")
  if devnull then
    io.stderr = devnull
  end
end
