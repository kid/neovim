--- @type lze.PluginSpec[]
return {
  {
    "nvim-lspconfig",
    event = "DeferredUIEnter",
    after = function()
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })

      vim.lsp.config("*", {
        on_attach = function(client)
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            Snacks.toggle.inlay_hints():map("<leader>lh")
          end

          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
            vim.lsp.inline_completion.enable(true)

            vim.keymap.set("i", "<A-y>", function()
              if not vim.lsp.inline_completion.get() then
                return "<A-y>"
              end
            end, {
              expr = true,
              replace_keycodes = true,
              desc = "Accept the current inline completion",
            })
          end

          vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "Go to Definition" })
          vim.keymap.set("n", "gD", Snacks.picker.lsp_type_definitions, { desc = "Go to Type Definition" })
          vim.keymap.set("n", "gi", Snacks.picker.lsp_implementations, { desc = "Go to Implementation" })
          vim.keymap.set("n", "gR", Snacks.picker.lsp_references, { desc = "Go to References" })
          vim.keymap.set("n", "<leader>ls", Snacks.picker.lsp_symbols, { desc = "Search Symbols" })
          vim.keymap.set("n", "<leader>lw", Snacks.picker.lsp_workspace_symbols, { desc = "Search Workspace Symbols" })
          vim.keymap.set("n", "<leader>lci", Snacks.picker.lsp_incoming_calls, { desc = "Go to incoming calls" })
          vim.keymap.set("n", "<leader>lca", Snacks.picker.lsp_outgoing_calls, { desc = "Go to outgoing calls" })
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
          vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
          vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Document" })
          vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })
        end,
      })
      vim.lsp.enable({ "lua_ls", "nil_ls", "nixd", "statix", "gopls", "copilot" })
    end,
    key_groups = {
      { "<leader>l", group = "LSP" },
    },
  },
  {
    "trouble.nvim",
    cmd = { "Trouble" },
    after = function()
      require("trouble").setup({})
    end,
  },
}
