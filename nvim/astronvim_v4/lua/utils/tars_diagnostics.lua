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
    args = { "check", "--no-color", "$FILENAME" },
    to_stdin = false,
    format = "line",
    check_exit_code = function(code)
      return code <= 1
    end,
    runtime_condition = function(params)
      return vim.bo[params.bufnr].filetype == "crux"
    end,
    on_output = helpers.diagnostics.from_pattern(
      [[:(%d+):(%d+) (%w+) (.+)]],
      { "row", "col", "severity", "message" },
      {
        severities = {
          error = helpers.diagnostics.severities.error,
          warning = helpers.diagnostics.severities.warning,
        },
      }
    ),
  }),
})
