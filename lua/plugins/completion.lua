-- TODO: add colorful.menu
-- TODO: implement copilot next edit suggestions
-- FIXME: kind icon alignment

--- @type lz.n.PluginSpec[]
return {
  {
    "lspkind.nvim",
    event = "DeferredUIEnter",
    opts = {},
  },
  { "nvim-web-devicons" },
  {
    "blink-copilot",
    event = "DeferredUIEnter",
    opts = {},
  },
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    dependencies = {
      "lspkind.nvim",
      "nvim-web-devicons",
      "blink-copilot",
    },
    after = function()
      require("blink.cmp").setup({
        completion = {
          menu = {
            auto_show = true,
            draw = {
              treesitter = { "lsp" },
              -- columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
              -- components = {
              --   kind_icon = {
              --     text = function(ctx)
              --       local icon = ctx.kind_icon
              --       if vim.tbl_contains({ "Path" }, ctx.source_name) then
              --         local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
              --         if dev_icon then
              --           icon = dev_icon
              --         end
              --       else
              --         icon = require("lspkind").symbolic(ctx.kind, {
              --           mode = "symbol",
              --         })
              --       end
              --
              --       return icon .. ctx.icon_gap
              --     end,
              --
              --     -- Optionally, use the highlight groups from nvim-web-devicons
              --     -- You can also add the same function for `kind.highlight` if you want to
              --     -- keep the highlight groups in sync with the icons.
              --     highlight = function(ctx)
              --       local hl = ctx.kind_hl
              --       if vim.tbl_contains({ "Path" }, ctx.source_name) then
              --         local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
              --         if dev_icon then
              --           hl = dev_hl
              --         end
              --       end
              --       return hl
              --     end,
              --   },
              -- },
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
            "lazydev",
            "lsp",
            "path",
            -- "snippets",
            "buffer",
            "copilot",
          },
          -- per_filetype = {
          --   codecompanion = { "codecompanion" },
          -- },
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
