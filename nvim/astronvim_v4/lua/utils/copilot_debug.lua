-- CopilotChat keybinding debugger
local M = {}

-- Function to get all keymaps for a buffer
function M.get_buffer_keymaps(bufnr)
  local keymaps = {}
  
  -- Get all modes we care about
  local modes = {'n', 'i', 'v', 'x'}
  
  for _, mode in ipairs(modes) do
    local maps = vim.api.nvim_buf_get_keymap(bufnr, mode)
    for _, map in ipairs(maps) do
      table.insert(keymaps, {
        mode = mode,
        lhs = map.lhs,
        rhs = map.rhs or map.callback and "<Lua callback>" or "?",
        desc = map.desc,
        noremap = map.noremap,
        silent = map.silent,
      })
    end
  end
  
  return keymaps
end

-- Function to debug CopilotChat buffer
function M.debug_copilot_chat()
  -- Find CopilotChat buffer
  local chat_bufnr = nil
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("copilot%-chat") or vim.bo[bufnr].filetype == "copilot-chat" then
      chat_bufnr = bufnr
      break
    end
  end
  
  if not chat_bufnr then
    print("CopilotChat buffer not found. Open a chat first.")
    return
  end
  
  print("=== CopilotChat Debug Info ===")
  print("Buffer number:", chat_bufnr)
  print("Buffer name:", vim.api.nvim_buf_get_name(chat_bufnr))
  print("Filetype:", vim.bo[chat_bufnr].filetype)
  print("")
  
  -- Get buffer options that might affect keybindings
  print("=== Buffer Options ===")
  print("modifiable:", vim.bo[chat_bufnr].modifiable)
  print("readonly:", vim.bo[chat_bufnr].readonly)
  print("buftype:", vim.bo[chat_bufnr].buftype)
  print("")
  
  -- Get keymaps
  print("=== Keymaps ===")
  local keymaps = M.get_buffer_keymaps(chat_bufnr)
  
  -- Group by mode
  local by_mode = {}
  for _, map in ipairs(keymaps) do
    by_mode[map.mode] = by_mode[map.mode] or {}
    table.insert(by_mode[map.mode], map)
  end
  
  -- Print keymaps by mode
  for mode, maps in pairs(by_mode) do
    print(string.format("\n[%s mode]", mode == 'n' and 'Normal' or mode == 'i' and 'Insert' or mode))
    for _, map in ipairs(maps) do
      print(string.format("  %s -> %s%s", 
        map.lhs, 
        map.rhs,
        map.desc and (" (" .. map.desc .. ")") or ""
      ))
    end
  end
  
  -- Check for specific keys we care about
  print("\n=== Checking Critical Keys ===")
  local critical_keys = {
    {mode = 'i', key = '<CR>'},
    {mode = 'i', key = '<C-y>'},
    {mode = 'i', key = '<Tab>'},
    {mode = 'i', key = '<C-c>'},
    {mode = 'n', key = '<C-y>'},
    {mode = 'n', key = 'q'},
  }
  
  for _, check in ipairs(critical_keys) do
    local found = false
    for _, map in ipairs(keymaps) do
      if map.mode == check.mode and map.lhs == check.key then
        print(string.format("%s mode %s: %s", check.mode, check.key, map.rhs))
        found = true
        break
      end
    end
    if not found then
      print(string.format("%s mode %s: NOT MAPPED", check.mode, check.key))
    end
  end
  
  -- Check autocmds
  print("\n=== Autocmds for CopilotChat ===")
  local autocmds = vim.api.nvim_get_autocmds({
    event = {"BufEnter", "BufWinEnter", "FileType"},
    pattern = {"*copilot*", "copilot-chat"},
  })
  
  for _, autocmd in ipairs(autocmds) do
    print(string.format("Event: %s, Pattern: %s, Group: %s", 
      autocmd.event, 
      autocmd.pattern or "?",
      autocmd.group_name or autocmd.group or "?"
    ))
  end
end

-- Function to trace keybinding conflicts
function M.trace_keymap(mode, key)
  print(string.format("\n=== Tracing %s in %s mode ===", key, mode))
  
  -- Global mapping
  local global_maps = vim.api.nvim_get_keymap(mode)
  for _, map in ipairs(global_maps) do
    if map.lhs == key then
      print("Global mapping:", map.rhs or "<Lua callback>")
    end
  end
  
  -- Current buffer mapping
  local buf_maps = vim.api.nvim_buf_get_keymap(0, mode)
  for _, map in ipairs(buf_maps) do
    if map.lhs == key then
      print("Buffer mapping:", map.rhs or "<Lua callback>")
    end
  end
end

-- Command to run the debugger
vim.api.nvim_create_user_command('CopilotChatDebug', function()
  M.debug_copilot_chat()
end, { desc = "Debug CopilotChat keybindings" })

-- Command to trace a specific key
vim.api.nvim_create_user_command('CopilotChatTrace', function(opts)
  local args = vim.split(opts.args, ' ')
  if #args >= 2 then
    M.trace_keymap(args[1], args[2])
  else
    print("Usage: CopilotChatTrace <mode> <key>")
    print("Example: CopilotChatTrace i <CR>")
  end
end, { nargs = '+', desc = "Trace a specific keymap" })

return M