require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"go",
		"hcl",
		"java",
		"javascript",
		"lua",
		"markdown",
		"python",
		"rust",
		"typescript",
	},

	sync_install = false,

	auto_install = false,

	highlight = {
		enable = true,

		additional_vim_regex_highlighting = false,
	},
})
