return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- Set the backend priority
    opts.backends = { "lsp", "treesitter" }

    opts.layout = {
      min_width = 40,
    }
    -- Filter out variables and other data-only symbols
    opts.filter_kind = false

    -- Add visual guides to make nesting obvious
    opts.show_guides = true
  end,
}
