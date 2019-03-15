function sess(){ vi -S ~/.vim/sessions/"$1"; }

function rmsess(){ rm ~/.vim/sessions/"$1"; }

alias xlog="git xlog"
alias flux='~/shell/xflux -l 50°06'

alias mv='mv -n'
alias ll='ls -lhF'
alias la='ls -AF'
alias l='ls -CF'

if [ $(uname) = "Linux" ]; then
    alias xclip='xclip -selection c'
	alias l='ls -CF --group-directories-first'
    alias get='sudo apt install'
    alias here="nautilus . &"

    dimon()
    {
        gsettings set org.gnome.settings-daemon.plugins.power idle-dim true
        gsettings set org.gnome.desktop.session idle-delay 300
    }

    dimoff()
    {
        gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
        gsettings set org.gnome.desktop.session idle-delay 0
    }
fi

if [ -f ~/shell/xcv ]; then
    source ~/shell/xcv 1>/dev/null
fi
