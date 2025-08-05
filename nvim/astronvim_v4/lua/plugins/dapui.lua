return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      -- Don't close the UI when the debug session ends
      listeners = {
        terminated = function() end,
        exited = function() end,
      },
    })

    -- Automatically open the UI when a session starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
  end,
}