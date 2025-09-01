return {
  {
    "stevearc/resession.nvim",
    opts = {
      -- Configure auto saving
      autosave = {
        enabled = true,
        interval = 10, -- every 10 seconds
        notify = false, -- don't annoy me
      },
      -- Extensions
      extensions = {
        astrocore = { enable_in_tab = true },
      },
    },
  },
}
