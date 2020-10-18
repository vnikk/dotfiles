# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Fixes tmux vim colors display
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
export EDITOR=vim
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

plugins=(git git-extras z per-directory-history bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle tmux vundle zsh_reload virtualenv globalias)

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

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

# TODO why here?
source $ZSH/oh-my-zsh.sh
source ~/.install/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# fzf
# https://junegunn.kr/2016/07/fzf-git/
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gt() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  # Pass the list of the tags to fzf-tmux
  # - "{}" in preview option is the placeholder for the highlighted entry
  # - Preview window can display ANSI colors, so we enable --color=always
  # - We can terminate `git show` once we have $LINES lines
  git tag --sort -version:refname |
    fzf --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -'$LINES
}
# TODO
#bindkey '' '$(gt)
#'

fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}
#####################

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

alias gapac="gapa && print -z gc -m \'"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=138" #"fg=#87af87" #",bg=cyan,bold,underline"
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
alias gdc='git diff --cached'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# P10K
source ~/.install/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
