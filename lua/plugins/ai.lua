return {
  {
    "codecompanion.nvim",
    dependencies = {
      "plenary.nvim",
      "nvim-treesitter",
      "blink.cmp",
    },
    after = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            opts = {
              completion_provider = "blink",
            },
          },
        },
      })
    end,
  },
}
