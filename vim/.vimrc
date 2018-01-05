" General Settings

"syntax on
"set showmatch
let mapleader=","
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
"set relativenumber
set number
set linespace=0

if !&scrolloff
	set scrolloff=3 " Show next 3 lines while scrolling.
endif

" Relative Numbering
function! NumberToggle()
    if(&relativenumber == 1)
        set nornu
        set number
    else
        set rnu
    endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" Return to the same line you left off at when re-opening Vim.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \	execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Install Vim-plug if it's not already installed
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $HOME/.dotfiles/vim/.vimrc
endif

" Vim-plug Section
"   - For traditional Vim: $HOME/.vim/plugged
"   - Upon any plugin installation, reload .vimrc and use :PlugInstall
call plug#begin('$HOME/.local/share/nvim/plugged')
" Make sure to use single quotes!

" Gruvbox theme.
Plug 'morhetz/gruvbox'

call plug#end()
" Anything Plugin related goes below here (colorschemes included!)
set background=dark "Set dark mode for gruvbox dark theme
colorscheme gruvbox
