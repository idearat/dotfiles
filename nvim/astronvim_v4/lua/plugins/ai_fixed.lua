return {
  -- CopilotChat for AI conversations
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = function()
      local chat = require("CopilotChat")
      
      return {
        model = "claude-3.5-sonnet",
        temperature = 0.1,
        
        -- UI configuration
        window = {
          layout = "float",
          width = 0.8,
          height = 0.8,
          relative = "editor",
          border = "rounded",
        },
        
        auto_insert_mode = true,
        show_help = false,
        
        system_prompt = [[You are an AI programming assistant integrated into Neovim.
Be concise but thorough. Format code with markdown code blocks.
When asked about the current file, analyze the context carefully.]],
        
        -- Alternative approach: use callbacks to set up mappings
        on_open = function(bufnr)
          -- Set buffer-local keymaps directly
          local opts = { noremap = true, silent = true, buffer = bufnr }
          
          -- Submit with C-y instead of Enter
          vim.keymap.set('i', '<C-y>', function()
            -- Get current line
            local line = vim.api.nvim_get_current_line()
            if line and line ~= "" then
              -- Execute the submit command
              vim.cmd('stopinsert')
              vim.cmd('CopilotChatSubmit')
            end
          end, opts)
          
          -- Make Enter just insert a newline
          vim.keymap.set('i', '<CR>', '<CR>', opts)
          
          -- Tab should work as normal tab
          vim.keymap.set('i', '<Tab>', '<Tab>', opts)
          
          -- C-c should cancel/close
          vim.keymap.set('i', '<C-c>', function()
            vim.cmd('CopilotChatClose')
          end, opts)
          
          -- Accept diff with C-;
          vim.keymap.set('i', '<C-;>', '<Cmd>CopilotChatAccept<CR>', opts)
          vim.keymap.set('i', '<C-l>', '<Cmd>CopilotChatAccept<CR>', opts)
          
          -- Normal mode mappings
          vim.keymap.set('n', '<C-y>', '<Cmd>CopilotChatSubmit<CR>', opts)
          vim.keymap.set('n', 'q', '<Cmd>CopilotChatClose<CR>', opts)
          vim.keymap.set('n', '<C-x>', '<Cmd>CopilotChatReset<CR>', opts)
          
          -- Debug helper
          vim.keymap.set('n', '<leader>cd', function()
            print("CopilotChat buffer:", bufnr)
            print("Filetype:", vim.bo[bufnr].filetype)
            local maps = vim.api.nvim_buf_get_keymap(bufnr, 'i')
            print("\nInsert mode mappings:")
            for _, map in ipairs(maps) do
              if map.lhs:match("<C%-") or map.lhs == "<CR>" or map.lhs == "<Tab>" then
                print(map.lhs, "->", map.rhs or "<Lua>")
              end
            end
          end, opts)
        end,
        
        -- Disable default mappings to prevent conflicts
        mappings = {
          complete = {
            insert = false,  -- Completely disable
          },
          close = {
            normal = false,
            insert = false,
          },
          reset = {
            normal = false,
            insert = false,
          },
          submit_prompt = {
            normal = false,
            insert = false,
          },
          accept_diff = {
            normal = false,
            insert = false,
          },
        },
      }
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")
      
      -- Auto-create save directory
      local save_dir = vim.fn.expand("~/.local/share/nvim/CopilotChat")
      if vim.fn.isdirectory(save_dir) == 0 then
        vim.fn.mkdir(save_dir, "p")
      end
      
      -- Setup with our options
      chat.setup(opts)
      
      -- Add custom commands
      vim.api.nvim_create_user_command("CopilotChatBuffer", function()
        chat.ask("Explain this file", { selection = require("CopilotChat.select").buffer })
      end, { desc = "AI explain current buffer" })
      
      vim.api.nvim_create_user_command("CopilotChatCommit", function()
        chat.ask("Write a commit message for these changes", { selection = require("CopilotChat.select").gitdiff })
      end, { desc = "AI write commit message" })
      
      -- Create autocmd to ensure our mappings persist
      vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = "copilot-chat",
        callback = function(ev)
          -- Reapply our keymaps when entering the buffer
          if opts.on_open then
            opts.on_open(ev.buf)
          end
        end,
      })
    end,
  },
  
  -- Rest of the plugins remain the same...
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          gitcommit = true,
          ["*"] = true,
        },
      })
    end,
  },
  
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    config = function()
      require("copilot_cmp").setup()
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
        disable_bindings = true,
      })
    end,
    event = "InsertEnter",
  },
}