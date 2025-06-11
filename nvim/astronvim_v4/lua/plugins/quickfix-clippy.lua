-- Fuck rust-analyzer, just run clippy directly
return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<leader>lq"] = {
            function()
              -- Save current file first
              vim.cmd("silent! write")
              
              -- Run clippy on everything
              -- Filter out only the compilation noise, not the warnings
              vim.cmd("cexpr system('cargo clippy --all --all-targets --tests --message-format=short 2>&1 | grep -v \"^\\s*Compiling\\|^\\s*Checking\\|^\\s*Finished\\|^\\s*Downloaded\\|^\\s*Updating\"')")
              vim.cmd("copen")
            end,
            desc = "Run Clippy to Quickfix"
          },
        },
      },
    },
  },
}