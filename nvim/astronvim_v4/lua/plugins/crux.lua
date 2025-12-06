-- CR:UX language support with tree-sitter

return {
  {
    "AstroNvim/astrocore",
    opts = {
      filetypes = {
        extension = {
          crux = "crux",
        },
      },
      autocmds = {
        crux_treesitter = {
          {
            event = {"BufEnter", "BufWinEnter"},
            pattern = "*.crux",
            callback = function()
              vim.cmd("syntax off")
              vim.api.nvim_set_hl(0, "@error", {
                fg = "#ff0000",
                -- bold = true,
                underline = true,
              })
              vim.api.nvim_set_hl(0, "@warning", {
                fg = "#ff8800",
                -- bold = true,
                underline = true,
              })
              vim.treesitter.start()
            end,
          },
          {
            event = "FileType",
            pattern = "crux",
            callback = function()
              vim.cmd("syntax off")
              vim.api.nvim_set_hl(0, "@error", {
                fg = "#ff0000",
                -- bold = true,
                underline = true,
              })
              vim.api.nvim_set_hl(0, "@warning", {
                fg = "#ff8800",
                -- bold = true,
                underline = true,
              })
              vim.treesitter.start()
            end,
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers")
        .get_parser_configs()

      -- Use custom CR:UX parser (fork of JavaScript)
      parser_config.crux = {
        install_info = {
          url = "/Users/ss/dev/coderats/repos/coderats-platform/tools/tars/grammars/crux",
          files = {"src/parser.c", "src/scanner.c"},
        },
        filetype = "crux",
      }

      return opts
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        crux_colors = {
          {
            event = "ColorScheme",
            callback = function()
              vim.api.nvim_set_hl(0, "@error", {
                fg = "#ff0000",
                -- bold = true,
                underline = true,
              })
              vim.api.nvim_set_hl(0, "@warning", {
                fg = "#ff8800",
                -- bold = true,
                underline = true,
              })
            end,
          },
        },
      },
    },
  },
}
