-- vim.keymap.set("n", "<leader>so", function()
-- 	vim.cmd("update")
-- 	vim.cmd("source $MYVIMRC")
-- end)

-- vim.keymap.set("n", "<leader>re", function()
-- 	vim.cmd("mks! Session.vim")
-- 	vim.cmd("restart source Session.nvim")
-- end)

-- Disable Space bar since it will be used as the leader key
vim.keymap.set({ "n", "v" }, "<leader>", "<nop>")

-- stylua: ignore start
-- System clipboard yanks/pastes
vim.keymap.set({ "n", "v" }, "<leader>y",  '"+y',  { desc = "Yank to system clipboard" })
vim.keymap.set({ "n" },      "<leader>Y",  '"+y$', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p",  '"+p',  { desc = "Paste from system clipboard (after)" })
vim.keymap.set({ "n", "v" }, "<leader>P",  '"+P',  { desc = "Paste from system clipboard (before)" })

-- Save with Ctrl+S
vim.keymap.set({ "n", "v" }, "<C-s>", "<Esc><cmd>w<cr>",  { desc = "Save file" })
vim.keymap.set({ "i", },     "<C-s>", "<Esc><cmd>w<cr>i", { desc = "Save file" })

-- Disable command-line window
vim.keymap.set("n", "q:", "<nop>")

vim.keymap.set("n", "<leader>q", function()
  if vim.bo.modified then
    vim.notify("Buffer modified. Use :w or :bd! to force.", vim.log.levels.WARN)
    return
  end
  vim.cmd("bd")
end, { desc = "Close buffer" })
-- stylua: ignore end
