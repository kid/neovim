--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "conform.nvim",
    lazy = false,
    after = function()
      require("conform").setup({
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "treefmt", "stylua", stop_after_first = true },
          nix = { "treefmt", "nixfmt", stop_after_first = true },
          sh = { "treefmt", "shfmt", stop_after_first = true },
          go = { "goimports-reviser", "gofmt" },
          ts = { "prettierd", "prettier", "eslint", stop_after_first = true },
          js = { "prettierd", "prettier", "eslint", stop_after_first = true },
        },
      })
    end,
  },
}
