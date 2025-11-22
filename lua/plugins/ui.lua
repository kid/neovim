--- @type lze.PluginSpec[]
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
      })
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("mini.icons")
    end,
    after = function()
      require("which-key").setup({})
    end,
  },
  {
    "noice.nvim",
    dependencies = { "nui.nvim" },
    event = "DeferredUIEnter",
    after = function()
      -- TODO: replace lsp progress with fidget later
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
