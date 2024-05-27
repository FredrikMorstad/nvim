require("formatter").setup({
    format_on_save=function()
        return vim.b.do_format
    end,
    filetype={
        javascript = "prettier --stdin-filepath .js",
        typescript = "prettier --stdin-filepath .ts",
        javascriptreact = "prettier --stdin-filepath .jsx",
        typescriptreact = "prettier --stdin-filepath .tsx",
        css = "prettier --stdin-filepath .css",
        scss = "prettier --stdin-filepath .scss",
        scss = "prettier --stdin-filepath .html",
        dart = "dart format",
        rust = "rustfmt --edition 2021"
        },
})
vim.keymap.set("n", "<leader>p", ":Format<CR>", {desc = "Format file with formatter"})

-- remove after testing formatter!
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = group,
--     pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.css", "*.scss", "*.html" },
--     callback = function()
--         if vim.b.do_format ~= false then
--             vim.cmd("Prettier")
--         end
--     end,
-- })
