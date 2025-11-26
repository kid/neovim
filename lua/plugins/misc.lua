--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "helm-ls.nvim",
    ft = { "helm" },
    after = function()
      require("helm-ls").setup({})
    end,
  },
}
