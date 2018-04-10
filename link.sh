#!/bin/bash
function normal() {
    ln -s -f $PWD/bashrc ~/.bashrc
    ln -s -f $PWD/zshrc ~/.zshrc
    ln -s -f $PWD/vimrc ~/.vimrc
    ln -s -f $PWD/tmux.conf ~/.tmux.conf
}

function colors() {
    mkdir -p ~/.vim/colors
    cd colorschemes
    for i in $(ls *.vim)
        do ln -s -f $PWD/$i ~/.vim/colors/$i
    done
    cd -
}

function other() {
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    mkdir -p ~/.oh-my-zsh/themes
    git clone https://github.com/bhilburn/powerlevel9k ~/.oh-my-zsh/themes/powerlevel9k
    curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
    git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/themes
    mkdir ~/.tmux/plugins/
    git clone --recursive https://github.com/Morantron/tmux-fingers ~/.tmux/plugins/tmux-fingers
    git clone https://github.com/tmux-plugins/tmux-open ~/.tmux/plugins/tmux-open
    #list to make sure is installed
    #Cscope
}

case $1 in
    'colors') colors;;
    'normal') normal;;
    *) colors; normal; other
esac


