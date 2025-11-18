return {
	{ "nui.nvim" },
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
