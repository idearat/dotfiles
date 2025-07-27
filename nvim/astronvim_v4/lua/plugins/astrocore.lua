-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 1024 * 10, lines = 20000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 2, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = false,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>

        -- seems about right balance for which-key vs responsiveness
        timeoutlen = 200,

        -- keep cursor in the middle of the screen most of the time
        -- scrolloff = 99999,

        -- allow "write" messages etc. to be visible in the status line
        cmdheight = 1,

        -- allow moving between buffers without saving
        hidden = true,

        -- hard wrap
        textwidth = 80,
        wrapmargin = 0,
        colorcolumn = "81",

        formatexpr = "",
        -- note often overridden by ft plugins. use :verbose set formatoptions
        -- to see where it's being set
        formatoptions = "tjcroq",

        -- soft wrap
        -- wrap = true,
        -- linebreak = true,
        -- breakindent = true,
        -- showbreak = "↳ ",

        -- visual extras
        relativenumber = false,
        number = true,
        list = false,
        spell = false,
        signcolumn = "auto",
        wrap = false,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        foldenable = false,
        -- foldmethod = "expr",
        -- foldexpr = "nvim_treesitter#foldexpr()",
        foldlevelstart = 99,
        foldlevel = 99,
        conceallevel = 2, -- must be at least 1 for Obsidian ui features.

        confirm = true,
        moonflyTransparent = 1,
        mapleader = " ",
        maplocalleader = ",",
        diagnostics_mode = 2, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- (ss) rely on mappings.lua for all mappings here.
    },
  },
}
