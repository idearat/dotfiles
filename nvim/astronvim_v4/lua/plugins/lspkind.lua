return {
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      local lspkind = require "lspkind"
      local utils = require "astrocore"

      opts = utils.extend_tbl(opts, {
        mode = "symbol",
        menu = {
          codeium = "[Codeium]",
          path = "[Path]",
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
        },
        maxwidth = function() return math.floor(0.65 * vim.o.columns) end,
        ellipsis_char = "...",
        show_labelDetails = true,
      })

      return opts
    end,
  },
}
