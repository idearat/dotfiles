-- Check if there are words before the cursor. Used by the cmp plugin to control
-- how to handle things like Tab/Shift-Tab when no chars precede insert point.
local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local utils = require "astrocore"

      opts.mapping = utils.extend_tbl(opts.mapping, {
        ["<Tab>"] = { i = cmp.config.disable, s = cmp.config.disable, c = cmp.config.disable },
        ["<S-Tab>"] = { i = cmp.config.disable, s = cmp.config.disable, c = cmp.config.disable },
        ["<CR>"] = { i = cmp.config.disable, s = cmp.config.disable, c = cmp.config.disable },
        -- NOTE: matches bindkey ^y for consistency with zsh autocompletion.
        -- and with iTerm2 mapping C-CR to send 0x19 we can use C-CR in vim.
        ["<C-y>"] = cmp.mapping.confirm { select = false },
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        
        -- Add explicit Escape key handling to ensure it closes the completion menu
        -- and exits insert mode immediately with a single press
        ["<Esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
            -- Force exit insert mode after closing completion menu
            vim.cmd([[call feedkeys("\<Esc>", 'n')]])
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.duplicates = utils.extend_tbl(opts.duplicates, {
        copilot = 1,
        codeium = 1,
      })

      opts.sources = utils.extend_tbl(
        opts.sources,
        cmp.config.sources {
          { name = "copilot", priority = 1500 },
          { name = "codeium", priority = 1250 },
        }
      )

      return opts
    end,
  },
}
