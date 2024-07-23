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

vim.opt.undofile = true

vim.opt.completeopt:remove("preview")

require("fredrikm.lazy")
require("fredrikm.lsp.setup")
require("fredrikm.lsp.cmp")
require("fredrikm.keymaps")
require("fredrikm.flutter_config")
require("fredrikm.lang_toggle")
require("fredrikm.markdown_preview")
require("fredrikm.formatter")
require("fredrikm.toggle_format_on_save")
require("fredrikm.git_conflict")
require("fredrikm.airline")

vim.filetype.add({
	filename = {
		["dockerfile.production"] = "dockerfile",
		["dockerfile.development"] = "dockerfile",
		["dockerfile.local"] = "dockerfile",
	},
})

vim.cmd.colorscheme("onedark")

-- "Spell check error color"
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true })

vim.api.nvim_set_hl(0, "SpellRare", {})
