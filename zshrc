#Fixes tmux vim colors display
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

# Powerlevel9k has to be above ZSH_THEME
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
    source ~/.dotfiles/powerlevel9k
fi

#globalias
plugins=(git git-extras z fasd bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle per-directory-history tmux vundle zsh_reload)

#TODO to ~/.config/z_home
if [ $(uname) = "Linux" ]; then
    curl wttr.in
    ZSH_THEME="bira" #"my" #could be random
    export EDITOR='vim'
    stty -ixon
    cd ~/Uni
    COPY=xclip
    plugins=($plugins pip)
fi

if [ -f ~/.config/z_work ]; then
    source ~/.config/z_work
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

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
