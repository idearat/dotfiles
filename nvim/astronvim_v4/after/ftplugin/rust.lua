-- Rust-specific settings to override any defaults
-- Set indent to 2 spaces to match .editorconfig and rustfmt.toml
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- Set up rustfmt as the equalprg for Rust files
-- This allows formatting with the = operator (e.g., gg=G or =%)
vim.opt_local.equalprg = "rustfmt"

-- Add a debug command to check formatting capabilities
vim.api.nvim_buf_create_user_command(0, "RustFormatDebug", function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    if client.name == "rust_analyzer" then
      vim.notify("rust-analyzer active: " .. vim.inspect(client.server_capabilities.documentFormattingProvider))
    end
  end
  vim.notify("equalprg: " .. vim.opt_local.equalprg:get())
end, { desc = "Debug Rust formatting setup" })

-- Debug message to confirm this is loaded
-- vim.notify("Rust ftplugin loaded: indent set to 2 spaces", vim.log.levels.INFO)