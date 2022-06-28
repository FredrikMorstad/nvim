call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
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
	Plug 'HerringtonDarkholme/yats.vim'

	" vim commentary (gcc)"
	Plug 'tpope/vim-commentary'

	" colorschemes"
	Plug 'altercation/vim-colors-solarized'
	Plug 'rafi/awesome-vim-colorschemes'
	"this has to be under"
	Plug 'dracula/vim'

	"linter"
	" Plug 'w0rp/ale'

	"air and lightline"
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-fugitive'

	"latex"
	Plug 'xuhdev/vim-latex-live-preview'
	Plug 'lervag/vimtex'

	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

	call plug#end()

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set number relativenumber
set mouse=a
syntax enable
set spell spelllang=en_us
set t_Co=256
set background=dark
set termguicolors
colorscheme onedark
filetype plugin on
set cmdheight=2
set signcolumn=yes
set splitright
set splitbelow

set noswapfile

set shortmess+=c

"More undos"
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

let mapleader = " "

set completeopt-=preview "no scratch"

"latex"
"live-preview"
let g:livepreview_cursorhold_recompile = 0 "recompile when saving"
let g:livepreview_previewer = 'evince'

"vimtex"
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
let g:vimtex_quickfix_mode = 0

" Clean latex files when quitting file
" augroup vimtex_config
"     au!
"     au User VimtexEventQuit call vimtex#compiler#clean(0)
" augroup END

let g:airline#extensions#coc#enabled = 0

"Semshi"
let g:semshi#excluded_hl_groups = ['global', 'local']
let g:semshi#mark_selected_nodes = 0
let g:semshi#error_sign = 0
let g:semshi#update_delay_factor = 0.01

let g:python3_host_prog = '/usr/bin/python3.10'

let g:airline_theme='onedark'

let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                                                           
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right                                                           
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline


"Spell check error color"
autocmd BufRead,BufNewFile *.bashrc setlocal nospell

hi clear SpellBad
hi SpellBad cterm=underline
	:highlight clear SpellBad
	:highlight SpellBad  ctermfg=196 cterm=underline
hi SpellBad gui=undercurl

hi clear SpellCap
hi SpellCap cterm=underline
	:highlight clear SpellCap
	:highlight SpellCap  ctermfg=196 cterm=underline
hi SpellCap gui=undercurl

hi clear SpellRare

"Nerdtree"
let g:NERDTreeChDirMode = 2
packloadall
silent! helptags ALL

" Key bindings:"

" alt+l to the right-window"
nnoremap <A-l> <C-w><RIGHT>
"alt+h arrown to move to the left-window"
nnoremap <A-h> <C-w><LEFT>

"nt to go to nt"
nnoremap <leader>t 1<C-w>w
"tnt to toggle nerdtree"
nnoremap <leader>n :NERDTreeToggle<CR>
"rnt to refresh nerdtree root"
nnoremap rnt :NERDTreeRefreshRoot<CR>

"Coc"
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gb <C-t>
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"

nnoremap <silent> gh :call <SID>show_documentation()<CR>

autocmd BufWritePre *.go call CocAction("format")

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"ctr + l = unhighlight words
nnoremap <silent> <C-l> :nohl<CR><C-l>

"ctr + n = new tab
nnoremap <C-t> :tabedit<CR>
"tab = go to next tab
nnoremap <tab> :tabn<CR>
"shift + tab = go to previous tab
nnoremap <S-tab> :tabp<CR>
"Fix"
" nnoremap <C-i> gg=G

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
" nnoremap = $
"multi line tab in"
vnoremap < <gv
vnoremap > >gv
"latex"
"Alt-a to completion with preview"
nnoremap <A-a> :LLPStartPreview<CR>

"<TAB>: completion. tab and shift tab"
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>" 

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

