-- TypeScript-specific settings
vim.opt_local.formatoptions = "tcroqj"
vim.opt_local.commentstring = "// %s"
vim.opt_local.autoindent = true
vim.opt_local.smartindent = false

-- Disable indentexpr - rely on autoindent + formatoptions for
-- proper comment continuation without extra indentation
vim.opt_local.indentexpr = ""

-- Custom gq for template literals using fmt
vim.keymap.set("v", "gq", ":'<,'>!fmt -w 80<CR>", {
  buffer = true,
  silent = true,
  desc = "Format text to 80 chars"
})