--- @type lze.PluginSpec[]
return {
  {
    "fyler.nvim",
    dependencies = { "mini.icons" },
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Fyler<cr>" },
    },
    after = function()
      require("fyler").setup({})
    end,
  },
}
