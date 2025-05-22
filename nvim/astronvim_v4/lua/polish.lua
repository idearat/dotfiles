-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd("hi! link AlphaHeader @text.literal")
vim.cmd("hi! link AlphaButton @text.note")
vim.cmd("hi! link AlphaButtonShortcut @text.literal")
vim.cmd("hi! link AlphaQuote @comment")

-- Test mappings to verify which-key scrolling keys are received
-- These will be overridden by which-key when it's active, but help debug
vim.keymap.set("n", "<C-Up>", function() 
  print("C-Up received - which-key should handle this in popup") 
end, { desc = "Test C-Up" })
vim.keymap.set("n", "<C-Down>", function() 
  print("C-Down received - which-key should handle this in popup") 
end, { desc = "Test C-Down" })

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
      -- Try to clear Codeium suggestions
      if vim.fn.exists("*codeium#Clear") == 1 then
        vim.fn["codeium#Clear"]()
      end
    end)
  end,
})
