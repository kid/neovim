--- @type lze.PluginSpec[]
return {
  {
    "markview.nvim",
    lazy = false,
    dependencies = {
      "blink.cmp",
      "treesitter.nvim",
    },
    after = function()
      require("markview").setup({
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      })
    end,
  },
}
