-- rose-pine main color palette
local palette = {
	_nc = "#16141f",
	base = "#191724",
	surface = "#1f1d2e",
	overlay = "#26233a",
	muted = "#6e6a86",
	subtle = "#908caa",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight_low = "#21202e",
	highlight_med = "#403d52",
	highlight_high = "#524f67",
	none = "NONE",
}

return {
    "rose-pine/neovim",
    name="rose-pine",
    opts = {
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
      },

      styles = {
          bold = true,
          italic = true,
          transparency = false,
      },

      groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
      },

      highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        Normal = { bg = "#000000" },
        NormalNC = { bg = "#000000" },

        CursorLine = { bg = palette.highlight_med, blend=0 },

        FloatBorder = { bg = "#000000", fg = palette.gold, blend=0 },
        TelescopeBorder = { bg = "#000000", fg = palette.gold, blend=0 },

        TelescopeSelectionCaret = { bg = "#000000", fg = palette.gold, blend=0 },
        TelescopeSelection = { bg = "#000000", fg = palette.gold, blend=20 },
        TelescopeMatching = { bg = "#000000", fg = palette.love, blend=20 },

        TelescopePreviewLine = { fg = "#000000", bg = palette.love, blend=20 },
        TelescopeResultsLineNr = { fg = "#000000", bg = palette.love, blend=20 },

        ChatGPTTotalTokens= { bg = "#000000", fg = palette.gold, blend=0 },
        ChatGPTTotalTokensBorder = { bg = "#000000", fg = palette.gold, blend=0 },

        LazyGitBorder = { bg = "#000000", fg = palette.gold, blend=0 }
        -- LazyGitFloat = { bg = palette.none, fg = palette.text, blend=0 },
      },
    },
}
