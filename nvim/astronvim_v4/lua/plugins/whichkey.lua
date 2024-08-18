return {
  {
    "folke/which-key.nvim",
    opts = function(opts)
      local utils = require "astrocore"
      opts = utils.extend_tbl(opts, {
        preset = "modern",
        icons = { group = vim.g.icons_enabled and "" or "", separator = "" },
        layout = {
          height = { min = 5, max = 50 },
          win = { border = "single", winblend = 0, rounded = true },
        }
      })
      return opts
    end,
  },
}
