return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      backdrop = 0.95,
      width = function() return math.min(90, vim.o.columns * 0.75) end,
      height = 0.9,
      options = {
        number = true,
        relativenumber = true,
        foldcolumn = "0",
        list = false,
        showbreak = "NONE",
        signcolumn = "yes:2",
        scrolloff = 99999,
      },
    },
    plugins = {
      options = {
        cmdheight = 1,
        laststatus = 0,
      },
      tmux = { enabled = false },
      twilight = { enabled = true },
      gitsigns = { enabled = true },
      diagnostics = { enabled = true },
    },
    on_open = function() -- disable diagnostics and indent blankline
      -- vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
      -- vim.g.diagnostics_mode = 2
      -- vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
      -- vim.g.indent_blankline_enabled_old = vim.g.indent_blankline_enabled
      -- vim.g.indent_blankline_enabled = false
      vim.cmd("Gitsigns toggle_signs")
    end,
    on_close = function() -- restore diagnostics and indent blankline
      -- vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
      -- vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
      -- vim.g.indent_blankline_enabled = vim.g.indent_blankline_enabled_old
    end,
  },
}
