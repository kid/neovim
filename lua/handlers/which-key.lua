local lze = require("lze")
local all_key_groups = {}

--- @type lze.Handler
local M = {
  spec_field = "key_groups",
}

--- @param plugin lze.Plugin
function M.add(plugin)
  local key_groups = plugin.key_groups
  if not key_groups then
    return
  end

  for _, v in pairs(key_groups) do
    table.insert(all_key_groups, v)
  end
end

function M.post_def()
  vim.api.nvim_create_augroup("config.which-key", { clear = false })
  vim.api.nvim_create_autocmd("User", {
    pattern = "DeferredUIEnter",
    group = "config.which-key",
    once = true,
    callback = function()
      lze.trigger_load("which-key.nvim")
      require("which-key").add(all_key_groups)
    end,
  })
end

return M
