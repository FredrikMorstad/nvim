call plug#begin('~/.config/nvim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	"util"
	Plug 'terryma/vim-multiple-cursors'
	Plug 'wellle/targets.vim'
	Plug 'rhysd/accelerated-jk'
	" Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdtree'
    Plug 'windwp/nvim-autopairs'

    " highlight"
	Plug 'justinmk/vim-syntax-extra'
	Plug 'octol/vim-cpp-enhanced-highlight'
	" Plug 'numirias/semshi'
	Plug 'HerringtonDarkholme/yats.vim'

	" vim commentary (gcc)"
	Plug 'tpope/vim-commentary'

	" colorschemes"
	Plug 'altercation/vim-colors-solarized'
	Plug 'rafi/awesome-vim-colorschemes'
	"this has to be under"
	Plug 'dracula/vim'

	"air and lightline"
    Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-fugitive'

	"latex fix latex"
	" Plug 'xuhdev/vim-latex-live-preview'
	" Plug 'lervag/vimtex'

	Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    "Fuzzy finder"
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

    Plug 'seblj/nvim-formatter'

    "Flutter"
    Plug 'nvim-lua/plenary.nvim'
    Plug 'stevearc/dressing.nvim' " optional for vim.ui.select
    Plug 'akinsho/flutter-tools.nvim' " Dependecy 

    "git conflict"
    Plug 'akinsho/git-conflict.nvim'

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

set completeopt-=preview "no scratch"

"fix imports on save"
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

lua << EOF
    require("fredrikm.keymaps")
    require("fredrikm.flutter_config")
    require("fredrikm.lang_toggle")
    require("fredrikm.markdown_preview")
    require("fredrikm.formatter")
    require("fredrikm.toggle_format_on_save")
    require("fredrikm.git_conflict")

    local group = vim.api.nvim_create_augroup("MyCustomGroup", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        pattern = "*",
        callback = function()
            vim.opt.formatoptions = vim.opt.formatoptions - 'o' + 'r' + 'c' - 't'
        end,
    })

    require("fzf-lua").setup {} -- use defaults
    require("flutter-tools").setup {} -- use defaults
    require("nvim-autopairs").setup {}
    require("git-conflict").setup {
        default_colors=true,
        highlights = {
            current = 'DiffText',
            incoming = 'DiffAdd',
            ancestor = nil,
        },
    }
    vim.filetype.add({
        filename = {
            ["dockerfile.production"] = "dockerfile",
            ["dockerfile.development"] = "dockerfile",
            ["dockerfile.local"] = "dockerfile",
        },
    })
EOF

"latex"
"live-preview"
let g:livepreview_cursorhold_recompile = 0 "recompile when saving"
let g:livepreview_previewer = 'evince'


"vipy -> vi(P"
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
" let g:semshi#excluded_hl_groups = ['global', 'local']
" let g:semshi#mark_selected_nodes = 0
" let g:semshi#error_sign = 0
" let g:semshi#update_delay_factor = 0.01

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

packloadall
silent! helptags ALL

" Key bindings:"

"Coc"
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gb <C-t>
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"

let g:coc_global_extensions = [ 'coc-json',
    \'coc-tsserver',
    \'coc-vimtex',
    \'coc-styled-components',
    \'coc-pyright',
    \'coc-go',
    \'coc-css',
    \'coc-clangd',
    \'coc-rust-analyzer',]


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

"ctr + / to unhighlight words
nnoremap <silent> <C-/> :nohl<CR><C-l>

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
vnoremap > <gv
vnoremap < >gv

"latex"
"Alt-a to completion with preview"
nnoremap <A-a> :LLPStartPreview<CR>

"<TAB>: completion. tab and shift tab"
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

"something something used in TAB"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" function MyCustomHighlights()
" 	hi semshiUnresolved      ctermfg=100 guifg=#ffff00 cterm=bold gui=bold
" 	hi semshiGlobal      ctermfg=205 guifg= #ffff00
"     hi semshiSelf    ctermfg=205  
" 	hi semshiParameter       ctermfg=75
" 	hi semshiAttribute       ctermfg=75 
" endfunction
" autocmd FileType python call MyCustomHighlights()
"

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

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

