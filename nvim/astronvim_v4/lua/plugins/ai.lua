return {
  -- This thing is just too darn buggy. I'm not going to use it.
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   lazy = true,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   opts = {
  --     api_key_cmd = "op read op://Personal/openai_api_neovim/key --no-newline",
  --     extra_curl_params = {
  --       "-H",
  --       "User-Agent: ChatGPT.nvim",
  --     },
  --     openai_params = {
  --       model = "gpt-4",
  --       frequency_penalty = 0,
  --       presence_penalty = 0,
  --       max_tokens = 500,
  --       temperature = 0,
  --       top_p = 1,
  --       n = 1,
  --     },
  --   },
  -- },

  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function ()
      require("codeium").setup {
      }
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua"
    },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "robitx/gp.nvim",
    config = function(_, opts)
      local gp = require("gp")

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

      gp.setup({
        -- NOTE this is more secure but fails when behind Cisco VPN
        -- openai_api_key = {
        --   "op",
        --   "read",
        --   "op://Personal/openai_api_neovim/key",
        -- },
        openai_api_key = os.getenv("OPENAI_API_KEY"),

        chat_user_prefix = "🗨:",
        chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>r" },
	      chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>d" },
	      chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<localleader>s" },
	      chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cc" },

        toggle_target = "split",

        whisper_rec_cmd = { "sox", "-c", "1", "-d", "rec.wav", "trim", "0", "3600" },
      })
    end
  },
}
