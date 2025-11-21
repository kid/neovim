--- @type lze.PluginSpec[]
return {
  {
    "conform.nvim",
    lazy = false,
    after = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "treefmt", "stylua", lsp_format = "fallback", stop_after_first = true },
          nix = { "treefmt", "nixfmt", lsp_format = "fallback", stop_after_first = true },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
