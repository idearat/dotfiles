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
    
    -- Update diagnostics on save
    config.update_in_insert = false
    config.diagnostics_format = "[#{c}] #{m} (#{s})"
    config.on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        -- Format on save if needed
      end
      
      -- Ensure diagnostics update on save for this buffer
      vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        callback = function()
          -- Force none-ls to update diagnostics
          vim.schedule(function()
            -- Trigger diagnostic refresh by notifying of a change
            local params = {
              textDocument = {
                uri = vim.uri_from_bufnr(bufnr),
                version = vim.lsp.util.buf_versions[bufnr] or 0
              },
              contentChanges = {}
            }
            client.notify("textDocument/didChange", params)
          end)
        end,
      })
    end
    
    return config -- return final config table
  end,
}
