require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "go", "rust", "kotlin", "java" },
	auto_install = true,
})

-- important: enables treesitter to start in the new buffer
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		if not pcall(vim.treesitter.start, args.buf) then
-- 			return
-- 		end
-- 	end,
-- })
