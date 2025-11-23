--- @type lze.PluginSpec[]
return {
  { "friendly-snippets", event = "InsertEnter" },
  {
    "LuaSnip",
    event = "InsertEnter",
    before = function()
      LZE.trigger_load("friendly-snippets")
    end,
    after = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
