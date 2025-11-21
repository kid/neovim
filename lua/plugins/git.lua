--- @type lze.PluginSpec[]
return {
  {
    "diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    after = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        file_panel = {
          win_config = {
            win_opts = {
              number = false,
              relativenumber = false,
              signcolumn = "no",
            },
          },
        },
      })
    end,
  },
  {
    "neogit",
    cmd = "Neogit",
    before = function()
      LZE.trigger_load("diffview.nvim")
      LZE.trigger_load("snacks.nvim")
    end,
    after = function()
      require("neogit").setup({
        disable_signs = true,
        integrations = {
          diffview = true,
          snacks = true,
        },
      })
    end,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    },
  },
}
