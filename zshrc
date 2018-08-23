#Fixes tmux vim colors display
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

#globalias
plugins=(git git-extras z fasd bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle per-directory-history tmux vundle zsh_reload)

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

source ~/.local/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# don't save command if space at the begining
setopt HIST_IGNORE_SPACE

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

if [ -f ~/.config/z_home ]; then
    source ~/.config/z_home
elif [ -f ~/.config/z_work ]; then
    source ~/.config/z_work
fi

#TODO fix home zalias
if [ -f ~/.config/zaliasrc ]; then
    source ~/.config/zaliasrc
fi

if [ -f ~/.dotfiles/common ]; then
    source ~/.dotfiles/common
fi

cop()
{
    echo -n "$*" | eval ${COPY}
}

newalias()
{
    echo "alias $1='$2'" >> ~/.zshrc;
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

bindkey -s 'l' 'l'
bindkey -s 'u' 'cd ..'
bindkey '^ ' autosuggest-accept
bindkey '' history-beginning-search-backward
bindkey '' history-beginning-search-forward

alias checksizes='for i in */; do du -sh web/; done'
alias eali="vi ~/.zaliasrc"
alias ez='vi ~/.zshrc'
alias ff="find . -iname"
alias glgp="git pull --no-edit && git push"
alias gs="git stash"
alias gsl="git stash list"
alias gsp="git stash pop"
alias mkdir='mkdir -pv'
alias rgj='rg --type=js '
alias rgp='rg --type=cpp '
alias savetheme="echo \"$RANDOM_THEME\" >> ~/shell/zsh_themes"
alias .="source"
alias -s zip=unzip
alias sz="source ~/.zshrc"
alias v="f -e \"$EDITOR\""
alias vi="$EDITOR -p"
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
