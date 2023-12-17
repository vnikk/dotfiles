# this can help debug slow startup
# uncomment the bottom zprof line too
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export POWERLEVEL9K_TRANSIENT_PROMPT=same-dir
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
ZSH_THEME="powerlevel10k/powerlevel10k"

#Fixes tmux vim colors display
export TERM="xterm-256color"
export ZSH=~/.oh-my-zsh
export EDITOR=vim
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export KEYTIMEOUT=1

# TODO home globalias alias-tips virtualenv zsh_reload pipenv
plugins=(git git-extras fasd per-directory-history bgnotify extract fancy-ctrl-z zsh-autosuggestions colored-man-pages dircycle tmux vundle )

DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

# don't save command if space at the begining
setopt HIST_IGNORE_SPACE

if [ -f ~/.config/z_home.sh ]; then
    LOCALFILE=~/.config/z_home.sh
elif [ -f ~/.config/z_work.sh ]; then
    LOCALFILE=~/.config/z_work.sh
fi
source $LOCALFILE

if [ -f ~/.dotfiles/common.sh ]; then
    source ~/.dotfiles/common.sh
fi

# TODO why here?
source $ZSH/oh-my-zsh.sh
source ~/.install/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

newfun()
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
alias nas=newalias

newaliaz()
{
    if [ -f ~/.config/z_home.sh ]; then
        echo "alias $1='$2'" >> ~/.config/z_home.sh
    elif [ -f ~/.config/z_work.sh ]; then
        echo "alias $1='$2'" >> ~/.config/z_work.sh;
    fi
    alias $1="$2"
}
alias naz=newaliaz

background()
{
    "$@" 2>/dev/null &
}

falias()
{
    print -z $(alias | fzf)
}
alias fali=falias

aliaz()
{
    alias | grep $1
}

# TODO fzf
gmod()
{
    git status | grep modified | tr -s ' ' | cut -f 2 -d ' ' | grep $1
}

gmodc()
{
    git checkout $(git status | grep modified | tr -s ' ' | cut -f 2 -d ' ' | grep $1)
}

git_conflict()
{
    git status | pcregrep -Mo '(?s)(?=resolution..).*Changes' | grep : | cut -d ':' -f 2
}

conflict()
{
    git_conflict | xargs vi
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

# FASD {
bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
# }

# if rebind this to s then l can be used in tmux
# iterm2: this needs mapping of cmd or opt combination
bindkey -s 's' 'gst
'
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

# fzf git brach
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

# fshow - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# doesn't let run vi/vim
#v() {
    #[ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
    #local file
    #file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
#}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
#####################

# alt-x : insert last command result
zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey '^[x' insert-last-command-output

# TODO why twice?
source $ZSH/oh-my-zsh.sh
#must be under "oh-my-zsh"
bindkey -s 'u' 'cd ..
'
bindkey -s 's' 'git status
'

alias checksizes='for i in */; do du -sh web/; done'
alias l='ls --group-directories-first'
alias la='ls -a'
alias sz="source ~/.zshrc"
alias szz='source ~/.config/z_*'
alias ez='vi ~/.zshrc'
alias ezz='vi ~/.config/z_*'
alias ff="find . -iname"
alias glgp="git pull --no-edit && git push"
alias gs="git stash"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gdc='git diff --cached'
alias gpp='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gapac='gapa && print -z gc -m "$(git rev-parse --abbrev-ref HEAD): "'
alias gad='git ls-files  -m --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add -p'
gC() {
    msg="$(nocorrect git rev-parse --abbrev-ref HEAD): $@"
    nocorrect git commit -m "$msg"
}

alias mkdir='mkdir -pv'
alias dot='cd ~/.dotfiles'
alias dow='cd ~/Downloads'
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
#alias -g '~.'="~/."
#no work
alias shutd=sudo swapoff -a && systemctl poweroff=''

export JUPYTER_CONFIG_DIR=~/.dotfiles/jupyter
alias ex='extract'
#zprof
alias debug_zsh='zsh -xv 2>&1 | ts -i "%.s" > zsh_startup.log'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=138" #"fg=#87af87" #",bg=cyan,bold,underline"
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.dotfiles/forgit.plugin.zsh
alias chx='chmod +x '
alias surf='cat ~/.dotfiles/surf.js > ~/.config/surf.js; cat ~/.config/surf.mrk.js >> ~/.config/surf.js'
alias remember-key='ssh-add ~/.ssh/id_rsa'
alias python=python3

eval "$(direnv hook zsh)"

# P10K
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# for startup debugging
#zprof
