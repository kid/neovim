--- @module "lze"

--- @param group string
--- @return string|nil
local function fg(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  return hl.fg and string.format("#%06x", hl.fg) or nil
end

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
        -- Since v3, neogit derives its whole red palette from ErrorMsg's
        -- foreground. gruvbox styles ErrorMsg as dark-text-on-red, so that
        -- foreground is near-black and deletions render unreadable. Error's
        -- foreground is the actual red, and is what neogit used before v3.
        highlight = { red = fg("Error") },
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
  {
    "gitsigns.nvim",
    before = function()
      LZE.trigger_load("trouble.nvim")
    end,
    after = function()
      require("gitsigns").setup()
    end,
    keys = {
      {
        "]c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Go to next git hunk",
      },
      {
        "[c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Go to previous git hunk",
      },
    },
  },
}
