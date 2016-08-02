" TODO omnicpp faq #7
" leader + o to open last tab
" No compatible; better at start!
set nocp
filetype off


"""""""""""""""""""""""""""""
" VUNDLE
"""""""""""""""""""""""""""""
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" :PluginInstall
 set rtp+=~/.vim/bundle/Vundle.vim
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

if v:version >= 703 && has("patch598")
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/nerdTree'
Plugin 'scrooloose/syntastic'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'vim-airline/vim-airline'
Bundle 'jistr/vim-nerdtree-tabs'
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

" Omni
let OmniCpp_NamespaceSearch = 2 " must set 'path' var properly
let OmniCpp_DisplayMode = 0
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Syntastic
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

"""""""""""""""""""""""""""""
" SETTINGS
"""""""""""""""""""""""""""""

" Basic
set showcmd
set showmatch
set ruler
set numberwidth=4
set number
set noshowmode
set cursorline
filetype plugin on
filetype indent on
let mapleader = "\<Space>"
set mouse=a
if filereadable(expand("~/.vimenv"))
    so ~/.vimenv
endif
if isdirectory(expand("~/workspace"))
    set path+=~/workspace/server
else
    set path+=~
endif

" automatically reload vimrc when it's saved

au BufWritePost .vimrc so ~/.vimrc
" Tab
set tabstop=4
set shiftwidth=4
set expandtab

" Smart search
set hlsearch
set incsearch
set ignorecase
set smartcase

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

" Ctrlp bundle
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Movement
" backspace and arrows cross line boundaries
set whichwrap+=<,>,[,]
set scrolloff=7

" Overlength
highlight OverLength ctermbg=NONE ctermfg=NONE cterm=underline guibg=#592929
match OverLength /\%111v.\+/

" Other
set pastetoggle=<F10>

if isdirectory(expand("~/workspace"))
    set tags=~/.vim/stl_tags,~/workspace/server/tags
else
    set tags=~/.vim/stl_tags,~/tags
endif

set wildmenu
set wildmode=list:longest
set tabpagemax=20
set lazyredraw 
set smarttab
set formatoptions-=o
command! W w !sudo tee % > /dev/null

"""""""""""""

"""""""""""""""""""""""""""""
" MAPPING
"""""""""""""""""""""""""""""

"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" <C-k> is free to map
" <C-[> is free to map

" Run ctags
" map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
if isdirectory(expand("~/workspace"))
    map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q+f -f ~/workspace/server/tags<CR>
else
    map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q+f -f ~/tags<CR>
endif


" TODO map to leader+_
" Change name_with_underscores to NamesInCameCase for visually selected text.
" mnemonic *c*amelCase
vmap ,c :s/\%V_\([a-z]\)/\u\1/g<CR>gUl
" :s#_\(\l\)#\u\1#g
" Change CamelCase to name_with_underscore for visually selected text.
" mnemonic *u*nderscores.
vmap ,u :s/\%V\<\@!\([A-Z]\)/\_\l\1/g<CR>gul
" :s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g

" Basic
" inoremap <F1> <Esc>:w<CR>
"as same as cc
nnoremap S :w<CR>
inoremap jk <ESC>
nnoremap <leader>q :set number!<CR>
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
vnoremap . :norm.<CR>
noremap <CR> :

" Tags
map <C-b> :pop<CR>
nmap <F4> :TagbarToggle<CR>

" Replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Movement
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
vnoremap E $
vnoremap B ^
onoremap B ^
onoremap E $

" Move in command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Move in insert mode
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

" {} () search
nnoremap { viBo<Esc>
nnoremap } viB<Esc>
nnoremap ( vibo<Esc>
nnoremap ) vib<Esc>

" Characters / selections shifting
nnoremap <C-h> xhP
"nunmap <C-l>
nnoremap <C-l> xp
vnoremap <C-h> xhP`[v`]
vnoremap <C-l> xp`[v`]

" Tab shifting
vnoremap <tab> >><Esc>1v
nnoremap <tab> >>
nnoremap <S-Tab> <<
vnoremap <S-Tab> <1v
inoremap <S-Tab> <C-d>

" Line moving
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Line join
nnoremap <leader>j J
nnoremap <leader>k i<Esc>

" Esc cancels highlight
" :let @/ = ""
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Folding toggle
nnoremap <Space> za

" Opening / switching tabs
nnoremap J :tabprevious<cr>
vnoremap J <Esc>:tabprevious<cr>
nnoremap K :tabnext<cr>
vnoremap K <Esc>:tabnext<cr>
nnoremap <leader>J :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <leader>K :execute 'silent! tabmove ' . (tabpagenr())<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
nmap <leader>t <C-w><C-]><C-w>T
nmap <leader>f <C-w>gf

" Commenting
vnoremap <leader>c <Esc>a */<Esc>gvo<Esc>i/* <Esc>
vnoremap <leader>x :normal @c
vnoremap <leader>u :s/^\/\///:noh<return>
nnoremap <leader>u :s/^\/\///:noh<return>
nnoremap <leader>c 0i//

" Turn off
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap Q @@
"nnoremap K <nop>

" Smart tab autocomplete
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
endfunction

""""""""""""""""""""""""""""""
" OTHER
""""""""""""""""""""""""""""""

" strips trailing whitespace at the end of files. this
" " is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

""""""""""""""""""""""""""""""
" Source <-> Header
""""""""""""""""""""""""""""""
" expand("%:p:r:s?src?include?")
" :e %<.cpp
function! OpenOther()
    if expand("%:e") == "cpp"
        exe "split" fnameescape(expand("%:p:r:s?src?").".h")
    elseif expand("%:e") == "cc"
        exe "split" fnameescape(expand("%:p:r:s?src?").".h")
    elseif expand("%:e") == "h"
        let src_name = 
        "if filereadable(expand("%:p:r:s?include?src?").".cpp")
        if filereadable(expand("%:p:r:s?src?").".cpp")
            exe "split" fnameescape(expand("%:p:r:s?src?").".cpp")
        elseif filereadable(expand("%:p:r:s?src?").".cc")
            exe "split" fnameescape(expand("%:p:r:s?src?").".cc")
        endif
    endif
endfunction

nmap <leader>h :call OpenOther()<CR>

""""""""""""""""""""""""""""""
" Visual mode related
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
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
"""""""""""""""""""""""""""""

" Underline actual line in insert mode
"autocmd InsertLeave * se nocul
"autocmd InsertEnter * se cul


" Omni completion
" set ofu=syntaxcomplete#Complete

" Airline bundle
"let g:airline_powerline_fonts=1
"set laststatus=2
"let g:airline_theme='hybrid'
"let g:airline#extensions#tabline#enabled=1

" Markdown bundle
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_initial_foldlevel=1


" Tagbar bundle
"nmap <C-m> :TagbarToggle<CR>

" Nerdtree bundle
"map <C-n> :NERDTreeToggle<CR>

