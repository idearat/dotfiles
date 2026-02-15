-- CmdFlow: rune-driven development + review mode
return {
  {
    "cmdflow.nvim",
    name = "cmdflow.nvim",
    dir = vim.fn.expand(
      "~/dev/coderats/repos/rats/platform"
        .. "/parts/views/cmdflow-nvim"
    ),
    lazy = false,
    config = function()
      require("cmdflow").setup({
        connection_mode = "persistent",
        port = 4222,
        notify_level = "info",
        reconnect_strategy = "lazy",
        auto_connect = true,
      })
    end,
  },
}
