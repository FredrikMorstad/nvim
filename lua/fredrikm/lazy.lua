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

-- Add plugins
require("lazy").setup({
	-- lsp
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		cmp,
	},

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	"scrooloose/nerdtree",

	-- vim commentary (gcc)
	"tpope/vim-commentary",

	-- colorscheme
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- air and lightline
	"vim-airline/vim-airline",
	"vim-airline/vim-airline-themes",
	"tpope/vim-fugitive",

	-- latex fix latex
	-- "xuhdev/vim-latex-live-preview",
	-- "lervag/vimtex",

	{ "prettier/vim-prettier", build = "yarn install" },

	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

	-- Fuzzy finder
	{ "junegunn/fzf", build = "./install --bin" },
	{ "ibhagwan/fzf-lua", branch = "main", opts = {} },

	-- utils
	{
		"wellle/targets.vim",
		"rhysd/accelerated-jk",
		"tpope/vim-abolish",
		"tpope/vim-surround",
		{ "windwp/nvim-autopairs", opts = {} },
	},

	-- auto format
	"seblj/nvim-formatter",

	-- luaSnip for LSP
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},

	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
	},

	-- git conflict
	{
		"akinsho/git-conflict.nvim",
		-- dev = true,
		-- dir = "~/git-conflict.nvim",
		version = "*",
		config = true,
		-- opts = {
		-- 	default_mapping = false,
		-- 	highlights = {
		-- 		current = "DiffAdd",
		-- 		incoming = "DiffText",
		-- 	},
		-- },
	},
}, {
	ui = { backdrop = 100 },
	install = { colorscheme = { "catppuccin-mocha" } },
})
