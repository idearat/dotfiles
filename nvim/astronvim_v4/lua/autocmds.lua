-- ensure fold is off on all file types
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd "setlocal nofoldenable"
    vim.cmd "setlocal formatoptions=tjcroq"
  end,
})

-- Restore Ctrl+] functionality in help buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function(args)
    vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { buffer = args.buf, desc = "Jump to definition" })
  end,
})

-- Prevent Neovim from closing when the last buffer is closed
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if #vim.api.nvim_list_bufs() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") == nil then
      vim.api.nvim_create_autocmd("BufWinLeave", {
        once = true,
        pattern = "*",
        command = "silent! Alpha",
      })
    end
  end,
})

-- -- set up mappings etc. for GpChat buffers
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*/gp/chats/*",
--   callback = function()
--     local utils = require "astronvim.utils"
--     local maps = require("astronvim.utils").empty_map_table()
--     local bufnr = vim.api.nvim_get_current_buf()
--
--     maps.n["<localleader>d"] = { ":GpChatDelete<cr>", desc = "Chat Delete", buffer = bufnr }
--     maps.n["<localleader>n"] = { ":GpNextAgent<cr>", desc = "Chat Agent++", buffer = bufnr }
--     maps.n["<localleader>r"] = { ":GpChatRespond<cr>", desc = "Chat Response", buffer = bufnr }
--     maps.n["<localleader>s"] = { ":GpChatStop<cr>", desc = "Chat Stop", buffer = bufnr }
--     maps.n["<localleader>x"] = { ":GpContext<cr>", desc = "Chat Context", buffer = bufnr }
--
--     utils.set_mappings(astronvim.user_opts("mappings", maps))
--   end,
-- })
--
-- -- markdown-preview
-- vim.api.nvim_create_autocmd("BufEnter", {
--   desc = "Enable markdown preview",
--   group = vim.api.nvim_create_augroup("enable_markdown", { clear = true }),
--   pattern = "*.md",
--   callback = function(args)
--     local utils = require "astronvim.utils"
--     local maps = require("astronvim.utils").empty_map_table()
--
--     maps.n["<Localleader>m"] = { ":MarkdownPreview<cr>",
--       desc = "Markdown Preview ³", buffer = args.buf }
--
--     utils.set_mappings(astronvim.user_opts("mappings", maps))
--
--     vim.opt_local.conceallevel = 2    -- for Obsidian UI features
--   end,
-- })
