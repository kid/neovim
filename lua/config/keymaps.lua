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
vim.keymap.set({ "n", "v" }, "<leader>p",  '"+p',  { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P",  '"+P',  { desc = "Paste before from system clipboard" })

-- Save with Ctrl+S
vim.keymap.set({ "n", "v" }, "<C-s>", "<Esc><cmd>w<cr>",  { desc = "Save file" })
vim.keymap.set({ "i", },     "<C-s>", "<Esc><cmd>w<cr>i", { desc = "Save file" })

-- Disable command-line window
vim.keymap.set("n", "q:", "<nop>")
-- stylua: ignore end
