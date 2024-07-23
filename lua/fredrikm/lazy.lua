-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local cmp = require("fredrikm.lsp.cmp")
vim.api.nvim_set_hl(0, "highlightGroup", { bg = "#ffffff", fg = "#ffffff", sp = "#ffffff" })

-- Add plugins
require("lazy").setup({
	-- lsp
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		cmp,
	},
	-- util
	"terryma/vim-multiple-cursors",
	"wellle/targets.vim",
	"rhysd/accelerated-jk",
	-- 'jiangmiao/auto-pairs',
	"scrooloose/nerdtree",
	{ "windwp/nvim-autopairs", opts = {} },

	-- highlight
	"justinmk/vim-syntax-extra",
	"octol/vim-cpp-enhanced-highlight",
	-- 'numirias/semshi',
	"HerringtonDarkholme/yats.vim",

	-- vim commentary (gcc)
	"tpope/vim-commentary",

	-- colorschemes
	{ "altercation/vim-colors-solarized", priority = 1000 },
	{ "rafi/awesome-vim-colorschemes", priority = 1000 },

	-- this has to be under
	{ "dracula/vim", priority = 1000 },

	-- air and lightline
	"vim-airline/vim-airline",
	"vim-airline/vim-airline-themes",
	"tpope/vim-fugitive",

	-- latex fix latex
	-- 'xuhdev/vim-latex-live-preview',
	-- 'lervag/vimtex',

	{ "prettier/vim-prettier", build = "yarn install" },

	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

	-- Fuzzy finder
	{ "junegunn/fzf", build = "./install --bin" },
	{ "ibhagwan/fzf-lua", branch = "main", opts = {} },

	"seblj/nvim-formatter",

	{
		"tpope/vim-surround",
	},

	"tpope/Vim-abolish",

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},

	-- Flutter
	"nvim-lua/plenary.nvim",
	"stevearc/dressing.nvim", -- for vim.ui.select
	{ "akinsho/flutter-tools.nvim", opts = {} }, -- Dependecy
	-- git conflict
	{
		"akinsho/git-conflict.nvim",
		dev = true,
		dir = "~/git-conflict.nvim",
		version = "*",
		config = true,
		opts = {
			default_mapping = false,
			highlights = {
				current = "highlightGroup",
				incoming = "highlightGroup",
			},
		},
	},
}, {
	ui = { backdrop = 100 },
	install = { colorscheme = { "onedark" } },
})
