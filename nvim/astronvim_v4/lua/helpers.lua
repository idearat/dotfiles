local M = {}

vim.api.nvim_create_user_command("CloseFloatingWindows", function(opts)
  for _, window_id in ipairs(vim.api.nvim_list_wins()) do
    -- If window is floating
    if vim.api.nvim_win_get_config(window_id).relative ~= "" then
      -- Force close if called with !
      vim.api.nvim_win_close(window_id, opts.bang)
    end
  end
end, { bang = true })

M.eval = function()
  vim.ui.input({ prompt = "Expression: " }, function(expr)
    if expr then require("dapui").eval(expr) end
  end)
end

M.get_session_name = function()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system("git branch --show-current")
  if vim.v.shell_error == 0 then
    return name .. '-' .. vim.trim(branch --[[@as string]])
  else
    return name
  end
end

M.removekey = function(table, key)
  local element = table[key]
  table[key] = nil
  return element
end

M.renamekey = function(table, oldkey, newkey)
  if table[oldkey] then table[newkey] = M.removekey(table, oldkey) end
end

M.renamekeys = function(table, oldkeys, newkeys)
  for i, oldkey in ipairs(oldkeys) do
    M.renamekey(table, oldkey, newkeys[i])
  end
end

M.renameleader = function(table, oldleader, newleader)
  -- rename the root key
  if table["<Leader>" .. oldleader] then
    M.renamekey(table, "<Leader>" .. oldleader, "<Leader>" .. newleader)
  end

  -- rename the subkeys
  for key, _ in pairs(table) do
    if key:find("<Leader>" .. oldleader, 1, true) == 1 then
      M.renamekey(table, key, key:gsub("<Leader>" .. oldleader, "<Leader>" .. newleader))
    end
  end
end

return M
