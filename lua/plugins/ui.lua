--- @module "lze"
--- @type lze.PluginSpec[]
return {
  { "mini.icons" },
  { "nui.nvim" },
  {
    "gruvbox.nvim",
    after = function()
      require("gruvbox").setup({
        overrides = {
          SignColumn = { bg = "none" },
          CursorLineNr = { bg = "none" },
          CursorLineSign = { bg = "none" },
          DiagnosticSignError = { bg = "none" },
          DiagnosticSignWarn = { bg = "none" },
          DiagnosticSignInfo = { bg = "none" },
          DiagnosticSignHint = { bg = "none" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("nvim-web-devicons")
      LZE.trigger_load("noice.nvim")
      -- LZE.trigger_load("sidekick.nvim")
    end,
    after = function()
      require("lualine").setup({
        options = {
          global_status = true,
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_c = {
            { "lsp_status " },
            -- {
            --   function()
            --     return " "
            --   end,
            --   color = function()
            --     local status = require("sidekick.status").get()
            --     if status then
            --       return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
            --     end
            --   end,
            --   cond = function()
            --     local status = require("sidekick.status")
            --     return status.get() ~= nil
            --   end,
            -- },
            { "filename", path = 1 },
          },
        },
        tabline = {
          lualine_a = { { "buffers", show_filename_only = false } },
          lualine_z = { { "tabs" } },
        },
        extensions = { "quickfix" },
      })
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("mini.icons")
    end,
    after = function()
      require("which-key").setup({})
    end,
  },
  {
    "noice.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("nui.nvim")
    end,
    after = function()
      -- TODO: replace lsp progress with fidget later
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
  {
    "todo-comments.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("trouble.nvim")
    end,
    after = function()
      require("todo-comments").setup({})
    end,
    keys = {
      -- FIXME: conflicts with next / previous tab
      -- {
      --   "n",
      --   "]t",
      --   function()
      --     require("todo-comments").jump_next()
      --   end,
      --   { desc = "Next todo comment" },
      -- },
      -- {
      --   "n",
      --   "[t",
      --   function()
      --     require("todo-comments").jump_prev()
      --   end,
      --   { desc = "Previous todo comment" },
      -- },
    },
  },
  -- TODO: do I njeed quicker with Trouble?
  {
    "quicker.nvim",
    ft = "qf",
    before = function()
      LZE.trigger_load("nui.nvim")
    end,
    after = function()
      require("quicker").setup({})
    end,
  },
  {
    "smart-splits.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("smart-splits").setup({
        at_edge = "stop",
      })
    end,
    keys = {
      -- stylua: ignore start
      { "<C-h>", function() require("smart-splits").move_cursor_left()  end, desc = "Move cursor left"  },
      { "<C-j>", function() require("smart-splits").move_cursor_down()  end, desc = "Move cursor down"  },
      { "<C-k>", function() require("smart-splits").move_cursor_up()    end, desc = "Move cursor up"    },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move cursor right" },

      { "<A-h>", function() require("smart-splits").resize_left()  end, desc = "Resize left"  },
      { "<A-j>", function() require("smart-splits").resize_down()  end, desc = "Resize down"  },
      { "<A-k>", function() require("smart-splits").resize_up()    end, desc = "Resize up"    },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },

      { "<C-w>h", function() require("smart-splits").swap_buf_left()  end, desc = "Swap buffer left"  },
      { "<C-w>j", function() require("smart-splits").swap_buf_down()  end, desc = "Swap buffer down"  },
      { "<C-w>k", function() require("smart-splits").swap_buf_up()    end, desc = "Swap buffer up"    },
      { "<C-w>l", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
      -- stylua: ignore end
    },
  },
}
