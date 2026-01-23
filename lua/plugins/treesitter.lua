--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "nvim-treesitter",
    lazy = false,
    -- load = function(name)
    --   require("lzextras").loaders.multi({
    --     name,
    --     "nvim-treesitter-textobjects",
    --   })
    -- end,
    after = function()
      local nvim_treesitter = require("nvim-treesitter")
      nvim_treesitter.setup()
      local available = nvim_treesitter.get_available()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function(args)
          local bufnr = args.buf
          local ft = args.match

          if vim.list_contains(available, ft) then
            vim.treesitter.start(bufnr)
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter-textobjects",
    lazy = false,
    before = function()
      LZE.trigger_load("nvim-treesitter")
    end,
    after = function()
      require("nvim-treesitter-textobjects").setup()
    end,
  },
}
