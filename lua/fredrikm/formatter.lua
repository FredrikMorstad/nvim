require("formatter").setup({
    format_on_save=function()
        return true
    end,
    filetype={
        javascript = "prettier --stdin-filepath .js",
        typescript = "prettier --stdin-filepath .ts",
        javascriptreact = "prettier --stdin-filepath .jsx",
        typescriptreact = "prettier --stdin-filepath .tsx",
        css = "prettier --stdin-filepath .css",
        scss = "prettier --stdin-filepath .scss",
        html = "prettier --stdin-filepath .html",
        dart = "dart format",
        rust = "rustfmt --edition 2021",
        go = "gofmt",
        lua = "stylua --search-parent-directories -",
        },
})

vim.keymap.set("n", "<leader>p", ":Format<CR>", {desc = "Format file with formatter"})
