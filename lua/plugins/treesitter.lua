return {
  {
    "nvim-treesitter",
    event = "DeferredUIEnter",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
