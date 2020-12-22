set nocompatible

" Plug package manager
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'lervag/vimtex'
Plug 'ajh17/VimCompletesMe'
Plug 'pineapplegiant/spaceduck'
Plug 'sonph/onehalf', { 'rtp': 'vim'}

call plug#end()

syntax on
set encoding=utf-8
filetype plugin indent on
set so=999 "Keep cursor in center (except at top or bottom)
set ignorecase "Ignore capitalization when searching
set smartcase "If searching for 'word', show 'word' and 'Word' but only show 'Word' if searching for 'Word'
set clipboard=unnamed "Global clipboad
set nu rnu "Relative line numbers (and show exact number on current line)
set noswapfile
set autoindent "Enable auto indentation of lines
set smartindent "Allow Vim to best-effort guess the indentation
set showmatch "Highlights matching brackets
set incsearch "Search as characters are entered
set hlsearch "Highlights matching searcher

" Colors
colorscheme onehalfdark
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum]"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum]"
  set termguicolors
endif

highlight Normal ctermbg=NONE
highlight LineNr term=bold cterm=bold ctermbg=NONE

" LaTeX settings
let g:vimtex_view_method = 'skim'
let g:vimtex_quickfix_ignore_filters = [
      \ 'LaTeX Warning: Command \\under\(bar\|line\)  has changed.',
      \ 'Over-specification in `v',
      \ '\\headheight is too small'
      \]
" Key remaps
nnoremap <silent> <C-l> :noh<CR><C-l> 
" Press to stop highlighting search terms
nnoremap <expr> j v:count ? 'j' : 'gj' "Remap k to work in wrapped lines
nnoremap <expr> k v:count ? 'k' : 'gk' "Remap j to work in wrapped lines

" Vimtex autocomplete
augroup VimCompletesMeTex
    autocmd!
    autocmd FileType tex
        \ let b:vcm_omni_pattern = g:vimtex#re#neocomplete
  augroup END
