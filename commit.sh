#!/bin/zsh

# Function to stage, commit, and push files based on the argument
commit_files() {
    local files=()
    case $1 in
        vim)
            files=(cvimrc vimrc vimrc_redundant obsidian.vimrc)
            ;;
        vscode)
            files=(vscode-keybindings.json vscode.json vscode-user-settings.json)
            ;;
        tmux)
            files=(green-blue.tmuxtheme other-tmux.conf tmux_home.conf tmux_notes.txt tmux_work.conf)
            ;;
        zsh)
            files=(ees.zsh-theme forgit.plugin.zsh globalias.plugin.zsh zshrc zsh_themes)
            ;;
        surf)
            files=(surf.js)
            ;;
        *)
            echo "Invalid argument. Please use vim, vscode, tmux, zsh, or surf."
            return 1
            ;;
    esac

    # Stage files
    git add "${files[@]}"

    staged=$(git diff --cached --name-only)
    git commit -m "$staged"

    # Push changes
    git push
}

# Main script execution
if [[ $# -eq 0 ]]; then
    echo "Please provide an argument: vim, vscode, tmux, zsh, or surf."
    exit 1
fi

commit_files "$1"
