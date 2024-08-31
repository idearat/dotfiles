return {
  {
    "folke/which-key.nvim",
    opts = function(opts)
      local utils = require "astrocore"
      opts = utils.extend_tbl(opts, {
        preset = "modern",
        icons = { group = vim.g.icons_enabled and "" or "", separator = "" },
        layout = {
          width = { min = 20 },
          spacing = 3,
        },
        win = {
          border = "single",
          height = { min = 5, max = 50 },
        },
        keys = {
          scroll_down = "<c-down>", -- binding to scroll down inside the popup
          scroll_up = "<c-up>", -- binding to scroll up inside the popup
        },
        sort = {
          "alphanum", "order", "mod"
        },
      })
      return opts
    end,
  },
}
