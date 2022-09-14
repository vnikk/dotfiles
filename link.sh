#!/bin/bash
function normal() {
    ln -s -f $PWD/bashrc ~/.bashrc
    ln -s -f $PWD/zshrc ~/.zshrc
    ln -s -f $PWD/vimrc ~/.vimrc
    ln -s -f $PWD/ideavimrc ~/.ideavimrc
    # TODO link appr
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
    #bash -c  "$(wget -qO- https://git.io/vQgMr)"
    :
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
    git config --global color.ui true

    # diff-so-fancy
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global color.diff-highlight.oldNormal    "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal    "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"

    git config --global color.diff.meta       "11"
    git config --global color.diff.frag       "magenta bold"
    git config --global color.diff.commit     "yellow bold"
    git config --global color.diff.old        "red bold"
    git config --global color.diff.new        "green bold"
    git config --global color.diff.whitespace "red reverse"

    git config --global alias.xlog "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
    git config --global alias.lg1 "log --graph --pretty=format:\"%C(yellow)%h%Creset %ad  %s%C(cyan)%d%Creset %C(green)[%an]%Creset\" --date=short"
}

function ohmyzsh() {
    echo installing ohmyzsh
    which curl 1>/dev/null || sudo apt install curl
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function install_folder() {
    if [ ! -d $1 ]; then
        echo install
        echo "${@:5}"
        eval "${@:5}"
    else
        echo $1 already installed
    fi
}

function git_install() {
    DIR=${@: -1}
    if [ ! -d $DIR ]; then
        eval "${@}"
    else
        echo $DIR already installed
    fi
}

function other() {
    mkdir -p ~/.vim/sessions
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.install

    which vim 1>/dev/null || sudo apt install -y vim-gtk3
    which zsh 1>/dev/null || sudo apt install -y zsh
    which tmux 1>/dev/null || sudo apt install -y tmux

    git_install git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    #vim --noplugin -u NONE +PluginInstall +qall
    # is broken. have to skip errors
    vim --noplugin +PluginInstall +qall

    install_folder ~/.oh-my-zsh $(which curl) && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    git_install git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.install/zsh-syntax-highlighting
    chsh -s /bin/zsh

    ZSH_CUSTOM=~/.oh-my-zsh/custom
    git_install git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

    mkdir -p ~/.oh-my-zsh/themes
    git_install git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.install/powerlevel10k

    if [ ! -f ~/.git-prompt.sh ]; then
        curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
    fi
    git_install git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/themes

    cp ees.zsh-theme ~/.oh-my-zsh/custom/themes/

    mkdir -p ~/.tmux/plugins/
    git_install git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git_install git clone --recursive https://github.com/Morantron/tmux-fingers ~/.tmux/plugins/tmux-fingers
    git_install git clone https://github.com/tmux-plugins/tmux-open ~/.tmux/plugins/tmux-open

    #list to make sure is installed
    #Cscope
}

function reminder() {
    echo REMINDER:
    echo copy content of surf.js to ff
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    which curl 1>/dev/null || sudo apt install curl
    case $1 in
        'colors') colors;;
        'normal') normal;;
        'python') python;;
        'term') term;;
        'gitalias') gitalias;;
        'ohmyzsh') ohmyzsh;;
        *) colors; other; normal; gitalias; term; reminder
    esac
fi

function load_tmux() {
    tmux_home=~/.dotfiles
    tmux_version="$(tmux -V | cut -c 6-)"

    if [[ $(echo "$tmux_version >= 2.5" | bc) -eq 1 ]] ; then
        tmux source-file "$tmux_home/tmux_home_2.5"
        exit
    else
        tmux source-file "$tmux_home/tmux_work"
        exit
    fi
}

function python() {
    sudo apt install pipenv
    # installing all this from jupyter notebook can help
    pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
    pip install jupyter_nbextensions_configurator
    jupyter nbextensions_configurator enable --user
}
