# Run tmux (if it exists)
if command -v tmux>/dev/null; then
    [ -z $TMUX ] && exec tmux
else
    echo "Oops, tmux is not installed. Please install tmux to utilize the dotfiles."
fi

#echo "Updating Configuration from github."
#(cd $HOME/dotfiles && git pull && git submodule update --init --recursive)

source $HOME/.dotfiles/zsh/zshrc.sh
