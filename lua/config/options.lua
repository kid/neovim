vim.g.mapleader = " "
vim.o.mouse = ""

vim.o.termguicolors = true
vim.o.updatetime = 200
vim.o.autoread = true
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true

vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.pumheight = 10 -- max height of completion menu
vim.o.showmode = false -- disable showing mode below statusline

vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.signcolumn = "yes"
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.incsearch = true -- Ignore case during search
vim.o.infercase = true -- Infer case in built-in completion
vim.o.ignorecase = true -- Ignore case during search
vim.o.hlsearch = false -- Disable highlight search results

vim.o.tabstop = 2 -- how many spaces tab inserts
vim.o.softtabstop = 2 -- how many spaces tab inserts
vim.o.shiftwidth = 2 -- controls number of spaces when using >> or << commands
vim.o.expandtab = true -- use appropriate number of spaces with tab
vim.o.smartindent = true -- indenting correctly after {
vim.o.autoindent = true -- copy indent from current line when starting new line
vim.o.scrolloff = 8 -- always keep 8 lines above/below cursor unless at start/end of file

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

vim.opt.fillchars:append({
  eob = " ",
  -- fold = " ",
  -- foldopen = "",
  -- foldsep = " ",
  -- foldclose = "",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.filetype.add({
  extension = {
    tofu = "terraform",
  },
})
