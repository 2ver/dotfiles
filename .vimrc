set nocompatible

" Plug package manager

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'lervag/vimtex'
Plug 'ajh17/VimCompletesMe'
"Plug 'pineapplegiant/spaceduck'"
"Plug 'sonph/onehalf', { 'rtp': 'vim'}"
Plug 'dracula/vim', { 'as': 'dracula'}

call plug#end()

syntax on
set encoding=utf-8
filetype plugin indent on
set so=999 "Keep cursor in center (except at top or bottom)"
set ignorecase "Ignore capitalization when searching"
set smartcase "If searching for 'word', show 'word' and 'Word' but only show 'Word' if searching for 'Word'"
set nu rnu "Relative line numbers (and show exact number on current line)"
set noswapfile
"set clipboard=unnamedplus"
set autoindent "Enable auto indentation of lines"
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent "Allow Vim to best-effort guess the indentation"
set showmatch "Highlights matching brackets"
set incsearch "Search as characters are entered"
set hlsearch "Highlights matching searcher"

" System clipboard (and primary selection) "
vnoremap <C-c> "*y :let @+=@*<CR>

" Colors "
colorscheme lena

highlight Normal ctermbg=NONE
highlight LineNr term=bold cterm=bold ctermbg=NONE
"highlight Comment cterm=italic gui=italic"

" Change cursor shape on Mac"
"let &t_SI = "
"\<Esc>]50;CursorShape=2\x7"
"let &t_SR = "
"\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "
"\<Esc>]50;CursorShape=0\x7"

" Change cursor shape in Termite/Kitty"
let &t_SI = "\<Esc>[4 q"
let &t_SR = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup End


" LaTeX settings"
"let g:vimtex_view_method = 'skim'"
"let g:vimtex_quickfix_ignore_filters = ["
"      \ 'LaTeX Warning: Command \\under\(bar\|line\)  has changed.',"
"      \ 'Over-specification in `v',"
"      \ '\\headheight is too small'"
"      \]


" Key remaps"
" Stop highlighting search"
nnoremap <silent> <C-l> :noh<CR><C-l>  

"Remap k to work in wrapped lines"
nnoremap <expr> j v:count ? 'j' : 'gj' 

"Remap j to work in wrapped lines"
nnoremap <expr> k v:count ? 'k' : 'gk' 

" Vimtex autocomplete"
"augroup VimCompletesMeTex"
"    autocmd!"
"    autocmd FileType tex"
"        \ let b:vcm_omni_pattern = g:vimtex#re#neocomplete"
"  augroup END"
