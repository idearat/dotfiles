return {

  {
    "idearat/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
      providers = {
        'copilot',
        'anthropic',
      },
      anthropic = {
        api_key = os.getenv("ANTHROPIC_API_KEY"),
      },
      completion = {
        enabled = false,  -- disable Avante's completion to avoid Claude API costs
        trigger_characters = {},  -- empty to prevent automatic triggers
      },
      ui = {
        code = {
          show_language = true,
          copy_code_button = true,
          style = 'markdown',
        },
        messages = {
          show_timestamps = true,
        },
        input_window = {
          style = 'minimal',
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
        },
      },
      keymaps = {
        toggle = '<leader>aa',
        submit = '<C-s>',
        close = '<C-c>',
        clear = '<C-l>',
        switch_window = '<Tab>',
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup()
    end,
  cmd = "Codeium",
  event = "BufEnter",
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua"
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75, -- Lower debounce for faster response
          filter_disallowed = false, -- Show suggestions in more contexts
          keymap = {
            accept = "<C-l>",
            next = "<C-n>",
            prev = "<C-p>",
            dismiss = "<C-[>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true
        },
        filetypes = {
          markdown = true,
          gitcommit = true,
          gitrebase = true,
          ["."] = true,
        -- Disable in certain contexts where AI completion might not be helpful
        TelescopePrompt = false,
        help = false,
        dashboard = false,
        },
      })
    end
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

        whisper = { rec_cmd = {"sox", "-c", "1", "-d", "rec.wav", "trim", "0", "3600" }},
      })
    end
  },
}
