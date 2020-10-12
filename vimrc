"set nocp " better at start!
filetype off

"""""""""""""""""""""""""""""
" VUNDLE
"""""""""""""""""""""""""""""
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" :PluginInstall
if isdirectory(expand("$HOME/vimfiles/bundle/"))
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$HOME/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'mhinz/vim-startify'
Plugin 'kien/ctrlp.vim'
Plugin 'morhetz/gruvbox'
"Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdTree'
"TODO does it work with ycm?
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
"Bundle 'jistr/vim-nerdtree-tabs'

Plugin 'tpope/vim-dispatch'

"Plugin 'ludovicchabant/vim-gutentags'
"https://dmitryfrank.com/articles/vim_project_code_navigation
"Plugin 'vim-scripts/indexer.tar.gz'
"Plugin 'vim-scripts/vimprj'
"Plugin 'vim-scripts/DfrankUtil'

Plugin 'easymotion/vim-easymotion'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-fugitive'
Plugin 'gregsexton/gitv'
"Plugin 'junegunn/vim-easy-align'
"TODO lin only
"Plugin 'KabbAmine/vCoolor.vim'
"Plugin 'ervandew/supertab'
Plugin 'airblade/vim-gitgutter'
Plugin 'thinca/vim-localrc'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'auto-pairs-gentle'
Plugin 'wesQ3/vim-windowswap'
"Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'urbainvaes/vim-tmux-pilot'
Plugin 'tommcdo/vim-exchange'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-indent'
Plugin 'tpope/vim-commentary'
Plugin 'benmills/vimux'
Plugin 'mattboehm/vim-unstack'
"Plugin 'wakatime/vim-wakatime'
Plugin 'vimwiki/vimwiki'
Plugin 'tyru/open-browser.vim'
Plugin 'jeetsukumaran/vim-pythonsense'
Plugin 'psf/black'
Plugin 'kreskij/vim-reminder-tips'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'khzaw/vim-conceal'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'stsewd/fzf-checkout.vim'

"Plugin 'gilligan/vim-lldb'
"TRY:
"Plugin 'gisodal/vimgdb'
"Plugin 'huawenyu/neogdb.vim'
"http://www.vim.org/scripts/script.php?script_id=3039

"Plugin 'vim-scripts/OmniCppComplete'
"Plugin 'Rip-Rip/clang_complete'

"if v:version >= 703 && has("patch598")
"Plugin 'Valloric/YouCompleteMe'
"endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Setting leader here so it works for plugins
let mapleader = "\<Space>"

"""""""""""""""""""""""""""""
" PLUGIN SETTINGS
"""""""""""""""""""""""""""""

" fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

"Vim Reminder Tips
call reminder_tips#Setup()
"AddImportantTip 'Example Important Tip'
AddReminderTip 'Lookbehind: \(whats before\)\@<=text'
AddReminderTip 'Lookahead: \(whats before\)\@=text'
AddReminderTip 'Negative Lookbehind: \(whats before\)\@<!text'
AddReminderTip 'Negative Lookahead: \(whats before\)\@!text'
"AddReminderTip 'Very magic Lookbehind: \v(whats before)@<=text'
AddReminderTip 'Turn on regex magic to give literal meaning to symbols: \v'
AddReminderTip 'Convert to unix: w ++ff=unix'
AddReminderTip '[Text Object] Inside Function: if'
AddReminderTip '[Text Object] Around Function: af'
AddReminderTip '[Text Object] Inside Class: ic'
AddReminderTip '[Text Object] Around Class: ac'
AddReminderTip '[Text Object] ]] : Move (forward) to the beginning of the next Python class.'
AddReminderTip '[Text Object] ][ : Move (forward) to the end of the current Python class.'
AddReminderTip '[Text Object] [[ : Move (backward) to beginning of the current Python class.'
AddReminderTip '[Text Object] [] : Move (backward) to end of the previous Python class.'
AddReminderTip '[Text Object] ]m : Move (forward) to the beginning of the next Python method or function.'
AddReminderTip '[Text Object] ]M : Move (forward) to the end of the current Python method or function.'
AddReminderTip '[Text Object] [M : Move (backward) to the end of the previous Python method or function.'
AddReminderTip 'Go to Current file Directory: <leader>gcd'

" WindowSwap: want immediate <leader>p for paste
let g:windowswap_map_keys = 0

" Vimux
let g:VimuxOrientation = "h"
let g:VimuxUseNearest = 1
map <leader>vp :call VimuxRunCommand("")<CR>
map <leader>vl :VimuxRunLastCommand<CR>
map <leader>vx :VimuxInterruptRunner<CR>
function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys("Enter")
endfunction
vmap <leader>vr "vy :call VimuxSlime()<CR>
function! VimuxRepeat()
    call VimuxSendKeys("C-p")
    call VimuxSendKeys("Enter")
endfunction
map <leader>vr :call VimuxRepeat()<CR>

" Slime
let g:slime_target = "tmux"

" Easymotion
map <Leader>, <Plug>(easymotion-prefix)

"Git (fugitive)
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gs :Gstatus<CR>

"YouCompleteMe
nnoremap <leader>gd :tab YcmCompleter GoToDefinition<CR>

" Vim stacktrace
let g:unstack_mapkey='<leader>ss'

"TODO remove
" Vim-Tmux-Pilot

"" Uncomment to enable navigation of vim tabs
"let g:pilot_mode='wintab'

"" Uncomment to enable creation of vim splits automatically
"let g:pilot_boundary='create'

"let g:tmux_navigator_no_mappings = 1

"nnoremap <silent> ì :TmuxNavigateLeft<cr>
"nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
"nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
"nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" A useful mapping to use with this plugin
" nnoremap <nowait> <c-d> :q<cr>

" system specific
if filereadable(expand("~/.vim/otherrc"))
    source ~/.vim/otherrc
endif

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_confirm_extra_conf = 0

"auto-pairs
let g:AutoPairsUseInsertedCount = 1
noremap <leader>ap :call AutoPairsToggle()<CR>
inoremap <C-e> <C-R>=AutoPairsFastWrap()<CR>
inoremap <C-]> <C-R>=AutoPairsShortcutJump()<CR>

" Omni
let OmniCpp_NamespaceSearch = 2 " must set 'path' var properly
let OmniCpp_DisplayMode = 0
"OmniFAQ: automatically close the preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Syntastic
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_java_checkers = []
let g:syntastic_python_checkers = ['pyflakes']

" Clang complete
let g:clang_library_path = "/usr/lib/llvm-3.8/lib/libclang.so"

"OpenBrowser
"open vim repo
function! OpnB()
    let s:var = trim(expand('<cWORD>'), "'")
    execute ":OpenBrowser http://github.com/" . s:var
endfunction
noremap <leader>ov :call OpnB()<CR>

"VimWiki
let g:vimwiki_list = [{'path': '~/my/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_map_prefix = '<Leader>e'
autocmd BufEnter *.md exe 'noremap <F5> :!/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome %:p<CR>'

" NERDCommenter
" Comment line, edit line
"noremap <leader>ce yyP<plug>NERDCommenterComment<C-o>C

" Nerdtree bundle, NERDTree mappings:
nnoremap <leader>n :NERDTree<CR>
let g:NERDTreeMapJumpFirstChild = 'H'
let g:NERDTreeMapJumpLastChild = 'L'
let g:NERDTreeWinPos = 'right'
"autocmd BufWinEnter * NERDTreeMirror
" close on file close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
      \ && b:NERDTreeType == "primary") | q | endif


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
set laststatus=2
set rulerformat=#%n\ %l,%c%V%=%P
set splitbelow
set splitright
filetype plugin on
set mouse=a
set path+=~
set backspace=indent,eol,start " fix backspace
"is said to show whitespace at the EOL
set listchars+=trail:-
set history=500

" automatically reload vimrc when it's saved TODO fix sequential save freeze
"au BufWritePost .vimrc so ~/.vimrc

" Tab
set tabstop=4
set shiftwidth=4
set expandtab
"?
set autoindent

" Smart search
set hlsearch
set incsearch
set ignorecase
set smartcase

"highlight 100th column
"TODO dont wrap on next line
set colorcolumn=100

" Highlight redundant whitespaces
hi redundant_spaces ctermbg=blue guibg=blue
autocmd ColorScheme * highlight redundant_spaces ctermbg=red guibg=red
"/\s\+$\| \+\ze\t/
match redundant_spaces  /\s\+\%#\@<!$/

" Access colors present in 256 colorspace
let base16colorspace=256
"set background=dark
syntax on "has to be before colorscheme

colorscheme gruvbox
set background=dark
" Fixes new tmux config pane in vim
if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux'  )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
endif
if has("unix")
    if system("uname -s") =~ "Darwin"
        hi Normal guibg=NONE ctermbg=NONE
        set termguicolors
    endif
endif
"TODO check for truecolor
set t_Co=256
" fixes issue with black lines after text in non-black colorscheme
let &t_ut=''

" GUI
if has('gui_running')
    "set guifont=Monaco\ for\ Powerline\ 12
    set guifont=Monospace\ 12
    set lines=999 columns=999
    " Remove menu bar
    set guioptions-=m
    " Remove toolbar
    set guioptions-=T
    au GUIEnter * simalt ~x
endif

" Ctrlp bundle
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_lazy_update = 1
let g:ctrlp_clear_cache_on_exit = 0

" Movement
" backspace and arrows cross line boundaries
set whichwrap+=<,>,[,]
set scrolloff=7

" Other
set pastetoggle=<F10>

"dont search in folds
set fdo-=search

" Don't start new comment on a new line
au FileType c,cpp setlocal comments-=:// comments+=f://

set tags=./.tags,./tags,~/.tags

set wildmenu
set wildmode=list:longest,full
set wildignore+=.git                             " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store
set tabpagemax=20
set lazyredraw
set smarttab
set formatoptions-=o
command! W w !sudo tee % > /dev/null

"""""""""""""

"""""""""""""""""""""""""""""
" MAPPING
"""""""""""""""""""""""""""""
" <C-[> is free to map

" Run ctags
" map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"TODO work in tmux
if isdirectory(expand("~/danube"))
    map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q+f -f ~/danube/tags<CR>
else
    map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q+f -f ~/tags<CR>
endif

" Basic
vnoremap < <gv
vnoremap > >gv
nnoremap S :w<CR>
nnoremap zx :q<CR>
inoremap jk <ESC>
inoremap JK <ESC>
inoremap jK <ESC>
inoremap Jk <ESC>
nnoremap <leader>q :set number!<CR>
nnoremap <leader>sp :set syntax=python<CR>
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
vnoremap . :norm.<CR>
nnoremap <CR> :
vnoremap <CR> :
noremap <silent> zp "+[p
nnoremap <silent> zy "+yy
vnoremap <silent> zy "+y
nnoremap <leader>rc :execute 'tabe ' . resolve(expand($MYVIMRC))<CR>
nnoremap <leader>oz :tabe ~/.zshrc<CR>
nnoremap <leader>ozz :tabe ~/.config/z_*<CR>
nnoremap <leader>sr :source $MYVIMRC<cr>
nnoremap <leader>os :tabe ~/.config/surf.js<CR>

"cnoremap <C-A> <HOME>
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap qq q!
"cnoremap <C-g>  <C-c>noremap <C-D> <DEL>
cabbrev h tab help

"TODO testing default global yank
"nnoremap Y y$

"System clipboard interaction
if system("uname -s") =~ "Linux"
    nnoremap Y "+y$
    vnoremap <leader>y "+y
    noremap <leader>y "+yy
    noremap <leader>p o<Esc>:set paste<CR>"+p<CR>:set nopaste<CR>
    noremap <leader>P O<Esc>:set paste<CR>"+P<CR>:set nopaste<CR>
else
    nnoremap Y "*y$
    vnoremap <leader>y "*y
    noremap <leader>y "*yy
    noremap <leader>p o<Esc>:set paste<CR>"*p<CR>:set nopaste<CR>
    noremap <leader>P O<Esc>:set paste<CR>"*P<CR>:set nopaste<CR>
endif

" Tags
map <C-b> :pop<CR>
nmap <F4> :TagbarToggle<CR>
map <silent> gf :tabf <cfile><CR>
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T


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

" Move in insert mode
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

" {} () search
"nnoremap { viBo<Esc>^ "these are [{, }]
"nnoremap } viB<Esc>^
nnoremap ( vibo<Esc>
nnoremap ) vib<Esc>

" Characters / selections shifting
nnoremap <C-h> hxph
nnoremap <C-l> xp
vnoremap <C-h> xhP`[v`]
vnoremap <C-l> xp`[v`]

" Tab shifting; dont change <leader><tab> - intereferes with <C-i>
vnoremap <leader><tab> >><Esc>1v
nnoremap <leader><tab> >>
vnoremap <leader>> >><Esc>1v
nnoremap <leader>> >>
nnoremap <leader>< <<
vnoremap <leader>< <1v
inoremap <S-Tab>< <C-d>

" Line moving
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Line join
" TODO remove space after (
nnoremap <leader>j J

" TODO
"%!python -m json.tool

nnoremap <leader><leader> :noh<CR>:pc<CR>
" TODO immediate ESC
"nnoremap <esc>^[ <esc>^[

" Opening / switching tabs
nnoremap J :tabprevious<cr>
"vnoremap J <Esc>:tabprevious<cr>
vnoremap J nop
nnoremap K :tabnext<cr>
"vnoremap K <Esc>:tabnext<cr>
vnoremap K nop
nnoremap <leader>J :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
if !has('unix')
    nnoremap <leader>K :execute 'silent! tabmove ' . (tabpagenr())<CR>
else
    nnoremap <leader>K :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
endif
nnoremap <C-t> :tabnew 
inoremap <C-t> <Esc>:tabnew 
" nmap <leader>t <C-w><C-]><C-w>T
"mnemonic: OpenWindow
nmap <leader>ow <C-w>T
nmap <leader>f <C-w>gf
nmap <leader>od gD:vs<CR><C-W>W<C-o>
nmap <leader>t :TagbarToggle<CR>

" remove trailing whitespace
noremap <silent> <leader>rw :%s/\s\+$//e<CR>

" new tab for search with mappings
nnoremap <leader>m :tabe<CR>:redir @"><CR>:silent map<CR>:redir END<CR>p

" Execution
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
noremap <buffer> <F10> :exec '!python3 -m pdb' shellescape(@%, 1)<cr>

" Turn off
nnoremap <F1> <nop>
if system("uname -s") =~ "Darwin"
    nnoremap <F1> <Esc>
endif
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap Q @@

" close preview window
nmap gpc :pc<CR>


" Show Highlight group for debug
" further: http://vimdoc.sourceforge.net/htmldoc/eval.html#synstack()
map <leader>sh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Navigate quickfix list
noremap <silent> <leader>] :cn<CR>zz
noremap <silent> <leader>[ :cp<CR>zz

" Commands
command Cnt :%s///gn

""""""""""""""""""""""""""""""
" FUNCTIONS
""""""""""""""""""""""""""""""
" IN PROGRESS
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" Smart tab autocomplete
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
endfunction

function! SwitchBg()
    let bg = &background
    if bg == 'dark'
        set background=light
    else
        set background=dark
    endif
    "echom &bg
endfunction
nnoremap <leader>bg :call SwitchBg()<CR>

function! GoCurrentFileDir()
    cd %:p:h
endfunction
nnoremap <leader>gcd :call GoCurrentFileDir()<CR>

"TODO supposed to open file by symlink
"noremap <leader>ev :execute 'e ' . resolve(expand(%))<CR>
cnoreabbrev <expr> gbl getcmdtype() == ':' && getcmdpos() == 4 ? '! ( cd '.fnamemodify(resolve(expand('%')), ':h').' ; vi '.fnamemodify(resolve(expand('%')), ':t').' )' : 'gbl'
function! Qwer()
    let s:asdf = resolve(expand('%'))
    exe 'e '.s:asdf
endfunction

"TODOcd to currenly opened symlinked file
function! Slcd()
    exe "lc " . resolve(expand("%:h"))
endfunction

" copy full current file to clipboard
function! CopyName()
    let @*=expand('%:p')
endfunction
nnoremap <leader>yy :call CopyName()<CR>

" copies full file name
function! YankFile()
    let @*=expand("%")
endfunction

" toggle between showing and hiding redundant whitespaces
let g:isWhitespaceOn = 2
function! ToggleWhitespaces()
    if g:isWhitespaceOn == 1
        hi redundant_spaces ctermbg=red guibg=red
        let g:isWhitespaceOn = 2
    elseif g:isWhitespaceOn == 2
        hi clear redundant_spaces
        let g:isWhitespaceOn = 0
    else
        hi redundant_spaces ctermbg=blue guibg=blue
        let g:isWhitespaceOn = 1
    endif
endfunction
nnoremap <leader>w :call ToggleWhitespaces()<CR>

" foldmethod: manual <-> syntax
function! SetFoldmethod()
    let method = &foldmethod
    if method == 'manual'
        set foldmethod=syntax
    else
        set foldmethod=manual
    endif
    echom &foldmethod
endfunction
nnoremap <leader>z :call SetFoldmethod()<CR>

" swap two function arguments if on same line
function! SwapTwoArgs()
    s/(\(.*\), \(.*\))/(\2, \1)/
endfunction
nnoremap <leader>sa :call SwapTwoArgs()<CR>

" open snippets
function! Snippets()
    let ft = &filetype
    echo ft
    if ft == 'python'
        tabe ~/.vim/bundle/vim-snippets/snippets/python.snippets
    elseif ft == 'sh'
        tabe ~/.vim/bundle/vim-snippets/snippets/sh.snippets
    endif
    "tabe ~/.vim/bundle/vim-snippets/snippets/cpp.snippets
    "vs ~/.vim/bundle/vim-snippets/snippets/c.snippets
endfunction
nnoremap <leader>sn :call Snippets()<CR>

" copies current file name as C++ header
function! YankHeader()
    let head =expand("%")
    let @"="#include \"".head."\"\n"
endfunction
nnoremap <leader>h :call YankHeader()<CR>

" strips trailing whitespace at the end of files. this is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Source <-> Header
function! OpenOther()
    " expand("%:p:r:s?src?include?")
    " :e %<.cpp
    if expand("%:e") == "cpp"
        exe "vsplit" fnameescape(expand("%:p:r:s?src?").".h")
    elseif expand("%:e") == "cc"
        exe "vsplit" fnameescape(expand("%:p:r:s?src?").".h")
    elseif expand("%:e") == "h"
        "if filereadable(expand("%:p:r:s?include?src?").".cpp")
        if filereadable(expand("%:p:r:s?src?").".cpp")
            exe "vsplit" fnameescape(expand("%:p:r:s?src?").".cpp")
        elseif filereadable(expand("%:p:r:s?src?").".cc")
            exe "vsplit" fnameescape(expand("%:p:r:s?src?").".cc")
        endif
    endif
endfunction
nnoremap <leader>oo :call OpenOther()<CR>

" Visual mode pressing * or # searches for the current selection
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
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Make home session
function! MkHomeSes(name)
    execute "mks! ~/.vim/sessions/" . a:name
endfunction
nnoremap <leader>ms :call MkHomeSes(

" TODO Make session in current folder
function! MkFolderSes(name)
    execute "mks! ~/.vim/sessions/" . a:name
endfunction
"nnoremap <leader>ms :call MkFolderSes(

" TODO Make session in current folder
function! OverwriteSession(name)
    execute "mks! ~/.vim/sessions/" . a:name
endfunction
"nnoremap <leader>ms :call MkFolderSes(

"TODO load last
function! LoadSes()
    execute "!ls ~/.vim/sessions/"
endfunction
nnoremap <leader>ls :call LoadSes(

function! GetSes()
    execute "!ls ~/.vim/sessions/"
endfunction

function! s:Resolve() abort
    let current = expand('%')
    let resolved = resolve(current)
    if current !~# '[\/][\/]' && current !=# resolved
        silent execute 'keepalt file' fnameescape(resolved)
        return 'edit'
    endif
    return ''
endfunction

command -bar Resolve execute s:Resolve()

augroup resolve
    autocmd!
    autocmd BufReadPost * nested
                \ if exists('*FugitiveExtractGitDir') && !exists('b:git_dir') &&
                \     expand('%') !=# resolve(expand('%')) &&
                \     len(FugitiveExtractGitDir(resolve(expand('%')))) |
                \   Resolve |
                \ endif
augroup END

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
function! WinEnc()
    e ++enc=cp1251
endfunction
"""""""""""""""""""""""""""""
function! Csc()
  cscope find c <cword>
  copen
endfunction
command! Csc call Csc()
"""""""""""""""""""""""""""""
nnoremap <leader><leader> :noh<CR>:pc<CR>
