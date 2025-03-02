-- This module handles accepting completions from both nvim-cmp and Copilot
-- without producing strange character sequences 

return function()
  local cmp = require("cmp")
  
  -- Check if the completion menu is visible
  if vim.fn.pumvisible() == 1 then
    -- Accept the current nvim-cmp selection
    cmp.confirm({ select = true })
  else
    -- Try to accept Copilot suggestion
    pcall(function()
      vim.fn["copilot#Accept"]("")
    end)
  end
end
