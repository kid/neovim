--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "fyler.nvim",
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Fyler<cr>", desc = "Open Fyler View" },
    },
    before = function()
      LZE.trigger_load("nvim-web-devicons")
    end,
    after = function()
      require("fyler").setup({
        integrations = {
          icon = "nvim_web_devicons",
        },
        views = {
          finder = {
            default_explorer = true,
          },
        },
      })
    end,
  },
}
