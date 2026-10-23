-- Startup smoke check, loaded with `--cmd` before init.lua.
-- Simulates a UI attaching (so lze's DeferredUIEnter plugins load), then fails
-- with a non-zero exit if any error was reported.
--
-- Errors are collected from two places:
--   * vim.notify at ERROR level: lze reports plugin load failures this way, and
--     noice replaces vim.notify later, so the field is trapped via a metatable.
--   * the message history: a clean startup leaves it empty, so any entry fails
--     the check. Uncaught Lua/Vimscript errors land here, and their text has no
--     reliable common prefix to match on.
-- The report is written to $NVIM_STARTUP_REPORT because noice swallows stderr.

local report_path = assert(vim.env.NVIM_STARTUP_REPORT, "NVIM_STARTUP_REPORT is not set")
local errors = {}

local current_notify = vim.notify
local function notify(msg, level, opts)
  if level and level >= vim.log.levels.ERROR then
    table.insert(errors, "vim.notify: " .. tostring(msg))
  end
  return current_notify(msg, level, opts)
end

local mt = getmetatable(vim)
local index = mt.__index
rawset(vim, "notify", nil)
mt.__index = function(t, k)
  if k == "notify" then
    return notify
  end
  return index(t, k)
end
mt.__newindex = function(t, k, v)
  if k == "notify" then
    current_notify = v
  else
    rawset(t, k, v)
  end
end

local function finish()
  local history = vim.api.nvim_exec2("messages", { output = true }).output
  if history ~= "" then
    table.insert(errors, "messages:\n" .. history)
  end

  local f = assert(io.open(report_path, "w"))
  f:write(#errors == 0 and "ok\n" or table.concat(errors, "\n") .. "\n")
  f:close()
  vim.cmd(#errors == 0 and "qall!" or "cquit! 1")
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  nested = true,
  callback = function()
    vim.api.nvim_exec_autocmds("UIEnter", {})
    -- Runs after the scheduled DeferredUIEnter, leaving plugins time to finish
    -- work they scheduled while loading. Does not depend on init.lua getting
    -- far enough to set up lze.
    vim.defer_fn(finish, 1000)
  end,
})
