--- @type lz.n.PluginSpec[]
return {
  {
    "nvim-treesitter",
    event = "DeferredUIEnter",
    opts = {
      highlight = {
        enable = true,
      },
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
