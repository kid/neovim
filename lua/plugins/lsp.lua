--- @module "lze"
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

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            Snacks.toggle.inlay_hints():map("<leader>lh")
          end

          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

            -- stylua: ignore start
            vim.keymap.set("i", "<A-y>", vim.lsp.inline_completion.get,    { desc = "LSP: Accept current inline completion", buffer = bufnr })
            vim.keymap.set("i", "<A-n>", vim.lsp.inline_completion.select, { desc = "LSP: Switch inline completion",         buffer = bufnr })
            -- stylua: ignore end
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

      local servers = {
        "copilot",
        "lua_ls",

        -- Nix
        "nil_ls",
        "nixd",
        "statix",

        "gopls",

        "terraformls",
        "tofu_ls",

        -- Javascript / Typescript
        "ts_ls",
        "eslint",

        "helm_ls",
      }

      local enabled = {}
      for _, name in ipairs(servers) do
        local cfg = vim.lsp.config and vim.lsp.config[name]
        local cmd = cfg and cfg.cmd
        if type(cmd) == "table" and #cmd > 0 then
          local bin = cmd[1]
          if type(bin) == "string" and vim.fn.executable(bin) == 1 then
            table.insert(enabled, name)
          end
        end
      end

      vim.lsp.enable(enabled)
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
