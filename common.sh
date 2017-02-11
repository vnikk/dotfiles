function sess(){ vi -S ~/.vim/sessions/"$1"; }

alias xclip='xclip -selection c'
alias xlog="git xlog"
alias flux='~/shell/xflux -l 50°06'

alias mv='mv -n'
alias ll='ls -lhF'
alias la='ls -AF'
alias l='ls -CF'

if [ $(uname) = "Linux" ]; then
alias l='l --group-directories-first'
fi

if [ -f ~/shell/xcv ]; then
    source ~/shell/xcv 1>/dev/null
fi

