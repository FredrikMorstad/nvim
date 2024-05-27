-- markdown preview bindings
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MarkdownGroup", { clear = true }),
    pattern="markdown",
    callback = function()
        vim.keymap.set("n", "mp", ":MarkdownPreview<CR>", {desc = "Start markdown preview"})
        vim.keymap.set("n", "ms", ":MarkdownPreviewStop<CR>", {desc = "Stop markdown preview"})
    end
})
