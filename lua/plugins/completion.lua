-- TODO: add colorful.menu
-- TODO: implement copilot next edit suggestions
-- FIXME: kind icon alignment

--- @type lze.PluginSpec[]
return {
  {
    "lspkind.nvim",
    event = "DeferredUIEnter",
  },
  { "nvim-web-devicons" },
  {
    "blink-copilot",
    event = "DeferredUIEnter",
    opts = {},
  },
  {
    "colorful-menu.nvim",
    event = "InsertEnter",
    after = function()
      require("colorful-menu").setup({})
    end,
  },
  {
    "blink.cmp",
    event = "InsertEnter",
    before = function()
      LZE.trigger_load("lspkind.nvim")
      LZE.trigger_load("nvim-web-devicons")
      LZE.trigger_load("blink-copilot")
      LZE.trigger_load("colorful-menu.nvim")
    end,
    after = function()
      require("blink.cmp").setup({
        completion = {
          menu = {
            auto_show = true,
            draw = {
              treesitter = { "lsp" },
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
          ghost_text = {
            enabled = true,
          },
          list = {
            selection = {
              preselect = true,
              auto_insert = false,
            },
          },
        },
        signature = { enabled = true },
        sources = {
          default = {
            "lsp",
            "path",
            -- "snippets",
            "buffer",
            "copilot",
          },
          per_filetype = {
            lua = { "lazydev", inherit_defaults = true },
          },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              async = true,
            },
          },
        },
        fuzzy = {
          implementation = "prefer_rust_with_warning",
        },
      })
    end,
  },
  {
    "blink.pairs",
    event = "DeferredUIEnter",
    after = function()
      require("blink.pairs").setup({})
    end,
  },
}
