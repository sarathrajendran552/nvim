return {
    {
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "snyk_ls", "pylsp", "clangd", "jsonls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
            lspconfig.pylsp.setup({
                capabilities = capabilities
            })
			vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Description under cursor" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
		end,
	},
}
