call plug#begin()
	Plug 'omnisharp/omnisharp-vim'

	"Deoplete"
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
	Plug 'deoplete-plugins/deoplete-jedi'
	Plug 'zchee/deoplete-clang'
	Plug 'mbbill/echofunc'

	"util"
	Plug 'terryma/vim-multiple-cursors'
	Plug 'wellle/targets.vim'
	Plug 'rhysd/accelerated-jk'
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdtree'
	
	" highlight"
	Plug 'justinmk/vim-syntax-extra'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'numirias/semshi'

	
	" vim commentary (gcc)"
	Plug 'tpope/vim-commentary'


	" colorschemes"
	Plug 'altercation/vim-colors-solarized'
	Plug 'rafi/awesome-vim-colorschemes'
	"this has to be under"
	Plug 'dracula/vim'

	"linter"
	Plug 'w0rp/ale'

	"air and lightline"
	Plug 'itchyny/lightline.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-fugitive'

	"latex"
	Plug 'xuhdev/vim-latex-live-preview'
	Plug 'lervag/vimtex'

	call plug#end()

set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set number relativenumber
set mouse=a
syntax enable
set spell spelllang=en_us
set t_Co=256
set background=dark
colorscheme dracula

set noswapfile

"More undos"
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

"Deoplete"
let g:python3_host_prog = "/usr/bin/python3.6"
let g:deoplete#sources#clang#libclang_path='/usr/lib/rstudio/bin/rsclang/libclang.so'
set completeopt-=preview "no scratch"

"latex"
"live-preview"
let g:livepreview_cursorhold_recompile = 0 "recompile when saving"
let g:livepreview_previewer = 'evince'

"Semshi"
let g:semshi#excluded_hl_groups = ['global', 'local']
let g:semshi#mark_selected_nodes = 0
let g:semshi#error_sign = 0
let g:semshi#update_delay_factor = 0.01

"Spell check error color"
hi clear SpellBad
hi SpellBad cterm=underline
	:highlight clear SpellBad
	:highlight SpellBad  ctermfg=196 cterm=underline
hi SpellBad gui=undercurl

hi clear SpellCap
hi SpellBad cterm=underline
	:highlight clear SpellCap
	:highlight SpellCap  ctermfg=196 cterm=underline
hi SpellCap gui=undercurl

"Ale"
"always have a column"
let g:ale_sign_column_always = 1
let g:deoplete#enable_at_startup = 1

"Nerdtree"
let g:NERDTreeChDirMode = 2
packloadall
silent! helptags ALL

" Key bindings:"

"alt+l to the right-window"
nnoremap <A-l> <C-w><RIGHT>
"alt+h arrown to move to the left-window"
nnoremap <A-h> <C-w><LEFT>

"nt to go to nt"
nnoremap nt 1<C-w>w
"tnt to toggle nerdtree"
nnoremap tnt :NERDTreeToggle<CR>
"rnt to refresh nerdtree root"
nnoremap rnt :NERDTreeRefreshRoot<CR>

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

"= = end of line (normal mode)
nnoremap = $

"latex"
"Alt-a to completion with preview"
nnoremap <A-a> :LLPStartPreview<CR>

"<TAB>: completion."
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

function MyCustomHighlights()
	hi semshiUnresolved      ctermfg=100 guifg=#ffff00 cterm=bold gui=bold
	hi semshiGlobal      ctermfg=205 guifg= #ffff00
    hi semshiSelf    ctermfg=205  
	hi semshiParameter       ctermfg=75
	hi semshiAttribute       ctermfg=75 
endfunction
autocmd FileType python call MyCustomHighlights()

"air-line"
"shows the current branch"
let g:lightline = { 'colorscheme': 'icebergDark' }
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ale#enabled = 1
"Font for symbols"
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.linenr = '☰'
let g:airline_left_sep = '»'
let g:airline_symbols.dirty='!'
let g:airline_symbols.maxlinenr = ' ㏑'
let g:airline_symbols.paste = 'ρ'
"lightline colorscheme"
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
