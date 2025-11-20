--- @type lz.n.PluginSpec[]
return {
  { "mini.icons" },
  { "nui.nvim" },
  {
    "gruvbox.nvim",
    after = function()
      require("gruvbox").setup({
        overrides = {
          CursorLineNr = { bg = "none" },
          CursorLineSign = { bg = "none" },
          DiagnosticSignError = { bg = "none" },
          DiagnosticSignWarn = { bg = "none" },
          DiagnosticSignInfo = { bg = "none" },
          DiagnosticSignHint = { bg = "none" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    dependencies = { "nvim-wev-devicons", "noice.nvim" },
    after = function()
      require("lualine").setup({
        options = {
          global_status = true,
        },
        -- sections = {
        --   lualine_x = {
        --     {
        --       require("noice").api.status.message.get_hl,
        --       cond = require("noice").api.status.message.has,
        --     },
        --     {
        --       require("noice").api.status.command.get,
        --       cond = require("noice").api.status.command.has,
        --       color = { fg = "#ff9e64" },
        --     },
        --     {
        --       require("noice").api.status.mode.get,
        --       cond = require("noice").api.status.mode.has,
        --       color = { fg = "#ff9e64" },
        --     },
        --     {
        --       require("noice").api.status.search.get,
        --       cond = require("noice").api.status.search.has,
        --       color = { fg = "#ff9e64" },
        --     },
        --   },
        -- },
      })
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    dependencies = { "mini.icons" },
    opts = {},
  },
  {
    "noice.nvim",
    dependencies = { "nui.nvim" },
    event = "DeferredUIEnter",
    after = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
      })
    end,
  },
}
