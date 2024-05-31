-- extra-thin vertical line for ZenMode et. al.
return {
  {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup {
        char = "│",
      }
    end,
  }
}
