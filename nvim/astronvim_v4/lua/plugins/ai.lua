return {
  -- CopilotChat for AI conversations
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- CopilotChat needs copilot.lua
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Build tiktoken for better tokenization
    opts = {
      model = "claude-3.5-sonnet",  -- Available with Copilot Pro
      temperature = 0.1,
      
      -- UI configuration
      window = {
        layout = "float",
        width = 0.8,
        height = 0.8,
        relative = "editor",
        border = "rounded",
      },
      
      -- Automatically save conversations
      auto_insert_mode = true,
      show_help = false,
      
      -- System prompts
      system_prompt = [[You are an AI programming assistant integrated into Neovim.
Be concise but thorough. Format code with markdown code blocks.
When asked about the current file, analyze the context carefully.]],
      
      -- Based on the wiki examples, mappings should be like this:
      mappings = {
        close = {
          normal = "q",
          insert = "<C-c>"
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>"
        },
        submit_prompt = {
          normal = "<C-y>",  -- Use C-y in normal mode too
          insert = "<C-y>"   -- Your iTerm2 C-Enter -> C-y mapping
        },
        accept_diff = {
          normal = "ga",  -- Accept diff in normal mode
          insert = nil    -- No insert mode mapping for diffs
        },
        yank_diff = {
          normal = "gy",
          register = '"',
        },
        show_diff = {
          normal = "gd"
        },
        show_system_prompt = {
          normal = "gp"
        },
        show_user_selection = {
          normal = "gs"
        },
      },
    },
    -- No keys defined here - all in mappings.lua
    config = function(_, opts)
      local chat = require("CopilotChat")
      
      -- Auto-create save directory
      local save_dir = vim.fn.expand("~/.local/share/nvim/CopilotChat")
      if vim.fn.isdirectory(save_dir) == 0 then
        vim.fn.mkdir(save_dir, "p")
      end
      
      -- Don't override mappings in on_open - let the config handle it
      
      -- Add custom commands (no keybindings)
      vim.api.nvim_create_user_command("CopilotChatBuffer", function()
        chat.ask("Explain this file", { selection = require("CopilotChat.select").buffer })
      end, { desc = "AI explain current buffer" })
      
      vim.api.nvim_create_user_command("CopilotChatCommit", function()
        chat.ask("Write a commit message for these changes", { selection = require("CopilotChat.select").gitdiff })
      end, { desc = "AI write commit message" })
      
      chat.setup(opts)
    end,
  },

  -- Copilot.lua for AI completion backend
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { 
          enabled = false,
          auto_trigger = false,
        },
        panel = { 
          enabled = false,
        },
        filetypes = {
          markdown = true,
          gitcommit = true,
          ["*"] = true,
        },
      })
      
      -- Make absolutely sure ghost text is disabled
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Also disable after a delay to be sure
      vim.defer_fn(function()
        pcall(function()
          require("copilot.suggestion").toggle(false)
        end)
      end, 500)
    end,
  },

  -- Copilot-cmp for nvim-cmp integration
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Keep Codeium as secondary option
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- Set vim globals BEFORE setup
      vim.g.codeium_no_map_tab = 1
      vim.g.codeium_disable_bindings = 1
      
      require("codeium").setup({
        enable_chat = false,
        disable_bindings = true, -- Don't use default keybindings
      })
      
      -- Double-check after setup
      vim.defer_fn(function()
        vim.g.codeium_no_map_tab = 1
        vim.g.codeium_disable_bindings = 1
      end, 100)
    end,
    event = "InsertEnter", -- Load only on insert mode for better performance
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = { "InsertEnter" },
  --   config = function()
  --     -- Configure using minimal settings - we'll let copilot-cmp handle the integration
  --     require("copilot").setup({
  --       suggestion = { enabled = false },  -- Disable native suggestions as we'll use copilot-cmp
  --       panel = { enabled = false },  -- We're using CopilotChat instead
  --       filetypes = {
  --         markdown = true,
  --         gitcommit = true,
  --         ["*"] = true,
  --         TelescopePrompt = false,
  --         help = false,
  --         lazy = false,
  --         dashboard = false,
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = {
  --     "zbirenbaum/copilot.lua",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     -- Setup copilot-cmp - direct approach that doesn't rely on auto-loading
  --     local copilot_cmp = require("copilot_cmp")
  --     copilot_cmp.setup({
  --       method = "getCompletionsCycling",
  --       formatters = {
  --         label = require("copilot_cmp.format").format_label_text,
  --         insert_text = require("copilot_cmp.format").format_insert_text,
  --         preview = require("copilot_cmp.format").deindent,
  --       },
  --     })
  --   end,
  --   event = {"InsertEnter", "LspAttach"}, -- Load during both insert mode and when LSP attaches
  -- },

--   {
--     "robitx/gp.nvim",
--     config = function(_, opts)
--       local gp = require "gp"
--
--       -- NOTE: this is a slot directly on gp, not in opts :(
--       gp.chat_template = [[
-- # topic: ?
--
-- - file: %s
-- %s
-- Write queries after %s using standard Vim commands.
--
-- Use `%s` or :%sChatRespond to generate a response.
-- Stop generation via `%s` or :%sChatStop command.
--
-- Chats are saved automatically.
-- To delete, use `%s` or :%sChatDelete.
--
-- Be cautious of long chats.
-- Start fresh using `%s` or :%sChatNew.
--
-- ---
--
-- %s]]
--
--       gp.setup {
--         -- NOTE this is more secure but fails when behind Cisco VPN
--         -- openai_api_key = {
--         --   "op",
--         --   "read",
--         --   "op://Personal/openai_api_neovim/key",
--         -- },
--         openai_api_key = os.getenv "OPENAI_API_KEY",
--
--         chat_user_prefix = "🗨:",
--         chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>r" },
--         chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>d" },
--         chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>s" },
--         chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cc" },
--
--         toggle_target = "split",
--
--         whisper = { rec_cmd = { "sox", "-c", "1", "-d", "rec.wav", "trim", "0", "3600" } },
--       }
--     end,
--   },

}
