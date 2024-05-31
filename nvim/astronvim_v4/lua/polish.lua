-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- require("notify").setup({
--   render = "default",
--   background_colour = "#000000",
--   timeout = 2500,
-- })

vim.cmd("hi! link AlphaHeader @text.literal")
vim.cmd("hi! link AlphaButton @text.note")
vim.cmd("hi! link AlphaButtonShortcut @text.literal")
vim.cmd("hi! link AlphaQuote @comment")

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
