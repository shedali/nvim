return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function(_, opts)
    -- Override the problematic config from LazyVim
    opts = opts or {}
    -- Remove any Snacks-related configuration
    opts.on = nil
    require("render-markdown").setup(opts)
  end,
}