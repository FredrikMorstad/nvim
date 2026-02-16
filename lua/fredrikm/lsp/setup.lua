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
		"protols",
	},
})

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	ok and cmp_nvim_lsp.default_capabilities() or {}
)

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				infertypeargs = false,
			},
		},
	},
})

vim.lsp.config("pyright", {
	before_init = function(_, config)
		local venv_path = os.getenv("VIRTUAL_ENV")
		if venv_path then
			config.settings.python = {
				pythonPath = venv_path .. "/bin/python",
			}
		end
	end,
})

vim.lsp.config("protols", {
	before_init = function(_, config)
		config.init_options = {
			include_paths = {
				"/Users/fredrik/coop/services-interfaces/",
			},
		}
	end,
})

vim.lsp.config("clangd", {
	filetypes = { "c", "cpp", "objc", "objcpp" },
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
