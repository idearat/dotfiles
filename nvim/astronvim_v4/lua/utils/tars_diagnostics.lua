-- TARS diagnostics integration for CR:UX files
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

return helpers.make_builtin({
  name = "tars",
  meta = {
    description = "TARS linter for CR:UX",
  },
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "crux" },
  generator = helpers.generator_factory({
    command = "tars",
    args = function(params)
      return { "check", "--lsp", params.bufname }
    end,
    to_stdin = false,
    format = "line",
    check_exit_code = function(code)
      return code <= 1
    end,
    runtime_condition = function(params)
      return vim.bo[params.bufnr].filetype == "crux"
    end,
    on_output = function(line, params)
      -- Debug: log first few lines
      local logfile = io.open("/tmp/tars-diag.log", "a")
      if logfile then
        logfile:write("LINE: " .. line .. "\n")
        logfile:close()
      end

      -- Parse: filename:line:col severity message [code]
      local row, col, severity, msg, code =
        line:match(".-:(%d+):(%d+) (%w+) (.+) %[([^%]]+)%]")

      if not row then
        if logfile then
          logfile = io.open("/tmp/tars-diag.log", "a")
          logfile:write("  NO MATCH\n")
          logfile:close()
        end
        return nil
      end

      local sev_map = {
        error = vim.diagnostic.severity.ERROR,
        warning = vim.diagnostic.severity.WARN,
        info = vim.diagnostic.severity.INFO,
      }

      -- Skip file-level diagnostics with 0:0 position (TARS bug)
      if row == "0" and col == "0" then
        return nil
      end

      local diag = {
        row = tonumber(row),  -- null-ls expects 1-indexed
        col = tonumber(col),  -- null-ls expects 1-indexed
        message = msg,
        severity = sev_map[severity] or sev_map.error,
        code = code,
        source = "tars",
      }

      if logfile then
        logfile = io.open("/tmp/tars-diag.log", "a")
        logfile:write(string.format("  DIAG: row=%d col=%d sev=%s\n",
          diag.row, diag.col, severity))
        logfile:close()
      end

      return diag
    end,
  }),
})
