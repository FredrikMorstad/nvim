call plug#begin()
	Plug 'kien/ctrlp.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'jiangmiao/auto-pairs'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'rhysd/accelerated-jk'
	Plug 'wellle/targets.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'justinmk/vim-syntax-extra'
	Plug 'tpope/vim-commentary'
	Plug 'altercation/vim-colors-solarized'
	Plug 'rafi/awesome-vim-colorschemes'
	Plug 'w0rp/ale'
	Plug 'dracula/vim'
	Plug 'itchyny/lightline.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-fugitive'

	
call plug#end()
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set number relativenumber
set mouse=a
syntax on
set t_Co=256
set background=dark
colorscheme dracula
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.linenr = '☰'
let g:airline_left_sep = '»'
let g:airline_symbols.dirty='!'
let g:airline_symbols.maxlinenr = ' ㏑'

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
let g:airline_theme='jellybeans'
let g:deoplete#enable_at_startup = 1
packloadall
silent! helptags ALL

"Key bindings:
"
"
"
"
nnoremap nt :NERDTreeToggle<CR>
"ctr + l = unhighlight words
nnoremap <silent> <C-l> :nohl<CR><C-l>
"ctr + n = new tab
nnoremap <C-t> :tabedit<CR>
"tab = go to next tab
nnoremap <tab> :tabn<CR>
"shift + tab = go to previous tab
nnoremap <S-tab> :tabp<CR>
"shift + j = jump half page down
nnoremap <S-J> <C-D>                                                        
"shift + k = jump half page up
nnoremap <S-K> <C-U>   

"Alt + j = move line down
nnoremap <A-j> :m.+1<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi

"Alt + k = move line up
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-k> <Esc>:m .-2<CR>==gi

"; = execute previous command
nnoremap ; :<UP><CR>

"r + w = replace inner word
nnoremap rw viwp

"= = end of line (normal mode)
nnoremap = $

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"ctr + {number} = go to that tab (ctr + 0 goes to last tab)
function Tabber()
	for i in range(0, 10)
		if i == 0
			let s:cmd = 'nnoremap <A-' . 0 . '> ' . 1 . 'gt \| :tabp<CR>'
		else
			let s:cmd = 'nnoremap <A-' . i . '> ' . i . 'gt'
		endif
		execute s:cmd
	endfor
endfunction

call Tabber()
