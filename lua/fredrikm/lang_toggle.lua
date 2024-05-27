-- Language toggle
vim.keymap.set('n', '<leader>tl', function()
    local spelllang = vim.opt.spelllang
    if spelllang['_value'] == 'en_us' then
        vim.opt.spelllang = 'nb'
    else
        vim.opt.spelllang = 'en_us'
    end
end, {desc = "Toggle between English and Norwegian"})
