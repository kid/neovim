--- @module "lze"
--- @type lze.PluginSpec[]
return {
  {
    "nvim-treesitter",
    load = function(name)
      require("lzextras").loaders.multi({
        name,
        "nvim-treesitter-textobjects",
      })
    end,
    after = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
        },
      })
    end,
  },
}
