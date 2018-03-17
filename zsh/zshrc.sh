# Aliases
# This allows you to open multiple tabs on a single start up Ex) vim -p foo.txt bar.txt
alias v="vim -p"

# Settings
export VISUAL=vim       # This creates a 'global' variable within the scope of the zsh session...I think.
source $HOME/.dotfiles/zsh/plugins/fixls.zsh

# Functions
ccd(){
    cd $1;              # This adds custom functionality to the 'cd' command.
    ls;                 # Everytime 'cd' is entered into the CLI, it also inputs 'ls'.
}
alias cd="ccd"

# For Vim Mappings
stty -ixon              # Opens up keybindings <C-s> & <C-q> which would otherwise "lock/unlock" the terminal.

# Set zsh theme
#ZSH_THEME=alanpeabody

#source $HOME/.dotfiles/zsh/plugins/oh-my-zsh/themes/alanpeabody.zsh-theme
source $HOME/.dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source $HOME/.dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh # Oh-my-zsh keybindings. I believe these tie into the custom keybindings.sh file seen below
source $HOME/.dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh # Enables <TAB> completion to complement the autosuggestions
source $HOME/.dotfiles/zsh/plugins/vi-mode.plugin.zsh # Vi-like behavior in the shell
source $HOME/.dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh # Remebers previous shell entries and builds auto suggestions based on command history
source $HOME/.dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Simple syntax highlighting for the shell
source $HOME/.dotfiles/zsh/keybindings.sh # Various custom keybindings for the shell. See doc

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

#KEYTIMEOUT=1 # Possibly fixes vim delay when hitting ESC.
source $HOME/.dotfiles/zsh/prompt.sh
