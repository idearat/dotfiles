-- Detect .crux files
vim.filetype.add({
  extension = {
    crux = function()
      vim.bo.filetype = "crux"
      vim.bo.syntax = "crux"
    end,
  },
})
