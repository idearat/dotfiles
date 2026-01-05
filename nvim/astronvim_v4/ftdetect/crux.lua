-- Detect .crux files and *.crux.js pattern
vim.filetype.add({
  extension = {
    crux = "crux",
  },
  filename = {
    -- Match files like foo.crux.js, bar.crux.js
    [".+%.crux%.js"] = "crux",
  },
})
