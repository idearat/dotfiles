-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd("hi! link AlphaHeader @text.literal")
vim.cmd("hi! link AlphaButton @text.note")
vim.cmd("hi! link AlphaButtonShortcut @text.literal")
vim.cmd("hi! link AlphaQuote @comment")

-- Explicit handling of escape key to ensure it works properly with AI completion tools
-- Use a simple mapping that first checks if completion is visible
vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"]], { noremap = true, expr = true, silent = true })

-- We're handling Ctrl-; directly in the Copilot plugin configuration

-- Ensure InsertLeave autocmd for clearing any pending suggestions
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    -- Clear any pending AI suggestions
    pcall(function()
      -- Try to clear Copilot suggestions
      if vim.fn.exists("*copilot#Clear") == 1 then
        vim.fn["copilot#Clear"]()
      end

      -- Try to clear Codeium suggestions
      if vim.fn.exists("*codeium#Clear") == 1 then
        vim.fn["codeium#Clear"]()
      end
    end)
  end,
})
