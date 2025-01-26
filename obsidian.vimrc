imap jo <esc>
inoremap jk <esc>

"exmap checkmark obcommand editor:cycle-list-checklist
"nmap m :checkmark

exmap tabnext obcommand workspace:next-tab
nmap K :tabnext<cr>

exmap tabprev obcommand workspace:previous-tab
nmap J :tabprev<cr>

set clipboard=unnamed

exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>
