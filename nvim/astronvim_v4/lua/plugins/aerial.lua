return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- Set the backend priority
    opts.backends = { "lsp", "treesitter" }

    opts.layout = {
      min_width = 40,
    }
    -- Filter out variables and other data-only symbols
    opts.filter_kind = {
      "Array",
      "Boolean",
      "Class",
      "Constant",
      "Constructor",
      "Enum",
      "EnumMember",
      "Event",
      "Field",
      "File",
      "Function",
      "Interface",
      "Key",
      "Method",
      "Module",
      "Namespace",
      "Null",
      "Number",
      "Object",
      "Operator",
      "Package",
      "Property",
      "String",
      "Struct",
      "TypeParameter",
      "Variable",
    }
    -- Add visual guides to make nesting obvious
    opts.show_guides = true
  end,
}
