return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        disable_netrw = true,
        sort_by = "case_sensitive",
        update_focused_file = {
          enable = true,
        },
        view = {
          width = 42,
          centralize_selection = true,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          custom = {
            "build",
            "dist",
            "node_modules",
            "TIBET-INF/tibet",
            ".next",
            ".git",
            ".DS_Store",
            ".cache",
            ".vscode",
            "__pycache__",
            ".pytest_cache",
            ".mypy_cache",
            ".ipynb_checkpoints",
            ".venv",
          },
        },
        git = {
          ignore = false,
        },
      }
    end,
  },
}
