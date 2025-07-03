-- ---
-- Helper functions
-- ---

local get_session_name = require("helpers").get_session_name

--- Create a button for the alpha window
--- @param sc string
--- @param txt string
--- @param keybind? ( string | function )
--- @param keybind_opts table?
--- @param opts table?
--- @return table
local function button(sc, txt, keybind, keybind_opts, opts)
  local on_press = nil
  local def_opts = {
    cursor = 3,
    align_shortcut = "right",
    hl_shortcut = "AlphaButtonShortcut",
    hl = "AlphaButton",
    width = 35,
    position = "center",
  }
  opts = opts and vim.tbl_extend("force", def_opts, opts) or def_opts
  opts.shortcut = sc
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<space>")
  if type(keybind) == "function" then
    on_press = keybind
  else
      on_press = function()
      local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end
    if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
      opts.keymap = { "n", sc_, keybind, keybind_opts }
    end
  end
  return { type = "button", val = txt, on_press = on_press, opts = opts }
end


local function load_last_session()
  require("resession").load(
    get_session_name(),
    { dir = "dirsession", reset = true, silence_errors = true }
  )
end


-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local fortune = require "alpha.fortune"
      local get_icon = require("astroui").get_icon

      opts.section.header.val = {
[[                        .           ]],
[[                       .:.          ]],
[[                     .:::::.        ]],
[[                    .:::::::.       ]],
[[                     .:::::.        ]],
[[                      :::::         ]],
[[                     .:::::.        ]],
[[          _         .:::::::.       ]],
[[        :@%@:        .:::::.        ]],
[[      .@@@%@@@.       :::::         ]],
[[       .@@%@@.       .:::::.        ]],
[[      =:#@%@#:=       :::::         ]],
[[        -@%@-        .:::::.        ]],
[[        :@%@:        :::::::        ]],
[[        :@%@:       .:::::::.       ]],
[[       :@@%@@:     .:::::::::.      ]],
[[      .%@%%%@%.   .:::::::::::.     ]],
[[     .%@%%%%%@%. :::::::::::::::.   ]],
[[     %@@%%%%%@@%-::::::::::::::::   ]],
[[   :@@@%%%%%%%@@@:--------``        ]],
[[   @@@%%%%%%%%%@@@---``             ]],
      }

      opts.section.buttons.val = {
        button("s", get_icon("Refresh", 2, true) .. "Session  ", load_last_session),
        button("r", get_icon("DefaultFile", 2, true) .. "Recents  ", ":Telescope oldfiles<cr>"),
        button("n", get_icon("FileNew", 2, true) .. "New File  ", ":ene <bar> startinsert <cr>"),
      }

      -- local quote = table.concat(fortune(), "\n")
      local quote = fortune()
      opts.section.quotation = { type = "text", val = quote, opts = { position = "center", width = 35 } }


      -- Customize the layout, leaving out 'footer'. If footer EXISTS, no matter
      -- what you set it to, AstroNvim will flush it and put in it's own footer.
      opts.config.layout = {
        { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.1) } },
        opts.section.header,
        { type = "padding", val = 3 },
        opts.section.buttons,
        { type = "padding", val = 2 },
        opts.section.quotation,
      }

      -- Customize the colorscheme. Note the button colors are set in the
      -- `button` function above.
      opts.section.header.opts.hl = "AlphaHeader"
      opts.section.quotation.opts.hl = "AlphaQuote"

      opts.opts.noautocmd = true

      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "RRethy/vim-illuminate", enabled = false },
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  --
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(
  --             cond.not_after_regex "%%"
  --           )
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(
  --             cond.not_after_regex "xx"
  --           )
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
}
