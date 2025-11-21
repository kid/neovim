--- @type lze.PluginSpec[]
return {
  {
    "nvim-lspconfig",
    after = function()
      vim.diagnostic.config({
        -- update_in_insert = true,
        virtual_text = true,
        -- virtual_lines = { enable = true, current_line = true },
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          -- linehl = {
          --   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          -- },
          -- numhl = {
          --   [vim.diagnostic.severity.WARN] = "WarningMsg",
          --   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          -- },
        },
      })

      vim.lsp.enable({ "lua_ls", "nil_ls", "nixd", "statix", "gopls", "copilot" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
    key_groups = {
      { "<leader>l", group = "+LSP" },
    },
  },
}
