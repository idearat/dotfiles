return {

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "horizontal", -- Change to horizontal layout
          height = 18, -- Fixed height of 18 lines
          width = 1, -- Take full width
        },
        -- Simple setup with default keymaps
      })
    end,
  },

  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        enable_chat = false,
        disable_bindings = true, -- Don't use default keybindings
      })
      -- Don't try to manually register the source - it's done automatically
    end,
    event = {"InsertEnter", "BufEnter"}, -- Load during insert mode and buffer enter
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter" },
    config = function()
      -- Configure using minimal settings - we'll let copilot-cmp handle the integration
      require("copilot").setup({
        suggestion = { enabled = false },  -- Disable native suggestions as we'll use copilot-cmp
        panel = { enabled = false },  -- We're using CopilotChat instead
        filetypes = {
          markdown = true,
          gitcommit = true,
          ["*"] = true,
          TelescopePrompt = false,
          help = false,
          lazy = false,
          dashboard = false,
        },
      })
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- Setup copilot-cmp - direct approach that doesn't rely on auto-loading
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup({
        method = "getCompletionsCycling",
        formatters = {
          label = require("copilot_cmp.format").format_label_text,
          insert_text = require("copilot_cmp.format").format_insert_text,
          preview = require("copilot_cmp.format").deindent,
        },
      })
    end,
    event = {"InsertEnter", "LspAttach"}, -- Load during both insert mode and when LSP attaches
  },

  {
    "robitx/gp.nvim",
    config = function(_, opts)
      local gp = require "gp"

      -- NOTE: this is a slot directly on gp, not in opts :(
      gp.chat_template = [[
# topic: ?

- file: %s
%s
Write queries after %s using standard Vim commands.

Use `%s` or :%sChatRespond to generate a response.
Stop generation via `%s` or :%sChatStop command.

Chats are saved automatically.
To delete, use `%s` or :%sChatDelete.

Be cautious of long chats.
Start fresh using `%s` or :%sChatNew.

---

%s]]

      gp.setup {
        -- NOTE this is more secure but fails when behind Cisco VPN
        -- openai_api_key = {
        --   "op",
        --   "read",
        --   "op://Personal/openai_api_neovim/key",
        -- },
        openai_api_key = os.getenv "OPENAI_API_KEY",

        chat_user_prefix = "🗨:",
        chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>r" },
        chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>d" },
        chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>s" },
        chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cc" },

        toggle_target = "split",

        whisper = { rec_cmd = { "sox", "-c", "1", "-d", "rec.wav", "trim", "0", "3600" } },
      }
    end,
  },

}
