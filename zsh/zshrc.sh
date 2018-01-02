# Aliases
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

launchChrome(){
    google-chrome --disable-gpu;
}
alias chrome="launchChrome"

# For Vim Mappings
stty -ixon              # Opens up keybindings <C-s> & <C-q> which would otherwise "lock/unlock" the terminal.


