-- Silence LuaSnip's verbose INFO messages
return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      -- Set log level to ERROR only (silences INFO messages)
      vim.g.luasnip_log_level = 3 -- ERROR level
      return opts
    end,
  },
}
