require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"gopls",
		"ts_ls",
		"dockerls",
		"docker_compose_language_service",
		"terraformls",
		"bashls",
		"clangd",
		"jsonls",
		"markdown_oxide",
		"nginx_language_server",
		"jedi_language_server",
		"sqlls",
		"hydra_lsp",
	},
})

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
	-- set vim as a global  value in the lsp to avoid warnings when configuring vim
	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
	["gopls"] = function()
		require("lspconfig").gopls.setup({
			settings = {
				gopls = {
					analyses = {
						infertypeargs = false,
					},
				},
			},
		})
	end,
})

vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "goto implementation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "goto definitions" })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "hover definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "display refrences" })

-- remove/add imports on save in go files
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		-- silence output
		local orignal = vim.notify
		vim.notify = function(msg, level, opts)
			if msg == "No code actions available" then
				return
			end
			orignal(msg, level, opts)
		end
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
	end,
})
