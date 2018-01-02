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
