#Fixes tmux vim colors display
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
export EDITOR=vim
export PATH=$PATH:~/.install/fasd/bin

plugins=(git git-extras z fasd per-directory-history bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle tmux vundle zsh_reload virtualenv globalias)

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh
source ~/.install/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# don't save command if space at the begining
setopt HIST_IGNORE_SPACE

alias fsx="xcv x"
alias fsc="xcv c"
alias fsv="xcv v"
alias fsl="xcv l"

if [ -f ~/.config/z_home.sh ]; then
    LOCALFILE=~/.config/z_home.sh
elif [ -f ~/.config/z_work.sh ]; then
    LOCALFILE=~/.config/z_work.sh
fi
source $LOCALFILE

#TODO move home zalias to z_home

if [ -f ~/.dotfiles/common.sh ]; then
    source ~/.dotfiles/common.sh
fi

cop()
{
    echo -n "$*" | eval ${COPY}
}

newfunz()
{
    eval "$1() { $2 }"
    echo "$1() { $2 }" >> $LOCALFILE
}

newfuns()
{
    eval "$1() { $2 }"
    echo "$1() { $2 }" >> $LOCALFILE
}

pgr()
{
    ps -ef | grep "$1"
}

newalias()
{
    echo "alias $1='$2'" >> ~/.zshrc;
    alias $1="$2"
}

newaliaz()
{
    if [ -f ~/.config/z_home.sh ]; then
        echo "alias $1='$2'" >> ~/.config/z_home.sh
    elif [ -f ~/.config/z_work.sh ]; then
        echo "alias $1='$2'" >> ~/.config/z_work.sh;
    fi
    alias $1="$2"
}

alias nas=newalias
alias naz=newaliaz

pinst()
{
    conda install $1 || pip install $1
}

background()
{
    "$@" 2>/dev/null &
}

aliaz()
{
    alias | grep $1
}

gmod()
{
    git status | grep modified | tr -s ' ' | cut -f 2 -d ' ' | grep $1
}

gmodc()
{
    git checkout $(git status | grep modified | tr -s ' ' | cut -f 2 -d ' ' | grep $1)
}

vks() {
    node $HOME/my/vk_send/vk_send.js $* &
}

mcd() {
    mkdir $1; cd $1
}

cl() {
    cd $1; l
}

addshebang() {
    echo -e "#!/usr/bin/env bash\n$(cat $1)" > $1
}

# VIM MODE!!!
# from https://dougblack.io/words/zsh-vi-mode.html
# breaks "per word history"
#bindkey -v
# kills <ESC> lag

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# FASD {
bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
# }

# if rebind this to s then l can be used in tmux
bindkey -s 'l' 'l
'
bindkey ' ' magic-space
bindkey '^ ' autosuggest-accept
bindkey '' history-beginning-search-backward
bindkey '' history-beginning-search-forward

# alt-x : insert last command result
zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey '^[x' insert-last-command-output

source $ZSH/oh-my-zsh.sh
#must be under "oh-my-zsh"
bindkey -s 'u' 'cd ..
'

alias checksizes='for i in */; do du -sh web/; done'
alias eali="vi ~/.zaliasrc"
alias l='ls -G'
alias la='ls -Ga'
alias sz="source ~/.zshrc"
alias szz='source ~/.config/z_*'
alias ez='vi ~/.zshrc'
alias ezz='vi ~/.config/z_*'
alias ff="find . -iname"
alias glgp="git pull --no-edit && git push"
alias gs="git stash"
alias gsl="git stash list"
alias gsp="git stash pop"
alias mkdir='mkdir -pv'
alias rgj='rg --type=js '
alias rgp='rg --type=cpp '
alias savetheme="echo \"\$RANDOM_THEME\" >> ~/.dotfiles/zsh_themes"
alias .="source"
alias -s zip=unzip
if [ ! -z $EDITOR ]; then
    alias vi="$EDITOR -p"
    alias v="f -e \"$EDITOR\""
else
    echo 'Editor unset!'
fi
alias -- -='popd'
alias -g VI=" | vi -"
alias -g ~="~/"
alias -g ~.="~/."
#no work
alias shutd=sudo swapoff -a && systemctl poweroff=''

export JUPYTER_CONFIG_DIR=~/.dotfiles/jupyter
alias ex='extract'
alias dow='cd ~/Downloads'
#zprof
alias debug_zsh='zsh -xv 2>&1 | ts -i "%.s" > zsh_startup.log'

export ZSH_THEME=ees
alias gapac="gapa && print -z gc -m \'"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=138" #"fg=#87af87" #",bg=cyan,bold,underline"
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
alias gdc='git diff --cached'
