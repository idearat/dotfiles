-- Simpler cmdflow diagnostics integration
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

return helpers.make_builtin({
  name = "crlint",
  meta = {
    description = "Cmdflow linter (crlint)",
  },
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "rust" },
  generator = helpers.generator_factory({
    command = "crlint",
    args = { "-v", "$FILENAME" },
    to_stdin = false,
    format = "line",
    check_exit_code = function(code)
      return code <= 1
    end,
    -- Run on save and open
    runtime_condition = helpers.cache.by_bufnr(function(params)
      return true
    end),
    multiple_files = false,
    on_output = function(line, params)
      -- Skip empty lines and summary sections
      if line == "" or line:match("^===") or line:match("^%s*→") then
        return nil
      end

      -- Pattern for crlint verbose output: /path/to/file.rs:10:5 warning [no-print] Found println! macro
      local file, row, col, severity = line:match("^(.-):(%d+):(%d+)%s+(%w+)")

      if file and row and col then
        -- Extract the message part
        local message = line:match("^.-:%d+:%d+%s+%w+%s+(.*)$") or ""

        -- Skip if it's not for our current file
        if not params.bufname:match(file:gsub("^.*/", "")) then
          return nil
        end

        return {
          row = tonumber(row),
          col = tonumber(col),
          severity = severity == "error" and 1 or 2,
          message = message,
          source = "crlint",
        }
      end

      return nil
    end,
  }),
})
