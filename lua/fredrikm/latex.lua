-- "latex"
-- "live-preview"
vim.g.livepreview_cursorhold_recompile = 0 -- recompile when saving
vim.g.livepreview_previewer = "evince"

-- "vipy -> vi(P"
-- "vimtex"
vim.g.vimtex_compiler_progname = "nvr"
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_mode = 0

-- "Alt-a to latex compile and with preview"
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

