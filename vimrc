" No compatible; better at start!
set nocp
filetype off


" Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" :PluginInstall
 set rtp+=~/.vim/bundle/Vundle.vim
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Optional:
"   Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this

"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

set tags=~/workspace/server/tags

set cursorline

set tabpagemax=20

map <C-b> :pop<CR>

" inoremap <F1> <Esc>:w<CR>
nnoremap S :w<CR>
"as same as cc

" <C-k> is free to map
" <C-[> is free to map

nnoremap Q <nop>

" :let @/ = ""
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

"MAP {} () they are useless
nnoremap { viBo<Esc>
nnoremap } viB<Esc>

" MOVEMENT
" " allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,[,]
set so=7
" --------

set lazyredraw 
let mapleader = "\<Space>"

nnoremap K <nop>

set smarttab

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

command! W w !sudo tee % > /dev/null

vnoremap . :norm.<CR>

""""""""""""""""""""""""""""""
" => Source <-> Header
""""""""""""""""""""""""""""""
function! OpenOther()
    if expand("%:e") == "cpp"
        exe "split" fnameescape(expand("%:p:r:s?src?include?").".h")
    elseif expand("%:e") == "cc"
        exe "split" fnameescape(expand("%:p:r:s?src?include?").".h")
    elseif expand("%:e") == "h"
        let src_name = 
        if filereadable(expand("%:p:r:s?include?src?").".cpp")
            exe "split" fnameescape(expand("%:p:r:s?include?src?").".cpp")
        elseif filereadable(expand("%:p:r:s?include?src?").".cc")
            exe "split" fnameescape(expand("%:p:r:s?include?src?").".cc")
        endif
    endif
endfunction

nmap ,o :call OpenOther()<CR>
"""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'.
        l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" =
    l:saved_reg
endfunction
"""""""""""""""""""""""""""""


nnoremap <leader><tab> >>
vnoremap <leader><tab> >>
nnoremap <S-Tab> <<
vnoremap <S-Tab> <1v
inoremap <S-Tab> <C-d>

"Move characters / selections
nnoremap <C-h> xhP
"nunmap <C-l>
nnoremap <C-l> xp
vnoremap <C-h> xhP`[v`]
vnoremap <C-l> xp`[v`]

"Mappings to move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" This is for opening new tabs or switching between tabs
nnoremap <F2> :tabprevious<CR>
vnoremap <F2> <Esc>:tabprevious<CR>
nnoremap <Leader><F2> :tabm-1<CR>
nnoremap <F3> :tabnext<CR>
vnoremap <F3> <Esc>:tabnext<CR>
nnoremap <Leader><F3> :tabm+1<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <F2> <Esc>:tabprevious<CR>i
inoremap <F3> <Esc>:tabnext<CR>i
inoremap <C-t> <Esc>:tabnew<CR>

" Tab width and tab width for autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" Smart search stuff
set hlsearch
set incsearch
set ignorecase
set smartcase

set showcmd
set showmatch
set ruler

" Line numbering
set numberwidth=4
set number

" Underline actual line in insert mode
"autocmd InsertLeave * se nocul
"autocmd InsertEnter * se cul

filetype plugin on
filetype indent on

set pastetoggle=<F10>
set noshowmode

" Folding toggle
nnoremap <Space> za

" ESC to jk
inoremap jk <ESC>

" Omni completion
" set ofu=syntaxcomplete#Complete

" Run ctags
" map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/workspace/server/tags<CR>

" GUI
if has('gui_running')
    set guifont=Monaco\ for\ Powerline\ 12
    " Remove menu bar
    set guioptions-=m
    " Remove toolbar
    set guioptions-=T
endif

" Access colors present in 256 colorspace
let base16colorspace=256
"set t_Co=256
"set background=dark
colorscheme violetees "koehler delek zellner peachpuff
syntax on

" Highlight redundant whitespaces
hi redundant_spaces ctermbg=blue guibg=blue
match redundant_spaces /\s\+$\| \+\ze\t/

" Change name_with_underscores to NamesInCameCase for visually selected text.
" mnemonic *c*amelCase
vmap ,c :s/\%V_\([a-z]\)/\u\1/g<CR>gUl
" :s#_\(\l\)#\u\1#g
" Change CamelCase to name_with_underscore for visually selected text.
" mnemonic *u*nderscores.
vmap ,u :s/\%V\<\@!\([A-Z]\)/\_\l\1/g<CR>gul
" :s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g

" Airline bundle
"let g:airline_powerline_fonts=1
"set laststatus=2
"let g:airline_theme='hybrid'
"let g:airline#extensions#tabline#enabled=1

" Markdown bundle
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_initial_foldlevel=1

" Ctrlp bundle
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Tagbar bundle
"nmap <C-m> :TagbarToggle<CR>

" Nerdtree bundle
"map <C-n> :NERDTreeToggle<CR>

highlight OverLength ctermbg=NONE ctermfg=NONE cterm=underline guibg=#592929
match OverLength /\%121v.\+/

