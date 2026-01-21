--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "nvim-treesitter",
    event = "DeferredUIEnter",
    load = function(name)
      require("lzextras").loaders.multi({
        name,
        "nvim-treesitter-textobjects",
      })
    end,
    before = function()
      -- vim.g.no_plugin_maps = true
    end,
    after = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter-textobjects").setup()
    end,
  },
}
