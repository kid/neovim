--- @module "lze"
--- @type lze.PluginSpec[]
return {
  { "friendly-snippets", event = "InsertEnter" },
  {
    "luasnip",
    event = "InsertEnter",
    before = function()
      LZE.trigger_load("friendly-snippets")
    end,
    after = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
