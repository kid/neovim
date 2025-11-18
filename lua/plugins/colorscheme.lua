return {
	{
		"gruvbox.nvim",
		after = function()
			require("gruvbox").setup()
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
