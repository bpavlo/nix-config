vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case

vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.clipboard:append("unnamedplus")

vim.opt.guicursor = {
	"n-v:block",
	"i-c-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor25",
}
