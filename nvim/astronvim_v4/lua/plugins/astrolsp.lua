-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local telescope = require("telescope")
local ui = require("astroui")

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = false, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      rust_analyzer = false, -- Let rustacean.vim handle rust_analyzer
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then
              vim.lsp.codelens.refresh { bufnr = args.buf }
            end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {

        -- LOWERCASE
        g = { "g", desc = "Go Operator" },
        s = { "<Plug>(leap-forward-to)", desc = "Leap Ahead To chch ³" },

        -- UPPERCASE
        K = { function() vim.lsp.buf.hover() end, desc = "Keyword Help ³" },
        S = { "<Plug>(leap-backward-to)", desc = "Reverse s ³" },

        -- SYMBOLS
        -- fix up description so it's not just 'prefix' in which-key
        ["["] = { desc = "Previous n {...} ¹" },
        ["]"] = { desc = "Next n {...} ¹" },

        ["<C-q>"] = false, -- unmap AstroNvim's save & quit
        ["<C-s>"] = { ":w!<cr>", desc = "Save! File ³" },

        -- TODO: remappable
        ["<C-x>"] = false, -- unmap AstroNvim's save & quit

        ["<C-/>"] = { function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find In Buffer ³" },

        -- disable AstroNvim mapping to allow tab traversals to work
        ["gT"] = false,

        ["<Leader>c"] = { "<Leader>c", desc = ui.get_icon("DiagnosticHint", 1, true) .. "CmdFlow Menu" },
        ["<Leader>l"] = { "<Leader>l", desc = ui.get_icon("ActiveLSP", 1, true) .. "LSP Menu" },
        ["<Leader>u"] = { "<Leader>u", desc = ui.get_icon("Window", 1, true) .. "UI Menu" },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      
      -- TypeScript formatexpr is now handled by custom ftplugin files
    end,
  },
}
