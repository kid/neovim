--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "helm-ls.nvim",
    -- Load eagerly: this plugin provides Helm filetype detection.
    after = function()
      require("helm-ls").setup({})
    end,
  },
}
