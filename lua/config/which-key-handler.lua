local lze = require("lze")
local all_key_groups = {}

--- @type lze.Handler
local M = {
  spec_field = "key_groups",
}

-- function M.init()
--   lze.load({
--     "which-key.nvim",
--     event = "DeferredUIEnter",
--   })
--   lze.trigger_load("which-key.nvim")
-- end

---@param plugin lze.Plugin
function M.add(plugin)
  local key_groups = plugin.key_groups
  if not key_groups then
    return
  end

  for k, v in pairs(key_groups) do
    all_key_groups[k] = v
  end
end

function M.post_def()
  lze.trigger_load("which-key.nvim")
  require("which-key").add(all_key_groups)
end

return M
