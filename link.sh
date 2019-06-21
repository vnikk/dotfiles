#!/bin/bash
function normal() {
    ln -s -f $PWD/bashrc ~/.bashrc
    ln -s -f $PWD/zshrc ~/.zshrc
    ln -s -f $PWD/vimrc ~/.vimrc
    ln -s -f $PWD/tmux_work.conf ~/.tmux.conf
}

function fasd() {
    git clone https://github.com/clvv/fasd ~/.install/fasd
    pushd ~/.install/fasd
    PREFIX=$HOME make install
    popd
}

function term() {
    # sets colorschemes for terminal
    bash -c  "$(wget -qO- https://git.io/vQgMr)"
}

function colors() {
    mkdir -p ~/.vim/colors
    cd colorschemes
    for i in $(ls *.vim)
        do ln -s -f $PWD/$i ~/.vim/colors/$i
    done
    cd -
}

function gitalias() {
    git config --global user.name "vnikk"
    git config --global user.email vnikk@github.com

    git config --global alias.xlog "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
    git config --global alias.lg1 "log --graph --pretty=format:\"%C(yellow)%h%Creset %ad  %s%C(cyan)%d%Creset %C(green)[%an]%Creset\" --date=short"
}

function other() {
    mkdir ~/.vim/sessions

    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +qall

    if [ ! -d ~/.oh-my-zsh ]; then
        `which curl` && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.install/zsh-syntax-highlighting
    chsh -s /bin/zsh

    mkdir -p ~/.oh-my-zsh/themes
    if [ ! -d ~/.oh-my-zsh/themes/powerlevel9k ]; then
        git clone https://github.com/bhilburn/powerlevel9k ~/.oh-my-zsh/themes/powerlevel9k
    fi

    if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    fi

    curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
    if [ ! -d ~/.tmux/themes ]; then
        git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/themes
    fi
    mkdir ~/.tmux/plugins/
    if [ ! -d ~/.tmux/plugins/tmux-fingers ]; then
        git clone --recursive https://github.com/Morantron/tmux-fingers ~/.tmux/plugins/tmux-fingers
    fi
    if [ ! -d ~/.tmux/plugins/tmux-open ]; then
        git clone https://github.com/tmux-plugins/tmux-open ~/.tmux/plugins/tmux-open
    fi
    #list to make sure is installed
    #Cscope
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    case $1 in
        'colors') colors;;
        'normal') normal;;
        'python') python;;
        'term') term;;
        'gitalias') gitalias;;
        *) colors; normal; other; gitalias; term
    esac
fi


function load_tmux() {
    tmux_home=~/.dotfiles
    tmux_version="$(tmux -V | cut -c 6-)"

    if [[ $(echo "$tmux_version >= 2.5" | bc) -eq 1 ]] ; then
        tmux source-file "$tmux_home/tmux_home_2.5"
        exit
    #elif [[ $(echo "$tmux_version >= 1.9" | bc) -eq 1 ]] ; then
        #tmux source-file "$tmux_home/tmux_1.9_to_2.1.conf"
        #exit
    else
        tmux source-file "$tmux_home/tmux_work_"
        exit
    fi
}

function python() {
    pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
    pip install jupyter_nbextensions_configurator
    jupyter nbextensions_configurator enable --user
}

verify_tmux_version
