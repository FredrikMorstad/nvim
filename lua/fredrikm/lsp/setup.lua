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
		"sqlls",
		"hydra_lsp",
		"pyright",
	},
})

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	ok and cmp_nvim_lsp.default_capabilities() or {}
)

require("mason-lspconfig").setup_handlers({

	function(server)
		require("lspconfig")[server].setup({ capabilities = capabilities })
	end,
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
	["pyright"] = function()
		require("lspconfig").pyright.setup({
			before_init = function(_, config)
				local venv_path = os.getenv("VIRTUAL_ENV")
				if venv_path then
					config.settings.python = {
						pythonPath = venv_path .. "/bin/python",
					}
				end
			end,
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
