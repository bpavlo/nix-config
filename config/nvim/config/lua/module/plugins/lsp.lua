local lsp = require("lsp-zero").preset({})
lsp.preset("recommended")

lsp.ensure_installed({
  'bashls', -- bash
  'clangd', -- c, c++
  'cssls', -- css
  'eslint', -- js
  'html', -- html
  'jdtls', -- java
  'marksman', -- markdown
  'nil_ls', -- nix
  'rust_analyzer', -- rust
  'lua_ls',
  'gopls', -- go
  'terraformls', -- terraform
  'elixirls', -- elixir
})

require'lspconfig'.marksman.setup{}

lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
			},
		},
	},
})


local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = {
		["<Tab>"] = cmp_action.tab_complete(),
		["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})
lsp.set_preferences({
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
})
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()
