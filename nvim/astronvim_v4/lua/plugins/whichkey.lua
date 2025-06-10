return {
  {
    "folke/which-key.nvim",
    opts = function(opts)
      local utils = require "astrocore"
      opts = utils.extend_tbl(opts, {
        preset = "classic",
        delay = 250,
        timeout = 0, -- Disable timeout completely
        triggers = {
          { "<auto>", mode = "nxsot" }, -- Add loop to auto triggers
        },
        defer = function(ctx)
          return false -- Never auto-close, force manual Esc
        end,
        icons = {
          breadcrumb = "",
          separator = "",
          group = "",
          ellipsis = "...",
          mappings = false, -- No icons at all
        },
        layout = {
        },
        win = {
          border = "single",
          no_overlap = true,
          width = { min = 20 },
          height = { min = 4, max = 50 }, -- Even taller max
          padding = { 2, 4 }, -- More padding for better spacing
          title = false, -- No title bar
          wo = {
            winblend = 5, -- More opaque (less transparent)
          },
        },
        keys = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        sort = { "alphanum" },
        filter = function(mapping)
          return true
        end,
      })
      return opts
    end,
    config = function(_, opts)
      require("which-key").setup(opts)

      -- Clean grayscale theme - darker background closer to black
      vim.cmd([[
        highlight WhichKeyFloat guibg=#1a1a1a guifg=#d0d0d0
        highlight WhichKeyBorder guibg=#1a1a1a guifg=#808080
        highlight WhichKeyNormal guibg=#1a1a1a guifg=#d0d0d0
        highlight WhichKeyDesc guifg=#a0a0a0
        highlight WhichKeyGroup guifg=#808080
        highlight WhichKeySeparator guifg=#606060
        highlight WhichKeyValue guifg=#c0c0c0
      ]])
    end,
  },
}
