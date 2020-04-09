# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

function set-title() {
if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
fi
TITLE="\[\e]2;$*\a\]"
PS1=${ORIG}${TITLE}
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Set fancy color prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
__exit_code () {
    # Show exit code of the last command, show it in red if non-zero
    ECODE=$?;
    OUTPUT="{$ECODE}";
    if [ "$color_prompt" = yes ]; then
        if [[ ${ECODE} != 0 ]]; then
            OUTPUT="\033[31m$OUTPUT\033[30m"
        else
            OUTPUT="\033[32m$OUTPUT\033[30m"
        fi
    fi
    echo -ne $OUTPUT
}

if [ "$color_prompt" = yes ]; then
#   PS1='\[\033[1;30m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;31m\]@\h\[\033[01;30m\] \D{%H.%M:%S} \w `__exit_code`\[\033[34m\]$(__git_ps1)\[\033[00m\]\n\$ '
    PS1='\[\033[94m\]\h\
\[\033[1;35m\] \w \
`__exit_code`\
\[\033[0;36m\]`__git_ps1` \[\033[00m\]\n> '
#   PS1='\[\033[1;30m\]${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\w \[\033[0;36m\]$(__git_ps1)\[\033[00m\]\n>'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \D{%H.%M:%S} \w `__exit_code`$(__git_ps1)\n\$ '
fi
# If this is a screen show it in prompt
#case "$TERM" in
#screen*)
#    if [ "$color_prompt" = yes ]; then
#        PS1="\[\033[1;36m\]SCREEN $PS1"
#    else
#        PS1="SCREEN $PS1"
#    fi
#    ;;
#esac

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
#unset color_prompt force_color_prompt
unset force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Custom environment variables.
# Set vim as editor for psql. http://vim.wikia.com/wiki/Quick_and_dirty_Postgres_query
export PSQL_EDITOR='vim +"set syntax=sql"'

if [ $(uname) = "Msys" ]; then
    export VIM=$(pwd);
else
    source ~/.git-prompt.sh
fi


# removes freeze from Ctrl-S (requiring Ctrl-Q to unfreeze)
stty -ixon

newalias()
{
    echo "alias $1" >> ~/.dotfiles/bashrc;
    alias $1
}

alias godot="cd ~/.dotfiles"
alias l=ls
alias doxy="/c/Users/wat/Documents/uni/bachelor/doxy/doxygen.exe /c/Users/wat/Documents/uni/bachelor/doxy/config.txt"
alias vb="vi ~/dotfiles/bashrc && source ~/dotfiles/bashrc"
alias star="cd ~/Source/Repos/ualbertabot/StarAlgo/"
alias g=git
alias gs="git stash"
alias ga="git add"
alias gapa="git add -p"
alias ..="cd .."
alias gp="git push"
alias gst="git status"
alias gc="git commit -v"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/
alias act='source /home.stud/viazomyk/workspace/venv/bin/activate'
alias ipython='act && ipython'
function wcl { cat $1 | wc -l; }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/qwe/.install/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/qwe/.install/anaconda/etc/profile.d/conda.sh" ]; then
        . "/home/qwe/.install/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/qwe/.install/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
