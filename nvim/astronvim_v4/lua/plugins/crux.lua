-- CR:UX language support
-- Uses vim syntax highlighting (after/syntax/crux.vim)

return {
  -- Just ensure .crux files get crux filetype
  {
    "AstroNvim/astrocore",
    opts = {
      filetypes = {
        extension = {
          crux = "crux",
        },
      },
      autocmds = {
        crux_setup = {
          {
            event = "FileType",
            pattern = "crux",
            callback = function()
              -- Just use JavaScript syntax, no custom highlighting
              vim.bo.syntax = "javascript"
            end,
          },
        },
      },
    },
  },
}
