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

      -- vim.api.nvim_create_autocmd("LspProgress", {
      -- 	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      -- 	callback = function(ev)
      -- 		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      -- 		vim.notify(vim.lsp.status(), "info", {
      -- 			id = "lsp_progress",
      -- 			title = "LSP Progress",
      -- 			opts = function(notif)
      -- 				notif.icon = ev.data.params.value.kind == "end" and " "
      -- 					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      -- 			end,
      -- 		})
      -- 	end,
      -- })
    end,
  },
}
