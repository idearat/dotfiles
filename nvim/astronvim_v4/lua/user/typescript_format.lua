local M = {}

-- Custom format function for TypeScript/JavaScript comments
function M.format_typescript()
  -- Handle both visual mode and normal mode operator
  local mode = vim.fn.mode()
  local start_line, end_line
  
  if mode == 'v' or mode == 'V' then
    -- Visual mode - get the actual selection
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  else
    -- Normal mode with operator (gq{motion})
    start_line = vim.v.lnum
    end_line = start_line + vim.v.count - 1
  end
  
  -- Get the lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  
  if #lines == 0 then return 1 end
  
  -- Detect the comment style and indentation
  local first_line = lines[1]
  local indent = first_line:match("^(%s*)") or ""
  
  -- Check if this is a comment line
  if not first_line:match("^%s*//") then
    -- Not a comment, use default formatting
    return 1
  end
  
  -- Single-line comment formatting
  -- Join all lines, preserving only the first comment marker
  local text_parts = {}
  for _, line in ipairs(lines) do
    -- Remove leading whitespace and comment markers
    local content = line:gsub("^%s*//+%s*", "")
    if content ~= "" then
      table.insert(text_parts, content)
    end
  end
  
  -- Join with spaces
  local joined = table.concat(text_parts, " ")
  
  -- Wrap the text at textwidth (or 80 if not set)
  local tw = vim.bo.textwidth > 0 and vim.bo.textwidth or 80
  local prefix = indent .. "// "
  local prefix_len = #prefix
  local wrap_width = math.max(tw - prefix_len, 20) -- Ensure minimum wrap width
  
  -- Word wrapping with proper line breaks
  local wrapped = {}
  local words = {}
  for word in joined:gmatch("%S+") do
    table.insert(words, word)
  end
  
  local current_line = ""
  for _, word in ipairs(words) do
    local test_line = current_line == "" and word or (current_line .. " " .. word)
    
    if #test_line <= wrap_width then
      current_line = test_line
    else
      if current_line ~= "" then
        table.insert(wrapped, prefix .. current_line)
      end
      current_line = word
    end
  end
  
  -- Add the last line
  if current_line ~= "" then
    table.insert(wrapped, prefix .. current_line)
  end
  
  -- If we have wrapped lines, replace the original
  if #wrapped > 0 then
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, wrapped)
  end
  
  return 0 -- We handled the formatting
end

return M