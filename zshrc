#Fixes tmux vim colors display
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

cd ~

#globalias
plugins=(git git-extras z fasd bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle per-directory-history tmux vundle zsh_reload)

if [ -f ~/.config/z_home ]; then
    source ~/.config/z_home
elif [ -f ~/.config/z_work ]; then
    source ~/.config/z_work
fi

cop()
{
    echo -n "$*" | eval ${COPY}
}

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

# don't save command if space at the begining
setopt HIST_IGNORE_SPACE

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#TODO fix home zalias
if [ -f ~/.config/zaliasrc ]; then
    source ~/.config/zaliasrc
fi

if [ -f ~/.dotfiles/common ]; then
    source ~/.dotfiles/common
fi

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

source ~/.local/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -s 'l' 'l'
bindkey -s 'u' 'cd ..'
bindkey '^ ' autosuggest-accept
bindkey '' up-line-or-beginning-search
bindkey '' down-line-or-search

alias .="source"
alias sz="source ~/.zshrc"
alias savetheme="echo \"$RANDOM_THEME\" >> ~/shell/zsh_themes"
alias -s zip=unzip
alias ez='vi ~/.zshrc'
alias eali="vi ~/.zaliasrc"
alias gs="git stash"
alias gsp="git stash pop"
alias gsl="git stash list"
alias glgp="git pull --no-edit && git push"
alias vi="$EDITOR -p"
alias v="f -e \"$EDITOR\""
alias ff="find . -iname"
alias rgp='rg --type=cpp '
alias rgj='rg --type=js '
alias z='nocorrect fasd_cd -d'
alias checksizes='for i in */; do du -sh web/; done'
alias mkdir='mkdir -pv'

#set convert-meta on
alias -- -='popd'

#export NVM_DIR="/home/wut/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#no work
alias shutd=sudo swapoff -a && systemctl poweroff=''

# added by Miniconda3 installer
export PATH="/home/wut/.local/node-v8.11.1-linux-x64/bin:/home/wut/.local/miniconda3/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
alias ex='extract'
alias andr='cd /run/user/1000/gvfs/mtp:host=%5Busb%3A001%2C011%5D/Internal\ storage/Download'
alias dow='cd ~/Downloads'
#zprof
alias debug_zsh='zsh -xv 2>&1 | ts -i "%.s" > zsh_startup.log'
