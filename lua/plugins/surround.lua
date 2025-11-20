--- @type lz.n.PluginSpec[]
return {
  {
    "nvim-surround",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-surround").setup({})
    end,
  },
}
