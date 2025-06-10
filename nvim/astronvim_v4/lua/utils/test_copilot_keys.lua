-- Test script for CopilotChat keybindings
local M = {}

function M.test_copilot_chat()
  -- Open CopilotChat
  vim.cmd('CopilotChat')
  
  -- Wait a bit for the window to open
  vim.defer_fn(function()
    -- Find the CopilotChat buffer
    local chat_buf = nil
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].filetype == "copilot-chat" then
        chat_buf = buf
        break
      end
    end
    
    if not chat_buf then
      print("ERROR: CopilotChat buffer not found!")
      return
    end
    
    print("Testing CopilotChat keybindings in buffer " .. chat_buf)
    print("=====================================")
    
    -- Test what's actually mapped
    local function check_mapping(mode, key, expected_desc)
      local maps = vim.api.nvim_buf_get_keymap(chat_buf, mode)
      local found = false
      for _, map in ipairs(maps) do
        if map.lhs == key then
          print(string.format("[%s] %s -> %s", mode, key, map.rhs or "<Lua>"))
          found = true
          break
        end
      end
      if not found then
        print(string.format("[%s] %s -> NOT MAPPED!", mode, key))
      end
    end
    
    -- Check critical mappings
    print("\nChecking Insert Mode:")
    check_mapping('i', '<CR>', 'Should be plain newline')
    check_mapping('i', '<C-y>', 'Should submit')
    check_mapping('i', '<Tab>', 'Should be plain tab')
    check_mapping('i', '<C-c>', 'Should close chat')
    check_mapping('i', '<C-;>', 'Should accept')
    
    print("\nChecking Normal Mode:")
    check_mapping('n', '<C-y>', 'Should submit')
    check_mapping('n', 'q', 'Should close')
    check_mapping('n', '<C-x>', 'Should reset')
    
    -- Test if we can actually type without submitting
    print("\n\nManual Test Instructions:")
    print("1. Type some text and press Enter - it should NOT submit")
    print("2. Press Ctrl-Y - it SHOULD submit")
    print("3. Press Tab - it should insert a tab character")
    print("4. Press Ctrl-C in insert mode - it should close the chat")
    print("\nUse :messages to see this output again")
  end, 500)
end

-- Create command for easy testing
vim.api.nvim_create_user_command('TestCopilotKeys', function()
  M.test_copilot_chat()
end, { desc = "Test CopilotChat keybindings" })

-- Also create a function to manually fix bindings if needed
function M.fix_copilot_bindings()
  local chat_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "copilot-chat" then
      chat_buf = buf
      break
    end
  end
  
  if not chat_buf then
    print("CopilotChat buffer not found!")
    return
  end
  
  -- List available commands
  print("\nAvailable CopilotChat commands:")
  local commands = vim.api.nvim_get_commands({})
  for cmd, _ in pairs(commands) do
    if cmd:match("^CopilotChat") then
      print("  " .. cmd)
    end
  end
  
  -- Force our keybindings - try different approaches
  -- Method 1: Direct buffer keymaps
  vim.api.nvim_buf_set_keymap(chat_buf, 'i', '<CR>', '<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(chat_buf, 'n', '<C-y>', ':q<CR>', { noremap = true, silent = true })
  
  -- Method 2: Use vim.keymap.set with buffer option
  vim.keymap.set('i', '<C-y>', function()
    -- Find the submit button or command
    vim.cmd('stopinsert')
    -- Try different ways to submit
    local ok1 = pcall(vim.cmd, 'CopilotChatSubmit')
    if not ok1 then
      local ok2 = pcall(vim.cmd, 'lua require("CopilotChat").submit()')
      if not ok2 then
        -- Last resort - simulate enter in normal mode
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
      end
    end
  end, { buffer = chat_buf, desc = "Submit chat" })
  
  print("CopilotChat keybindings have been fixed!")
end

vim.api.nvim_create_user_command('FixCopilotKeys', function()
  M.fix_copilot_bindings()
end, { desc = "Manually fix CopilotChat keybindings" })

return M