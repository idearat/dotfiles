local M = {}

function M.format_comment()
  -- Get the current visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  
  -- Get the lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  
  if #lines == 0 then return end
  
  -- Check if first line is a comment
  local first_line = lines[1]
  local indent = first_line:match("^(%s*)") or ""
  
  if not first_line:match("^%s*//") then
    -- Not a comment, just use normal gq
    vim.cmd("normal! gvgq")
    return
  end
  
  -- Process comment lines
  local text_parts = {}
  for _, line in ipairs(lines) do
    local content = line:gsub("^%s*//+%s*", ""):gsub("^%s+", ""):gsub("%s+$", "")
    if content ~= "" then
      table.insert(text_parts, content)
    end
  end
  
  local joined = table.concat(text_parts, " ")
  
  -- Calculate wrap width
  local tw = vim.bo.textwidth > 0 and vim.bo.textwidth or 80
  local prefix = indent .. "// "
  local wrap_width = tw - #prefix
  
  if wrap_width < 20 then wrap_width = 20 end
  
  -- Wrap text
  local result = {}
  local current = ""
  
  for word in joined:gmatch("%S+") do
    if current == "" then
      current = word
    elseif #current + 1 + #word <= wrap_width then
      current = current .. " " .. word
    else
      table.insert(result, prefix .. current)
      current = word
    end
  end
  
  if current ~= "" then
    table.insert(result, prefix .. current)
  end
  
  -- Replace the lines
  if #result > 0 then
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
  end
end

return M