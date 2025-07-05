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

      -- AI-only completion sources
      opts.sources = cmp.config.sources({
        { name = "codeium", priority = 2000, max_item_count = 5 },
        { name = "copilot", priority = 1000, max_item_count = 5 },
      })

      -- Simple, clean mappings for AI completions
      opts.mapping = {
        ["<C-l>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Esc>"] = cmp.mapping(function(fallback)
          cmp.close()
          vim.cmd("stopinsert")  -- Exit insert mode immediately
        end),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = function(fallback)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
        end,
      }

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
