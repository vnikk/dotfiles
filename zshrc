#Fixes tmux vim colors display
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
    # Powerlevel9k has to be above ZSH_THEME
    source ~/.dotfiles/powerlevel9k
fi

#globalias
plugins=(git git-extras z fasd bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle per-directory-history tmux vundle zsh_reload)

if [ $(uname) = "Linux" ]; then
    curl wttr.in
    ZSH_THEME="bira" #"my" #could be random
    export EDITOR='vim'
    stty -ixon
    COPY=xclip
    plugins=($plugins pip)
    PER_DIRECTORY_HISTORY_TOGGLE=''
else
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    ZSH_THEME="powerlevel9k/powerlevel9k" #"bira" #peepcode"
    export EDITOR='mvim -v'
    plugins=($plugins jira docker)
    COPY=pbcopy
    PER_DIRECTORY_HISTORY_TOGGLE=''
fi

copyy()
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

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
fi

# Personal aliases, though better in ZSH_CUSTOM

if [ -f ~/.zaliasrc ]; then
    source ~/.zaliasrc
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

source ~/.local/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -s 'l' 'l'
bindkey -s 'u' 'cd ..'
bindkey '^ ' autosuggest-accept

alias .="source"
alias sz="source ~/.zshrc"
alias savetheme="echo \"$RANDOM_THEME\" >> ~/shell/zsh_themes"
alias -s zip=unzip
alias ez='vi ~/.zshrc'
alias eali="vi ~/.zaliasrc"
alias gs="git stash"
alias gsp="git stash pop"
alias gsl="git stash list"
alias vi="$EDITOR -p"
alias v="f -e \"$EDITOR\""
alias ff="find . -iname"
alias rgp='rg --type=cpp '
alias rgj='rg --type=js '
alias z='nocorrect fasd_cd -d'
alias checksizes='for i in */; do du -sh web/; done'
alias mkdir='mkdir -pv'

#set convert-meta on

#export NVM_DIR="/home/wut/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#no work
alias shutd=sudo swapoff -a && systemctl poweroff=''

# added by Miniconda3 installer
export PATH="/home/wut/.local/node-v8.11.1-linux-x64/bin:/home/wut/.local/miniconda3/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
alias ex='extract'
alias andr='cd /run/user/1000/gvfs/mtp:host=%5Busb%3A001%2C011%5D/Internal\ storage/Download'
alias dow='cd'
alias dow='cd ~/Downloads'
