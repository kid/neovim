local lze = require("lze")

local wkHandler = require("config.which-key-handler")
lze.register_handlers(wkHandler)
lze.load({
  { import = "plugins.ai" },
  { import = "plugins.completion" },
  { import = "plugins.dev" },
  { import = "plugins.formatting" },
  { import = "plugins.lsp" },
  { import = "plugins.markview" },
  { import = "plugins.oil" },
  { import = "plugins.snacks" },
  { import = "plugins.surround" },
  { import = "plugins.treesitter" },
  { import = "plugins.ui" },
})
