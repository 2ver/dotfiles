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
Plug 'alvan/vim-closetag'

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

" System clipboard (and primary selection)"
vnoremap <C-c> "*y :let @+=@*<CR>

" Tab cycling"
nnoremap H gT
nnoremap L gt

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

" Auto close tags settings "
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.xml, *.html,*.xhtml,*.phtml,*.jsx, *.js, *.tsx'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*xml, *.xhtml,*.jsx, *.js, *.tsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml, jsx, js, tsx'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xml, xhtml,jsx, js, tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
