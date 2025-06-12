return {
  -- CopilotChat with aggressive keybinding override
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    init = function()
      -- Create autocmd group for CopilotChat customizations
      vim.api.nvim_create_augroup("CopilotChatCustom", { clear = true })
      
      -- Override keybindings whenever we enter a CopilotChat buffer
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
        group = "CopilotChatCustom",
        pattern = { "copilot-chat", "*copilot*" },
        callback = function(args)
          local bufnr = args.buf
          
          -- Check if this is actually a CopilotChat buffer
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if not (vim.bo[bufnr].filetype == "copilot-chat" or bufname:match("copilot%-chat")) then
            return
          end
          
          -- Delay to ensure plugin's mappings are set first
          vim.schedule(function()
            -- Clear any existing mappings for our keys
            pcall(vim.keymap.del, 'i', '<CR>', { buffer = bufnr })
            pcall(vim.keymap.del, 'i', '<Tab>', { buffer = bufnr })
            pcall(vim.keymap.del, 'i', '<C-c>', { buffer = bufnr })
            
            local opts = { noremap = true, silent = true, buffer = bufnr }
            
            -- Insert mode mappings
            -- Make Enter just insert a newline (not submit)
            vim.api.nvim_buf_set_keymap(bufnr, 'i', '<CR>', '<CR>', { noremap = true, silent = true })
            
            -- C-y submits the prompt
            vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-y>', '<Esc><Cmd>CopilotChatSubmit<CR>', { noremap = true, silent = true })
            
            -- Tab inserts a tab
            vim.api.nvim_buf_set_keymap(bufnr, 'i', '<Tab>', '<Tab>', { noremap = true, silent = true })
            
            -- C-c closes the chat
            vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-c>', '<Esc><Cmd>CopilotChatClose<CR>', { noremap = true, silent = true })
            
            -- Accept suggestions
            vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-;>', '<Cmd>CopilotChatAccept<CR>', { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-l>', '<Cmd>CopilotChatAccept<CR>', { noremap = true, silent = true })
            
            -- Normal mode mappings
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-y>', '<Cmd>CopilotChatSubmit<CR>', { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<Cmd>CopilotChatClose<CR>', { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-x>', '<Cmd>CopilotChatReset<CR>', { noremap = true, silent = true })
            
            -- Debugging command - check what's actually mapped
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ck', '', {
              noremap = true,
              silent = true,
              callback = function()
                print("=== CopilotChat Keybindings (buffer " .. bufnr .. ") ===")
                local keys_to_check = { '<CR>', '<C-y>', '<Tab>', '<C-c>' }
                for _, key in ipairs(keys_to_check) do
                  local mapping = vim.fn.maparg(key, 'i', false, true)
                  if mapping and mapping.rhs then
                    print("i " .. key .. " -> " .. mapping.rhs)
                  else
                    print("i " .. key .. " -> (no mapping found)")
                  end
                end
              end
            })
          end)
        end,
      })
    end,
    opts = {
      model = "claude-3.5-sonnet",
      temperature = 0.1,
      
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
      
      -- Try to disable all default mappings
      mappings = false,  -- Some plugins accept false to disable all
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      
      -- Try another approach to disable mappings
      if not opts.mappings then
        opts.mappings = {
          complete = { insert = nil },
          close = { normal = nil, insert = nil },
          reset = { normal = nil, insert = nil },
          submit_prompt = { normal = nil, insert = nil },
          accept_diff = { normal = nil, insert = nil },
          toggle_sticky = { normal = nil },
        }
      end
      
      chat.setup(opts)
      
      -- Custom commands
      vim.api.nvim_create_user_command("CopilotChatBuffer", function()
        chat.ask("Explain this file", { selection = require("CopilotChat.select").buffer })
      end, { desc = "AI explain current buffer" })
      
      vim.api.nvim_create_user_command("CopilotChatCommit", function()
        chat.ask("Write a commit message for these changes", { selection = require("CopilotChat.select").gitdiff })
      end, { desc = "AI write commit message" })
    end,
  },
  
  -- Keep other plugins as-is
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