---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "c",
      "css",
      "dockerfile",
      "go",
      "gomod",
      "gowork",
      "graphql",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "python",
      "regex",
      "rust",
      "scss",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    })
  end,
}
