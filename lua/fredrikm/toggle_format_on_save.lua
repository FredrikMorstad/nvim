
vim.keymap.set("n", "<leader>tf", function()
if vim.b.do_format == nil then
        vim.b.do_format = false
    else
        vim.b.do_format = not vim.b.do_format
    end

    if vim.b.do_format then
        vim.api.nvim_echo({ { "Enabled autoformatting on save" } }, false, {})
    else
        vim.api.nvim_echo({ { "Disabled autoformatting on save" } }, false, {})
    end
end, {desc="Toggle format on save"})

