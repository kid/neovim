--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "nvim-surround",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-surround").setup({})
    end,
  },
}
