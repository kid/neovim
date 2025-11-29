vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    if vim.o.columns >= 120 then
      vim.cmd("wincmd L")
      vim.cmd("vertical resize 80")
    end
  end,
})
