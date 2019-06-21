#Fixes tmux vim colors display
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

export EDITOR=vim

#globalias
plugins=(git git-extras z fasd bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle per-directory-history tmux vundle zsh_reload virtualenv)

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

source ~/.install/fasd/fasd
eval "$(~/.install/fasd/fasd --init auto)"

alias fsx="xcv x"
alias fsc="xcv c"
alias fsv="xcv v"
alias fsl="xcv l"

if [ -f ~/.config/z_home.sh ]; then
    source ~/.config/z_home.sh
elif [ -f ~/.config/z_work.sh ]; then
    source ~/.config/z_work.sh
fi

#TODO move home zalias to z_home

if [ -f ~/.dotfiles/common.sh ]; then
    source ~/.dotfiles/common.sh
fi

cop()
{
    echo -n "$*" | eval ${COPY}
}

# newfunc()
#{
#}

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
        echo "alias $1='$2'" >> ~/.config/z_work;
    fi
    alias $1="$2"
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

# FASD {
bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
# }

bindkey -s 'l' 'l
'
bindkey -s 'u' 'cd ..
'
bindkey '^ ' autosuggest-accept
bindkey '' history-beginning-search-backward
bindkey '' history-beginning-search-forward

alias checksizes='for i in */; do du -sh web/; done'
alias eali="vi ~/.zaliasrc"
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
alias savetheme="echo \"$RANDOM_THEME\" >> ~/.dotfiles/zsh_themes"
alias .="source"
alias -s zip=unzip
if [ ! -z $EDITOR ]; then
    alias vi="$EDITOR -p"
    alias v="f -e \"$EDITOR\""
else
    echo 'Editor unset!'
fi
alias -- -='popd'

#set convert-meta on

#export NVM_DIR="/home/wut/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#no work
alias shutd=sudo swapoff -a && systemctl poweroff=''

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
alias ex='extract'
alias dow='cd ~/Downloads'
#zprof
alias debug_zsh='zsh -xv 2>&1 | ts -i "%.s" > zsh_startup.log'

source $ZSH/oh-my-zsh.sh
