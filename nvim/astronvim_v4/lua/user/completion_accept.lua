-- This module handles accepting completions from nvim-cmp and Codeium

return function()
  local cmp = require("cmp")
  
  -- Check if the completion menu is visible
  if vim.fn.pumvisible() == 1 then
    -- Accept the current nvim-cmp selection
    cmp.confirm({ select = true })
  else
    -- Try to accept Codeium suggestion
    if vim.fn.exists("*codeium#Accept") == 1 then
      -- Use Codeium's accept function
      vim.fn["codeium#Accept"]()
    else
      -- No completion available - do nothing (preserve Tab for actual tab insertion)
      -- Could add a subtle notification if desired
    end
  end
end