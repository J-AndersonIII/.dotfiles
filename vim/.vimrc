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


" virtual enb settings for neovim


" Vim-plug Section
"   - For traditional Vim: $HOME/.vim/plugged
"   - Upon any plugin installation, reload .vimrc and use :PlugInstall
call plug#begin('$HOME/.local/share/nvim/plugged')
" Make sure to use single quotes!
" Remember:
"   - :PlugInstall -> Install plugins.
"   - :PlugClean -> Get rid of deleted plugins.
"   - :PlugUpdate -> Update installed plugins.
"   - :PlugUpgrade -> Update Vim-plug itself.

Plug 'morhetz/gruvbox' " Gruvbox theme.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Deoplete autocompletion
Plug 'zchee/deoplete-clang' " Clang family asynchronous autocompletion
Plug 'zchee/deoplete-jedi' " Python autocompletion
Plug 'arakashic/chromatica.nvim' " Clang syntax highlighting
Plug 'https://github.com/jiangmiao/auto-pairs.git' " Auto completes pairs when typing
Plug 'https://github.com/vim-syntastic/syntastic.git' " Code error reporting/linting
Plug 'Shougo/neosnippet' " Snippet functionality. Snippets can be found in ~/.dotfiles/extras/snippets/

call plug#end()

" Anything Plugin related goes below here (colorschemes included!)
set background=dark "Set dark mode for gruvbox dark theme
colorscheme gruvbox

let g:deoplete#enable_at_startup=1 " Lines 67-70 enable deoplete at startup and allow omnifuncs
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns={}
endif
"let g:deoplete#disable_auto_complete=1 " Makes autocompletion require keybind.
"
" This next line automatically closes scratch window after an autocompletion.
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" deoplete tab-complete keybinding
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr><Esc> pumvisible() ? deoplete#mappings#close_popup() : "\<Esc>"

" deoplete clang settings
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang-3.8.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'

" Chromatica settings
let g:chromatica#libclang_path = '/usr/lib/llvm-3.8/lib/libclang-3.8.so'
let g:chromatica#enable_at_startup = 1
let g:chromatica#responsive_mode = 1

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_python_checkers = ['pylint']

" NeoSnippet Settings
let g:neosnippet#disable_runtime_snippets = {'python' : 1} " Ignore default snippets
let g:neosnippet#snippets_directory = '~/.dotfiles/extras/snippets' " Assign my own snippet directory
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ["neosnippet"] " Remove autocompletion from snippet input fields

function! s:neosnippet_complete() " Tab will expand depending on snippet window state otherwise will just use normal tab
  if pumvisible()
    return "\<c-n>"
  else
    if neosnippet#expandable_or_jumpable() 
      return "\<Plug>(neosnippet_expand_or_jump)"
    endif
    return "\<tab>"
  endif
endfunction

imap <expr><TAB> <SID>neosnippet_complete()
