" Supporting code -------------------------------------------------------------
" Initialisation: [[[

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name='kamrat'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
    finish
endif

" ]]]
" Global Settings: [[[

if !exists('g:kamrat_italic')
    let g:kamrat_italic=0
endif

let s:is_dark=(&background == 'dark')

" ]]]
" Palette: [[[

" setup palette dictionary
let s:ka = {}

" fill it with absolute colors
let s:ka.dark0  = ['#292725', 0]
let s:ka.dark1  = ['#322f2e', 0]
let s:ka.dark2  = ['#413d3a', 0]
let s:ka.dark3  = ['#4f4b47', 0]
let s:ka.dark4  = ['#5b5650', 0]
let s:ka.dark5  = ['#666059', 0]

let s:ka.gray   = ['#7d7569', 0]

let s:ka.light5 = ['#948979', 0]
let s:ka.light4 = ['#a69b89', 0]
let s:ka.light3 = ['#bcae9b', 0]
let s:ka.light2 = ['#cec0ac', 0]
let s:ka.light1 = ['#e0d1bb', 0]
let s:ka.light0 = ['#f3e4d0', 0]

let s:ka.black = ['#000000', 0]
let s:black = s:ka.black

let s:ka.red      = ['#dc7060', 0]
let s:ka.dark_red = ['#ac5b4f', 0]
let s:ka.green    = ['#719a8e', 0]
let s:ka.yellow   = ['#e8b37d', 0]
let s:ka.blue     = ['#759cb4', 0]
let s:ka.magenta  = ['#b09cbf', 0]
let s:ka.cyan     = ['#aec1cc', 0]

let s:ka.red_neon   = ['#fc5745', 0]
let s:red_neon      = s:ka.red_neon
let s:ka.green_neon = ['#14ba9e', 0]
let s:green_neon    = s:ka.green_neon

let s:ka.red_diff   = ['#564c4a', 0]
let s:red_diff      = s:ka.red_diff
let s:ka.green_diff = ['#4c5753', 0]
let s:green_diff    = s:ka.green_diff
let s:ka.green_diff_dark = ['#9abfb3', 0]
let s:green_diff_dark    = s:ka.green_diff_dark
let s:ka.yellow_diff = ['#cdb088', 0]
let s:yellow_diff    = s:ka.yellow_diff
let s:ka.diff_change_bg = ['#554d43', 0]
let s:diff_change_bg    = s:ka.diff_change_bg
let s:ka.diff_change_fg = ['#d1af7d', 0]
let s:diff_change_fg    = s:ka.diff_change_fg
let s:ka.diff_text_bg = ['#84735c', 0]
let s:diff_text_bg    = s:ka.diff_text_bg

let s:red_dark = s:ka.dark_red

" ]]]
" Setup Emphasis: [[[

let s:bold = 'bold,'

let s:italic = 'italic,'
if g:kamrat_italic == 0
    let s:italic = ''
endif

let s:underline = 'underline,'

let s:undercurl = 'undercurl,'

let s:inverse = 'inverse,'

" ]]]
" Setup Colors: [[[

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none   = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
    let s:bg0 = s:ka.dark0
    let s:bg1 = s:ka.dark1
    let s:bg2 = s:ka.dark2
    let s:bg3 = s:ka.dark3
    let s:bg4 = s:ka.dark4
    let s:bg5 = s:ka.dark5

    let s:gray = s:ka.gray

    let s:fg0 = s:ka.light0
    let s:fg1 = s:ka.light1
    let s:fg2 = s:ka.light2
    let s:fg3 = s:ka.light3
    let s:fg4 = s:ka.light4
    let s:fg5 = s:ka.light5

    let s:red      = s:ka.red
    " let s:dark_red = s:ka.dark_red
    let s:green    = s:ka.green
    let s:yellow   = s:ka.yellow
    let s:blue     = s:ka.blue
    let s:magenta  = s:ka.magenta
    let s:cyan     = s:ka.cyan
else " light
    " let s:bg0 = s:ka.light0
    " let s:bg1 = s:ka.light1
    " let s:bg2 = s:ka.light2
    " let s:bg3 = s:ka.light3
    " let s:bg4 = s:ka.light4
    " let s:bg5 = s:ka.light5
    "
    " let s:gray = s:ka.gray
    "
    " let s:fg0 = s:ka.black
    " let s:fg1 = s:ka.dark0
    " let s:fg2 = s:ka.dark2
    " let s:fg3 = s:ka.dark3
    " let s:fg4 = s:ka.dark4
    " let s:fg5 = s:ka.dark5
    "
    " let s:red        = s:ka.dark_red
    " let s:blue       = s:ka.dark_blue
    " let s:light_blue = s:ka.bright_blue
    " let s:brown      = s:ka.dark_orange
    " let s:beige      = s:ka.orange
    "
    " let s:orange      = s:ka.orange
    " let s:dark_orange = s:ka.dark_orange
    " let s:dark_red    = s:ka.dark_red
endif

" save current relative colors back to palette dictionary
let s:ka.bg0 = s:bg0
let s:ka.bg1 = s:bg1
let s:ka.bg2 = s:bg2
let s:ka.bg3 = s:bg3
let s:ka.bg4 = s:bg4
let s:ka.bg5 = s:bg5

let s:ka.gray = s:gray

let s:ka.fg0 = s:fg0
let s:ka.fg1 = s:fg1
let s:ka.fg2 = s:fg2
let s:ka.fg3 = s:fg3
let s:ka.fg4 = s:fg4
let s:ka.fg5 = s:fg5

let s:ka.red      = s:red
" let s:ka.dark_red = s:dark_red
let s:ka.green    = s:green
let s:ka.yellow   = s:yellow
let s:ka.blue     = s:blue
let s:ka.magenta  = s:magenta
let s:ka.cyan     = s:cyan

" ]]]
" Setup Terminal Colors For Neovim: [[[

if has('nvim')
    let g:terminal_color_0 = s:bg1[0]
    let g:terminal_color_8 = s:bg4[0]

    let g:terminal_color_1 = s:red[0]
    let g:terminal_color_9 = s:red[0]

    let g:terminal_color_2 = s:green[0]
    let g:terminal_color_10 = s:green[0]

    let g:terminal_color_3 = s:yellow[0]
    let g:terminal_color_11 = s:yellow[0]

    let g:terminal_color_4 = s:blue[0]
    let g:terminal_color_12 = s:blue[0]

    let g:terminal_color_5 = s:magenta[0]
    let g:terminal_color_13 = s:magenta[0]

    let g:terminal_color_6 = s:cyan[0]
    let g:terminal_color_14 = s:cyan[0]

    let g:terminal_color_7 = s:fg5[0]
    let g:terminal_color_15 = s:fg3[0]

    let g:terminal_color_background = g:terminal_color_0
    let g:terminal_color_foreground = s:fg1[0]
endif

" ]]]
" Overload Setting: [[[

let s:sign_column = s:bg1
let s:italicize_comments = s:italic

" ]]]
" Highlighting Function: [[[

function! s:HL(group, fg, ...)
    " Arguments: group, guifg, guibg, gui

    " foreground
    let fg = a:fg

    " background
    if a:0 >= 1
        let bg = a:1
    else
        let bg = s:none
    endif

    " emphasis
    if a:0 >= 2 && strlen(a:2)
        let emstr = a:2
    else
        let emstr = 'NONE,'
    endif

    let histring = [ 'hi', a:group,
                \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
                \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
                \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
                \ ]

    " special
    if a:0 >= 3
        call add(histring, 'guisp=' . a:3[0])
    endif

    execute join(histring, ' ')
endfunction

" ]]]
" Kamrat Hi Groups: [[[

" memoize common hi groups
call s:HL('KamratFg0', s:fg0)
call s:HL('KamratFg1', s:fg1)
call s:HL('KamratFg2', s:fg2)
call s:HL('KamratFg3', s:fg3)
call s:HL('KamratFg4', s:fg4)
call s:HL('KamratFg5', s:fg5)
call s:HL('KamratGray', s:gray)
call s:HL('KamratBg0', s:bg0)
call s:HL('KamratBg1', s:bg1)
call s:HL('KamratBg2', s:bg2)
call s:HL('KamratBg3', s:bg3)
call s:HL('KamratBg4', s:bg4)
call s:HL('KamratBg5', s:bg5)

call s:HL('KamratRed', s:red)
" call s:HL('KamratRedDark', s:dark_red)
call s:HL('KamratGreen', s:green)
call s:HL('KamratYellow', s:yellow)
call s:HL('KamratBlue', s:blue)
call s:HL('KamratMagenta', s:magenta)
call s:HL('KamratCyan', s:cyan)


call s:HL('KamratRedBold', s:red, s:none, s:bold)
call s:HL('KamratGreenBold', s:green, s:none, s:bold)
call s:HL('KamratYellowBold', s:yellow, s:none, s:bold)
call s:HL('KamratBlueBold', s:blue, s:none, s:bold)
call s:HL('KamratMagentaBold', s:magenta, s:none, s:bold)
call s:HL('KamratCyanBold', s:cyan, s:none, s:bold)

call s:HL('KamratNormal', s:fg1, s:bg1)
call s:HL('KamratNormalBold', s:fg1, s:bg1, s:bold)

" ]]]

" Vanilla colorscheme ---------------------------------------------------------
" General UI: [[[

" Normal text
" call s:HL('Normal', s:fg1, s:bg1)
call s:HL('Normal', s:fg1, s:none)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
    set background=dark
else
    set background=light
endif

if version >= 700
    " Screen line that the cursor is
    if &diff
        call s:HL('CursorLine', s:none, s:none, s:bold . s:underline)
    else
        call s:HL('CursorLine', s:none, s:bg2)
    endif
    " Screen column that the cursor is
    hi! link CursorColumn CursorLine

    " Tab pages line filler
    hi! link TabLineFill Normal
    " Active tab page label
    hi! link TabLineSel StatusLine
    " Not active tab page label
    hi! link TabLine StatusLineNC

    " Match paired bracket under the cursor
    call s:HL('MatchParen', s:none, s:bg4, s:underline)
endif

if version >= 703
    " Highlighted screen columns
    call s:HL('ColorColumn', s:none, s:bg2)

    " Concealed element: \lambda → λ
    call s:HL('Conceal', s:fg3, s:none)

    " Line number of CursorLine
    call s:HL('CursorLineNr', s:fg2, s:bg1)
endif

hi! link NonText KamratBg4
hi! link SpecialKey KamratBg4

call s:HL('Visual', s:none, s:bg3)
hi! link VisualNOS Visual

" call s:HL('Search', s:fg2, s:bg0, s:inverse)
" call s:HL('IncSearch', s:fg1, s:bg0, s:inverse)
call s:HL('Search', s:yellow, s:bg1, s:inverse)
call s:HL('IncSearch', s:bg5, s:yellow, s:inverse)

call s:HL('Underlined', s:none, s:none, s:underline)

" call s:HL('StatusLine', s:bg4, s:fg1, s:inverse)
call s:HL('StatusLine', s:fg2, s:bg2)
call s:HL('StatusLineNC', s:bg2, s:gray, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:bg1)

" Current match in wildmenu completion
" call s:HL('WildMenu', s:bg1, s:yellow, s:bold)
call s:HL('WildMenu', s:bg0, s:yellow)

" Directory names, special names in listing
hi! link Directory KamratBlue

" Titles for output from :set all, :autocmd, etc.
hi! link Title Normal

" Error messages on the command line
hi! link ErrorMsg KamratRed
" More prompt: -- More --
hi! link MoreMsg Normal
" Current mode message: -- INSERT --
hi! link ModeMsg Normal
" 'Press enter' prompt and yes/no questions
hi! link Question Normal
" Warning messages
hi! link WarningMsg KamratYellow

" ]]]
" Gutter: [[[

" Line number for :number and :# commands
call s:HL('LineNr', s:bg5)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg2, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg2)

" ]]]
" Cursor: [[[

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input mode cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" ]]]
" Syntax Highlighting: [[[

" Any special symbol
hi! link Special KamratFg4

" Special character in constant
hi! link SpecialChar KamratCyan

" Special things inside a comment
hi! link SpecialComment Comment

" You can use CTRL-] on this
hi! link Tag Normal

" Character that needs attention
hi! link Delimiter Normal

" Debugging statements
hi! link Debug Normal

" Left blank, hidden
hi! link Ignore Normal

" Current quickfix item in the quickfix window
call s:HL("QuickFixLine", s:fg4, s:bg0, s:inverse)
" quickfix line nr
hi! link qfLineNr KamratGray

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:fg5, s:none, s:bold)
call s:HL('Error', s:red, s:bg1, s:inverse)

" Generic statement
hi! link Statement KamratRed
" if, then, else, endif, swicth, etc.
hi! link Conditional KamratRed
" for, do, while, etc.
hi! link Repeat KamratRed
" case, default, etc.
hi! link Label KamratRed
" try, catch, throw
hi! link Exception KamratRed
" sizeof, "+", "*", etc.
hi! link Operator KamratRed
" Any other keyword
hi! link Keyword KamratRed

" Variable name
hi! link Identifier KamratCyan
" Function name
hi! link Function KamratYellow

" Generic preprocessor
hi! link PreProc KamratCyan
" Preprocessor #include
hi! link Include KamratYellow
" Preprocessor #define
hi! link Define KamratRed
" Same as Define
hi! link Macro KamratRed
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit KamratRed

" Generic constant
hi! link Constant KamratCyan
" Character constant: 'c', '/n'
hi! link Character KamratCyan
" String constant: "this is a string"
hi! link String KamratGreen
" Boolean constant: TRUE, false
hi! link Boolean KamratFg4
" Number constant: 234, 0xff
hi! link Number KamratFg4
" Floating point constant: 2.3e10
hi! link Float Number

" Generic type
hi! link Type KamratCyan
" static, register, volatile, etc
hi! link StorageClass KamratCyan
" struct, union, enum, etc.
hi! link Structure KamratCyan
" typedef
hi! link Typedef KamratCyan

" ]]]
" Completion Menu: [[[

if version >= 700
    " Popup menu: normal item
    call s:HL('Pmenu', s:fg2, s:bg2)
    " Popup menu: selected item
    call s:HL('PmenuSel', s:bg0, s:yellow)
    " Popup menu: scrollbar
    call s:HL('PmenuSbar', s:none, s:bg2)
    " Popup menu: scrollbar thumb
    call s:HL('PmenuThumb', s:none, s:bg4)
endif

" ]]]
" Diffs: [[[

" call s:HL('DiffDelete', s:red_diff,     s:black, s:inverse)
call s:HL('DiffDelete', s:bg0,     s:red_dark, s:inverse)
" call s:HL('DiffAdd',    s:green_diff,   s:black, s:inverse)
call s:HL('DiffAdd',    s:green_diff_dark,   s:green_diff)
" call s:HL('DiffChange', s:gray,  s:yellow_diff_dark)
call s:HL('DiffChange', s:diff_change_fg,  s:diff_change_bg)
call s:HL('DiffText',   s:diff_change_fg, s:bg0, s:inverse)
" call s:HL('DiffText',   s:yellow_diff, s:diff_text_bg)

" ]]]
" Spelling: [[[

if has("spell")
    " Not capitalised word, or compile warnings
    " call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:green)
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:green_neon)
    " Not recognized word
    call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:red_neon)
    " Wrong spelling for selected region
    call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:cyan)
    " Rare word
    call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:magenta)
endif

" ]]]

" Plugin specific -------------------------------------------------------------
" ALE: [[[

" call s:HL("ALEErrorSign", s:red, s:sign_column)
" call s:HL("ALEWarningSign", s:yellow, s:sign_column)
" call s:HL("AleInfoSign", s:fg1, s:sign_column)

" ]]]
" Neomake: [[[

" hi! link NeomakeErrorSign ALEErrorSign
" hi! link NeomakeWarningSign ALEWarningSign
" hi! link NeomakeInfoSign ALEInfoSign

" ]]]
" Signify: [[[

call s:HL("SignifySignAdd",    s:green,  s:sign_column)
call s:HL("SignifySignChange", s:yellow, s:sign_column)
call s:HL("SignifySignDelete", s:red,    s:sign_column)

" ]]]
" GitGutter: [[[

" hi! link GitGutterAdd SignifySignAdd
" hi! link GitGutterChange SignifySignChange
" hi! link GitGutterDelete SignifySignDelete
" call s:HL("GitGutterChangeDelete", s:red, s:sign_column)

" ]]]
" Signature: [[[

" hi! link SignatureMarkText Comment

" ]]]
" Startify: [[[

" hi! link StartifyNumber KamratBeige

" ]]]

" Filetype specific -----------------------------------------------------------
" Python: [[[

hi! link pythonStrFormat KamratCyan
hi! link pythonStrFormatting pythonStrFormat
hi! link pythonStrInterpRegion pythonStrFormat
hi! link pythonBytesEscape pythonStrFormat
hi! link pythonImport KamratRed

" ]]]
" Shell: [[[

" hi! link shDeref Normal
hi! link shVariable Normal
hi! link shCommandSub KamratGreen
" hi! link shCtrlSeq KamratCyan
" hi! link shEscape KamratCyan
" hi! link shSpecial KamratCyan

" ]]]
" Ocaml: [[[
" ]]]
" VimScript: [[[
hi! link vimCommentTitle KamratFg4
" ]]]

" vim: set sw=4 ts=4 sts=4 et tw=80 ft=vim fdm=marker fmr=[[[,]]]:
