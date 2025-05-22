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
        codeium = 1,
      })

      -- Enhanced source setup with better formatting
      opts.sources = utils.extend_tbl(
        opts.sources,
        cmp.config.sources {
          { name = "codeium", priority = 1500, max_item_count = 3 },
          -- Keep LSP and other sources at lower priorities
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }
      )

      -- Set up formatting to show source labels ONLY at the end of suggestions
      opts.formatting = utils.extend_tbl(opts.formatting or {}, {
        format = function(entry, vim_item)
          -- Call the existing formatter with modified settings
          local format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labeldetails = false, -- Disable source labels in lspkind
            with_text = true,
            menu = {},
          })
          
          if format then
            vim_item = format(entry, vim_item)
          end
          
          -- Clean up any existing menu/source text that might be leftover
          vim_item.menu = nil
          
          -- Append source name at the end of menu item
          local source = entry.source.name
          local menu_text = ""
          
          if source == "copilot" then
            menu_text = " (Copilot)"
          elseif source == "codeium" then
            menu_text = " (Codeium)"
          elseif source == "nvim_lsp" then
            menu_text = " (LSP)"
          elseif source == "buffer" then
            menu_text = " (Buffer)"
          elseif source == "path" then
            menu_text = " (Path)"
          elseif source then
            menu_text = " (" .. source .. ")"
          end
          
          vim_item.menu = menu_text
          
          return vim_item
        end
      })

      return opts
    end,
  },
}
