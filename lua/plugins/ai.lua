--- @type lze.PluginSpec[]
return {
  {
    "codecompanion.nvim",
    dependencies = {
      "plenary.nvim",
      "nvim-treesitter",
    },
    before = function()
      require("lze").trigger_load("markview.nvim")
    end,
    after = function()
      require("codecompanion").setup({})
    end,
  },
}
