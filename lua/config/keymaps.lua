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
