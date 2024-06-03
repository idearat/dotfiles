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
    },
    -- buf_filter = function(bufnr)
    --   local bufname = vim.api.nvim_buf_get_name(bufnr)
    --   notify("tab_buf_filter", bufname)
    --   return not bufname:match("Untitled") and not bufname:match("No Name")
    -- end,
  },
}
