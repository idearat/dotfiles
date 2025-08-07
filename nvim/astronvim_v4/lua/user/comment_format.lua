local M = {}

-- Helper function to wrap text at specified width
local function wrap_text(text, width)
  local lines = {}
  local current_line = ""
  
  for word in text:gmatch("%S+") do
    if current_line == "" then
      current_line = word
    elseif #current_line + 1 + #word <= width then
      current_line = current_line .. " " .. word
    else
      table.insert(lines, current_line)
      current_line = word
    end
  end
  
  if current_line ~= "" then
    table.insert(lines, current_line)
  end
  
  return lines
end

-- Format JSDoc/block comments
local function format_jsdoc(lines, indent)
  local tw = vim.bo.textwidth > 0 and vim.bo.textwidth or 80
  local prefix = indent .. " * "
  local width = tw - #prefix
  if width < 30 then width = 30 end
  
  local result = {indent .. "/**"}
  
  -- Process lines inside the comment
  for i = 2, #lines - 1 do
    local line = lines[i]
    -- Remove leading whitespace and * 
    local content = line:gsub("^%s*%*%s?", "")
    
    -- Check if this is a JSDoc tag line
    if content:match("^@%w+") then
      -- This is a JSDoc tag - format it specially
      local tag, rest = content:match("^(@%w+)%s*(.*)")
      if tag and rest and rest ~= "" then
        -- Wrap the description part if it's long
        if #tag + 1 + #rest > width then
          table.insert(result, prefix .. tag)
          local wrapped = wrap_text(rest, width)
          for _, wline in ipairs(wrapped) do
            table.insert(result, prefix .. "  " .. wline)
          end
        else
          table.insert(result, prefix .. content)
        end
      else
        table.insert(result, prefix .. content)
      end
    elseif content == "" then
      -- Preserve empty lines
      table.insert(result, prefix)
    else
      -- Regular text - wrap it
      local wrapped = wrap_text(content, width)
      for _, wline in ipairs(wrapped) do
        table.insert(result, prefix .. wline)
      end
    end
  end
  
  table.insert(result, indent .. " */")
  return result
end

function M.format()
  -- Save current position
  local save_cursor = vim.fn.getpos(".")
  
  -- Get visual selection range
  local vstart = vim.fn.getpos("'<")
  local vend = vim.fn.getpos("'>")
  local start_line = vstart[2]
  local end_line = vend[2]
  
  -- Get lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then return end
  
  -- Check first line for comment type
  local first = lines[1]
  local indent = first:match("^(%s*)") or ""
  
  -- Check for JSDoc/block comment
  if first:match("^%s*/%*%*") then
    -- Format JSDoc comment
    local result = format_jsdoc(lines, indent)
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
  elseif first:match("^%s*//") then
    -- Format single-line comment (original logic)
    -- Extract text from all lines
    local parts = {}
    for _, line in ipairs(lines) do
      -- Strip indent and comment markers
      local text = line:gsub("^%s*//+%s*", "")
      if text ~= "" then
        table.insert(parts, text)
      end
    end
    
    if #parts == 0 then return end
    
    -- Join all text
    local text = table.concat(parts, " ")
    
    -- Calculate line width
    local tw = vim.bo.textwidth
    if tw == 0 then tw = 80 end
    
    local prefix = indent .. "// "
    local width = tw - #prefix
    if width < 30 then width = 30 end
    
    -- Split into words and rewrap
    local result = {}
    local line = ""
    
    for word in text:gmatch("%S+") do
      if line == "" then
        line = word
      elseif #line + 1 + #word <= width then
        line = line .. " " .. word
      else
        table.insert(result, prefix .. line)
        line = word
      end
    end
    
    -- Add last line
    if line ~= "" then
      table.insert(result, prefix .. line)
    end
    
    -- Replace original lines
    if #result > 0 then
      vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
    end
  else
    -- Not a comment - use normal gq
    vim.cmd("'<,'>normal! gq")
    return
  end
  
  -- Restore cursor
  vim.fn.setpos(".", save_cursor)
end

-- Setup function to add the mapping
function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {"typescript", "typescriptreact", "javascript", "javascriptreact"},
    callback = function()
      vim.keymap.set("x", "gq", ":<C-u>lua require('user.comment_format').format()<CR>", 
        { buffer = true, silent = true, desc = "Format comment" })
    end
  })
end

return M