-- install packer if not installed on this machine
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- first time startup
local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

  use("norcalli/nvim-colorizer.lua")
  use("craftzdog/solarized-osaka.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("module.plugins.telescope")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSupdate",
		config = function()
			require("module.plugins.treesitter")
		end,
	})

	use("mbbill/undotree")

	use("tpope/vim-fugitive")

--	use("mickael-menu/zk-nvim")

  use {
	  "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
		config = function()
			require("module.plugins.lsp")
		end,
	})

	-- automatically set up the configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)
