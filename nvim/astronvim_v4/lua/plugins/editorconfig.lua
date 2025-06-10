-- EditorConfig plugin to respect .editorconfig files
return {
  "editorconfig/editorconfig-vim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Ensure EditorConfig doesn't conflict with ftplugin settings
    vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
  end,
}