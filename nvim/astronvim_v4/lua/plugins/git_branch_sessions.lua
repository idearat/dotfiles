-- function for calculating the current session name
local get_session_name = require("helpers").get_session_name

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        -- update save dirsession mapping to get the correct session name
        ["<Leader>SS"] = {
          function()
            require("resession").save(
              get_session_name(),
              { dir = "dirsession", notify = true }
            )
          end,
          desc = "Save this dirsession",
        },
        -- update load dirsession mapping to get the correct session name
        ["<Leader>S."] = {
          function()
            require("resession").load(
              get_session_name(),
              { dir = "dirsession", silence_errors = true }
            )
          end,
          desc = "Load current dirsession",
        },
      },
    },
    autocmds = {
      -- autogrp for git branch sessions
      git_branch_sessions = {
        -- auto save directory sessions on leaving
        {
          event = "VimLeavePre",
          desc = "Save git branch directory sessions on close",
          callback = function()
            -- Disable notifications during exit to prevent
            -- statusline errors
            local notify_bak = vim.notify
            vim.notify = function() end

            local ok, err = pcall(function()
              if require("astrocore.buffer").is_valid_session()
              then
                require("resession").save(
                  get_session_name(),
                  { dir = "dirsession", notify = false }
                )
              end
            end)

            -- Restore notifications
            vim.notify = notify_bak

            if not ok then
              -- Silently log error without triggering UI
              vim.api.nvim_err_writeln(
                "Session save error: " .. tostring(err)
              )
            end
          end,
        },
      },
    },
  },
}
