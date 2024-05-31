-- transparent backgrounds for main and floating windows
return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      groups = { -- table: default groups
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
      },
      extra_groups = {
        "FloatBorder", -- for floating windows
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
        "TelescopeBorder", -- for floating windows
        "TelescopeSelection", -- for floating windows
        "TelescopeMatching", -- for floating windows
        "ChatGPTTotalTokensBorder" -- for floating windows
      }, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    },
  },
}
