-- Language toggle
vim.keymap.set('n', '<leader>tl', function()
    local spelllang = vim.o.spellang
    if spellang == 'en' then
        vim.opt.spelllang = 'nb'
    else
        vim.opt.spelllang = 'en'
    end
end)
