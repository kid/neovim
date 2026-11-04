-- Compiles every dang query against the bundled parser. dang.nvim (queries) and
-- dang (grammar) track upstream main separately, so a lock bump can pull in
-- queries using node types the pinned grammar lacks, which otherwise only
-- surfaces when a .dang buffer opens.

local files = vim.api.nvim_get_runtime_file("queries/dang/*.scm", true)
local errors = {}
if #files == 0 then
  table.insert(errors, "no queries/dang/*.scm on runtimepath")
end

for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  local ok, err = pcall(vim.treesitter.query.get, "dang", name)
  if not ok then
    table.insert(errors, name .. ": " .. tostring(err))
  end
end

io.stderr:write(#errors == 0 and ("ok: " .. #files .. " queries\n") or (table.concat(errors, "\n") .. "\n"))
vim.cmd(#errors == 0 and "qall!" or "cquit! 1")
