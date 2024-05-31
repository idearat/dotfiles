-- fast search and navigation
return {
  {
    "ggandor/leap.nvim",
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      -- leap.create_default_mappings(true)
    end,
    dependencies = {
      "tpope/vim-repeat",
    },
  },
}
