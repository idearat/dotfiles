-- This module handles accepting completions from both nvim-cmp and Copilot
-- without producing strange character sequences 

return function()
  local cmp = require("cmp")
  
  -- Check if the completion menu is visible
  if vim.fn.pumvisible() == 1 then
    -- Accept the current nvim-cmp selection
    print("CMP menu visible, accepting selection")
    cmp.confirm({ select = true })
  else
    -- Try to accept Copilot suggestion
    print("Trying to accept Copilot suggestion")
    
    -- Check if we have the copilot.vim plugin
    if vim.fn.exists("*copilot#Accept") == 1 then
      print("Using copilot#Accept")
      vim.fn["copilot#Accept"]("")
    else
      print("No copilot#Accept function found")
      -- Try other methods - this is for zbirenbaum/copilot.lua
      local ok, copilot = pcall(require, "copilot.suggestion")
      if ok and copilot then
        print("Using copilot.suggestion.accept()")
        copilot.accept()
      else
        print("Could not find any copilot accept method")
      end
    end
  end
end
