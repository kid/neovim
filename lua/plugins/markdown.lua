--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "render-markdown.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("nvim-treesitter")
      LZE.trigger_load("nvim-web-devicons")
      LZE.trigger_load("blink.cmp")
    end,
    after = function()
      require("render-markdown").setup({
        completions = {
          lsp = { enabled = true },
          blink = { enabled = true },
        },
      })
    end,
  },
}
