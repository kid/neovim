--- @type lze.PluginSpec[]
return {
  {
    "oil.nvim",
    dependencies = { "mini.icons" },
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Oil<cr>" },
    },
    after = function()
      require("oil").setup({})
    end,
  },
}
