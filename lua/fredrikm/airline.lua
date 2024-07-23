
vim.g.airline_theme = "onedark"

-- vim.g["airline#extensions#coc#enabled"] = 0

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
