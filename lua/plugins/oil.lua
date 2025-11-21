--- @type lze.PluginSpec[]
return {
  {
    "oil.nvim",
    dependencies = { "mini.icons" },
    lazy = false,
    keys = {
      -- { "<leader>e", "<cmd>Oil<cr>" },
    },
    --- @module 'oil'
    --- @type oil.SetupOpts
    opts = {},
    after = function()
      require("oil").setup({})
    end,
  },
}
