vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>n", ":Lexplore<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.g.barbar_auto_setup = false
