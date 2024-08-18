-- hard, soft, and toggle-able word (auto-configured)
return {
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup({
        -- notify_on_switch = false,
        create_keymaps = false
      })
    end,
  }
}
