--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "opencode.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("snacks.nvim")
    end,
    after = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.auto_reload`.
      vim.o.autoread = true

      -- stylua: ignore start
      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<C-a>",   function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<C-x>",   function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "x" }, "ga",      function() require("opencode").prompt("@this") end,                   { desc = "Add to opencode" })
      vim.keymap.set({ "n", "t" }, "<C-.>",   function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
      vim.keymap.set({ "n" },      "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
      vim.keymap.set({ "n" },      "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
      -- stylua: ignore end
    end,
  },
  {
    "sidekick.nvim",
    event = "DeferredUIEnter",
    before = function()
      LZE.trigger_load("snacks.nvim")
    end,
    after = function()
      ---@type sidekick.Config
      require("sidekick").setup({
        nes = {
          enabled = true,
        },
        signs = {
          enabled = true,
          icon = " ",
        },
        cli = {
          enabled = false,
        },
      })
    end,
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            ---@diagnostic disable-next-line: redundant-return-value
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
    },
  },
}
