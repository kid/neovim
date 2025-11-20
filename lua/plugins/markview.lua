--- @type lz.n.PluginSpec[]
return {
  {
    "markview.nvim",
    lazy = false,
    dependencies = {
      "blink.cmp",
      "treesitter.nvim",
    },
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
}
