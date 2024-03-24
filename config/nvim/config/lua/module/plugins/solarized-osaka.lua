require("solarized-osaka").setup({
  transparent = true,
  on_colors = function (c)
    c.base03 = "#202020"
    c.base02 = "#202020"
  end,
})
vim.cmd [[colorscheme solarized-osaka]]
