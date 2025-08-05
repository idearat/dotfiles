return {
  {
    "folke/which-key.nvim",
    opts = function(opts)
      local utils = require "astrocore"
      opts = utils.extend_tbl(opts, {
        preset = "classic",
        delay = 1000,
        timeout = 0, -- Disable timeout completely
        triggers = {
          { "<auto>", mode = "nxsot" }, -- Add loop to auto triggers
        },
        defer = function(ctx)
          return false -- Never auto-close, force manual Esc
        end,
        icons = {
          breadcrumb = "",
          separator = "",
          group = "",
          ellipsis = "...",
          mappings = false, -- No icons at all
        },
        layout = {
        },
        win = {
          border = "single",
          no_overlap = true,
          width = { min = 20 },
          height = { min = 4, max = 50 }, -- Even taller max
          padding = { 2, 4 }, -- More padding for better spacing
          title = false, -- No title bar
          wo = {
            winblend = 5, -- More opaque (less transparent)
          },
        },
        keys = {
          scroll_down = "<C-d>",
          scroll_up = "<C-u>",
          -- Also try these alternative keys
          -- ["<C-f>"] = "scroll_down",
          -- ["<C-b>"] = "scroll_up",
          -- ["<PageDown>"] = "scroll_down",
          -- ["<PageUp>"] = "scroll_up",
        },
        sort = { "alphanum" },
        filter = function(mapping)
          return true
        end,
      })
      return opts
    end,
    config = function(_, opts)
      require("which-key").setup(opts)

      -- Debug WhichKey window detection
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "WinEnter" }, {
        callback = function(event)
          local buf = event.buf
          local ft = vim.bo[buf].filetype
          -- Check various patterns for WhichKey windows
          if ft == "WhichKey" or ft == "which-key" or ft == "whichkey" then
            print("WhichKey window detected, filetype: " .. ft)
            -- Force enable scrolling
            local win = vim.api.nvim_get_current_win()
            vim.wo[win].scrolloff = 0
            vim.wo[win].sidescrolloff = 0

            -- Set buffer-local mappings that should work
            local opts = { buffer = buf, nowait = true, noremap = false }
            vim.keymap.set("n", "j", function() vim.cmd("normal! j") end, opts)
            vim.keymap.set("n", "k", function() vim.cmd("normal! k") end, opts)
            vim.keymap.set("n", "<C-d>", function() vim.cmd("normal! <C-d>") end, opts)
            vim.keymap.set("n", "<C-u>", function() vim.cmd("normal! <C-u>") end, opts)
          end
        end,
      })

      -- Hook into WhichKey's show event directly
      local wk = require("which-key")
      local original_show = wk.show

      wk.show = function(...)
        local result = original_show(...)

        -- After WhichKey opens, try to fix scrolling
        vim.defer_fn(function()
          -- Find the WhichKey window
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local win_config = vim.api.nvim_win_get_config(win)

            -- Check if it's a floating window (WhichKey uses floating windows)
            if win_config.relative ~= "" then
              print("Found WhichKey floating window, trying to enable scrolling...")

              -- Force scrolling to work in this window
              vim.api.nvim_win_call(win, function()
                -- Override WhichKey's key handling
                local map_opts = { buffer = buf, nowait = true, silent = true, expr = false }

                -- Use feedkeys to bypass WhichKey's event handling
                vim.keymap.set("n", "j", function()
                  vim.api.nvim_feedkeys("j", "n", false)
                end, map_opts)
                vim.keymap.set("n", "k", function()
                  vim.api.nvim_feedkeys("k", "n", false)
                end, map_opts)
                vim.keymap.set("n", "<C-d>", function()
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", false)
                end, map_opts)
                vim.keymap.set("n", "<C-u>", function()
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-u>", true, false, true), "n", false)
                end, map_opts)
              end)
            end
          end
        end, 100)

        return result
      end

      -- Clean grayscale theme - darker background closer to black
      vim.cmd([[
        highlight WhichKeyFloat guibg=#1a1a1a guifg=#d0d0d0
        highlight WhichKeyBorder guibg=#1a1a1a guifg=#808080
        highlight WhichKeyNormal guibg=#1a1a1a guifg=#d0d0d0
        highlight WhichKeyDesc guifg=#a0a0a0
        highlight WhichKeyGroup guifg=#808080
        highlight WhichKeySeparator guifg=#606060
        highlight WhichKeyValue guifg=#c0c0c0
      ]])
    end,
  },
}
