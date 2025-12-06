-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Add TARS linter for CR:UX files
      require("utils.tars_diagnostics"),

      -- Add any other formatters/linters you want
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
    }
    
    -- Update diagnostics on save and open
    config.update_in_insert = false
    config.diagnostics_format = "[#{c}] #{m} (#{s})"
    
    return config -- return final config table
  end,
}
