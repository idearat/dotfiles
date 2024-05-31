return {
  {
    "folke/which-key.nvim",
    opts = function(opts)
      local utils = require "astrocore"
      opts = utils.extend_tbl(opts, {
        icons = { group = vim.g.icons_enabled and "" or "", separator = "" },
        key_labels = { ["<C-i>"] = "<C-I>" }, -- sadly this doesn't work :(
        layout = { height = { min = 5, max = 50 } },
        window = { border = "single", winblend = 0, rounded = true },
      })
      return opts
    end,
  },
}
