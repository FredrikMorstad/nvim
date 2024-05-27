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

-- Add plugins
require("lazy").setup({
	{ "neoclide/coc.nvim", branch = "release" },

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

	-- Flutter
	"nvim-lua/plenary.nvim",
	"stevearc/dressing.nvim", -- for vim.ui.select
	{ "akinsho/flutter-tools.nvim", opts = {} }, -- Dependecy

	-- git conflict
	{
		"akinsho/git-conflict.nvim",
		opts = {

			default_colors = true,
			highlights = {
				current = "DiffText",
				incoming = "DiffAdd",
				ancestor = nil,
			},
		},
	},
}, {
	ui = { backdrop = 100 },
	install = { colorscheme = { "onedark" } },
})

vim.cmd.colorscheme("onedark")

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.termguicolors = true

vim.opt.cmdheight = 2
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.swapfile = false
vim.opt.shortmess:append("c")

-- More undos
vim.opt.undofile = true
vim.opt.undodir = "$HOME/.vim/undo"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.completeopt:remove("preview")

require("fredrikm.keymaps")
require("fredrikm.flutter_config")
require("fredrikm.lang_toggle")
require("fredrikm.markdown_preview")
require("fredrikm.formatter")
require("fredrikm.toggle_format_on_save")
require("fredrikm.git_conflict")

local group = vim.api.nvim_create_augroup("MyCustomGroup", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = group,
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r" + "c" - "t"
	end,
})

vim.filetype.add({
	filename = {
		["dockerfile.production"] = "dockerfile",
		["dockerfile.development"] = "dockerfile",
		["dockerfile.local"] = "dockerfile",
	},
})

-- "latex"
-- "live-preview"
vim.g.livepreview_cursorhold_recompile = 0 -- recompile when saving
vim.g.livepreview_previewer = "evince"

-- "vipy -> vi(P"
-- "vimtex"
vim.g.vimtex_compiler_progname = "nvr"
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_mode = 0
-- "Alt-a to completion with preview"
vim.keymap.set("n", "<A-a>", "LLPStartPreview<CR>")

-- Clean latex files when quitting file
vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "VimtexEventQuit",
	callback = function()
		vim.cmd.VimtexClean()
	end,
	desc = "Clean up latex files",
})

vim.g.python3_host_prog = "/usr/bin/python3.10"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = group,
	pattern = "*.bashrc",
	command = "setlocal spell",
})

-- "Spell check error color"
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true })

vim.api.nvim_set_hl(0, "SpellRare", {})

-- Key bindings:
-- Coc
vim.keymap.set("n", "gd", "<Plug>(coc-definition)")
vim.keymap.set("n", "gr", "<Plug>(coc-references)")
vim.keymap.set("n", "gb", "<C-t>")
vim.keymap.set(
	"i",
	"<CR>",
	[[coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"]],
	{ expr = true }
)

vim.g.coc_global_extensions = {
	"coc-json",
	"coc-tsserver",
	"coc-vimtex",
	"coc-styled-components",
	"coc-pyright",
	"coc-go",
	"coc-css",
	"coc-clangd",
	"coc-rust-analyzer",
}

vim.keymap.set("n", "gh", function()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end)

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*.go",
	callback = function()
		vim.cmd("silent call CocAction('runCommand', 'editor.action.organizeImport')")
		vim.cmd("call CocAction('format')")
	end,
})

-- "ctr + / to unhighlight words
vim.keymap.set("n", "<C-/>", ":nohl<CR><C-l>")

-- "= = end of line (normal mode)
vim.keymap.set("n", "=", "$")

-- Used in tab-mapping
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- <TAB>: completion. tab and shift tab
vim.keymap.set(
	"i",
	"<TAB>",
	'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
	{ expr = true }
)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true })

-- Semshi
-- vim.g["semshi#excluded_hl_groups"] = { "global", "local" }
-- vim.g["semshi#mark_selected_nodes"] = 0
-- vim.g["semshi#error_sign"] = 0
-- vim.g["semshi#update_delay_factor"] = 0.01
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = group,
-- 	pattern = "python",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "semshiUnresolved", { fg = "#ffff00", bold = true })
-- 		vim.api.nvim_set_hl(0, "semshiGlobal", { fg = "#ffff00" })
-- 	end,
-- })

vim.g.airline_theme = "onedark"

vim.g["airline#extensions#coc#enabled"] = 0

vim.g["airline#extensions#tabline#enabled"] = 1 -- enable airline tabline
vim.g["airline#extensions#tabline#show_close_button"] = 0 -- remove 'X' at the end of the tabline
vim.g["airline#extensions#tabline#tabs_label"] = "" -- can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
vim.g["airline#extensions#tabline#buffers_label"] = "" -- can put text here like TABS to denote tabs (I clear it so nothing is shown)
vim.g["airline#extensions#tabline#fnamemod"] = ":t" -- disable file paths in the tab
vim.g["airline#extensions#tabline#show_tab_count"] = 0 -- dont show tab numbers on the right
vim.g["airline#extensions#tabline#show_buffers"] = 0 -- dont show buffers in the tabline
vim.g["airline#extensions#tabline#tab_min_count"] = 2 -- minimum of 2 tabs needed to display the tabline
vim.g["airline#extensions#tabline#show_splits"] = 0 -- disables the buffer name that displays on the right of the tabline
vim.g["airline#extensions#tabline#show_tab_nr"] = 0 -- disable tab numbers
vim.g["airline#extensions#tabline#show_tab_type"] = 0 -- disables the weird ornage arrow on the tabline

-- air-line shows the current branch
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#branch#empty_message"] = ""
vim.g["airline#extensions#ale#enabled"] = 1

-- "Font for symbols"
vim.g.airline_powerline_fonts = 1
if not vim.g.airline_symbols then
	vim.g.airline_symbols = {}
end

vim.g.airline_symbols.branch = ""
vim.g.airline_symbols.notexists = "Ɇ"
vim.g.airline_symbols.linenr = "☰"
vim.g.airline_left_sep = "»"
vim.g.airline_symbols.dirty = "!"
vim.g.airline_symbols.maxlinenr = " ㏑"
vim.g.airline_symbols.paste = "ρ"
