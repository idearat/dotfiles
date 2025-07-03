-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Load debug utilities
require("utils.test_copilot_keys")

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

-- Kill any ghost text that appears
vim.api.nvim_create_autocmd({"InsertEnter", "TextChangedI"}, {
  callback = function()
    -- Dismiss Copilot suggestions
    pcall(function()
      require("copilot.suggestion").dismiss()
    end)
  end,
})

-- Force disable Ctrl-q after everything loads
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Unmap Ctrl-q in all modes
    pcall(vim.keymap.del, "n", "<C-q>")
    pcall(vim.keymap.del, "i", "<C-q>")
    pcall(vim.keymap.del, "v", "<C-q>")
    pcall(vim.keymap.del, "x", "<C-q>")
    
    -- Also try the api directly
    pcall(vim.api.nvim_del_keymap, "n", "<C-q>")
    
    -- Nuclear option - remap to nothing
    vim.keymap.set({"n", "i", "v", "x"}, "<C-q>", "<Nop>", { silent = true, desc = "Disabled (was quit)" })
  end,
})
