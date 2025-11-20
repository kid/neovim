--- @type lz.n.PluginSpec[]
return {
  {
    "codecompanion.nvim",
    dependencies = {
      "plenary.nvim",
      "nvim-treesitter",
    },
    after = function()
      require("codecompanion").setup({})
    end,
  },
}
