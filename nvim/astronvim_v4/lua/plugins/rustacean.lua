-- Rustacean.vim configuration
return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended to use a stable version
  ft = { "rust" },
  config = function()
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        hover_actions = {
          auto_focus = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "◂ ",
          other_hints_prefix = "▸ ",
        },
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- Use AstroNvim's on_attach if available
          if require("astrolsp").on_attach then
            require("astrolsp").on_attach(client, bufnr)
          end
          
          -- Add rustacean-specific keymaps
          local map = vim.keymap.set
          local opts = { buffer = bufnr, silent = true }
          
          -- Rustacean.vim specific mappings
          map("n", "<leader>lc", function() vim.cmd.RustLsp("openCargo") end, { desc = "Open Cargo.toml", buffer = bufnr })
          map("n", "<leader>lR", function() vim.cmd.RustLsp("runnables") end, { desc = "Rust Runnables", buffer = bufnr })
          map("n", "<leader>lD", function() vim.cmd.RustLsp("debuggables") end, { desc = "Rust Debuggables", buffer = bufnr })
          map("n", "<leader>le", function() vim.cmd.RustLsp("explainError") end, { desc = "Explain Error", buffer = bufnr })
          map("n", "<leader>lE", function() vim.cmd.RustLsp("expandMacro") end, { desc = "Expand Macro", buffer = bufnr })
          map("n", "<leader>lm", function() vim.cmd.RustLsp("rebuildProcMacros") end, { desc = "Rebuild Proc Macros", buffer = bufnr })
          map("n", "<leader>lr", function() 
            -- Save file first
            vim.cmd("silent! write")
            
            -- Force complete diagnostic refresh
            vim.schedule(function()
              -- Hide all diagnostics
              vim.diagnostic.hide(nil, bufnr)
              
              -- Clear the diagnostic cache
              vim.diagnostic.reset(nil, bufnr)
              
              -- Force sign column refresh
              vim.cmd("sign unplace * buffer=" .. bufnr)
              
              -- Run clippy
              vim.cmd.RustLsp("flyCheck")
              
              -- After a delay, force show diagnostics
              vim.defer_fn(function()
                vim.diagnostic.show(nil, bufnr)
                -- Force complete redraw
                vim.cmd("redraw!")
              end, 500)
            end)
            
          end, { desc = "Refresh Rust diagnostics", buffer = bufnr })
          
        end,
        settings = {
          -- rust-analyzer settings
          ["rust-analyzer"] = {
            -- enable clippy on save AND on open
            checkOnSave = true,
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            -- Run clippy when opening files too
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
              disabled = { "unresolved-proc-macro" },
            },
            -- Workspace loading configuration to trigger checks on open
            workspace = {
              symbol = {
                search = {
                  kind = "all_symbols",
                },
              },
            },
            -- Trigger initial diagnostics when loading
            initialDiagnostics = true,
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            procMacro = {
              enable = true,
              attributes = {
                enable = true,
              },
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
      -- DAP configuration for debugging
      dap = {
        adapter = {
          type = "server",
          port = "${port}",
          executable = {
            command = codelldb_path,
            args = { "--port", "${port}" },
          },
        },
      },
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
}