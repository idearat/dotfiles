return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()    require("nvim-dap-virtual-text").setup()

    -- mason-nvim-dap will see this and automatically set up the adapter
    local dap = require "dap"
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }

    -- Configuration for debugging tests
    dap.configurations.javascript = {
      {
        name = "Debug Hybrid Tests",
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/scripts/debug-test.js",
        args = { "tests/hybrid" },
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        env = {
          NODE_OPTIONS = "--experimental-vm-modules",
        },
      },
      {
        name = "Debug Current Test File",
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/scripts/debug-test.js",
        args = { vim.fn.expand "%:p" },
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        env = {
          NODE_OPTIONS = "--experimental-vm-modules",
        },
      },
      {
        name = "Debug All Tests",
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/scripts/debug-test.js",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        env = {
          NODE_OPTIONS = "--experimental-vm-modules",
        },
      },
    }

    -- Helper function to debug current test file
    vim.api.nvim_create_user_command("DebugTest", function()
      require("dap").run {
        type = "node2",
        request = "launch",
        name = "Debug Current Test",
        program = vim.fn.getcwd() .. "/scripts/debug-test.js",
        args = { vim.fn.expand "%:p" },
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        env = {
          NODE_OPTIONS = "--experimental-vm-modules",
        },
      }
    end, {})

    -- Helper function to debug all hybrid tests
    vim.api.nvim_create_user_command("DebugHybrid", function()
      require("dap").run {
        type = "node2",
        request = "launch",
        name = "Debug Hybrid Tests",
        program = vim.fn.getcwd() .. "/scripts/debug-test.js",
        args = { "tests/hybrid" },
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        env = {
          NODE_OPTIONS = "--experimental-vm-modules",
        },
      }
    end, {})

    -- Helper function to start a new session
    vim.api.nvim_create_user_command("DapNew", function()
      require("dap").continue() -- Prompts to select a configuration if not running
    end, {})
  end,
}
