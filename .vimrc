set nocompatible

" -- {{{ Plug package manager
call plug#begin('~/.vim/plugged')

" Main plugins
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'flw-cn/vim-nerdtree-l-open-h-close'
"Plug 'sheerun/vim-polyglot'

" Writing plugins
Plug 'reedes/vim-pencil'
Plug 'danielbmarques/vim-ditto'

" Notes
Plug 'vimwiki/vimwiki'

call plug#end()
" -- }}}

" -- {{{ Rules
syntax on
filetype plugin indent on
set encoding=utf-8
set timeoutlen=1000 ttimeoutlen=0 " Instantly switch back to normal (no delay)
set so=999 " Keep cursor in center (except at top or bottom)
set ignorecase " Ignore capitalization when searching
set smartcase " If searching for 'word', show 'word' and 'Word' but only show 'Word' if searching for 'Word'
set nu rnu " Relative line numbers (and show exact number on current line)
set noswapfile
set autoindent " Enable auto indentation of lines
set tabstop=3 softtabstop=3
set shiftwidth=3
set expandtab
set nobreakindent
set showcmd "Show current pressed key under statusline
set smartindent " Allow Vim to best-effort guess the indentation
set showmatch " Highlights matching brackets
set incsearch " Search as characters are entered
set hlsearch " Highlights matching searcher
set wildmenu " Tab Completion
set wildmode=longest:full,full " First tab brings up options, second tab cycle
set mouse=a " Cursor support
set ruler " Always show current position
set rulerformat=%-12.(%l,%c%V%)%{PencilMode()}\ %P
set lazyredraw " Don't redraw while executing macros for performance boost
set nowrap " Don't wrap lines
set statusline=%<%f\ %h%m%r%w\ \ %{PencilMode()}\ %=\ col\ %c%V\ \ line\ %l\,%L\ %P
set laststatus=2
set splitbelow
set splitright
" -- }}}

" -- {{{ Command remaps
" Set leader key to space"
nnoremap <SPACE> <Nop>
let mapleader = " "

" Save write protected file
cmap w!! w !sudo tee % >/dev/null
" -- }}}

" -- {{{ Key remaps
" Source files
nnoremap <leader>s :source %<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>

" Quickly open dotfiles
nnoremap <leader>dv :tabnew ~/.vimrc<CR>
nnoremap <leader>dz :tabnew ~/.zshrc<CR>
nnoremap <leader>da :tabnew ~/.config/awesome/rc.lua<CR>
nnoremap <leader>db :tabnew ~/.config/bspwm/bspwmrc<CR>
nnoremap <leader>ds :tabnew ~/.config/sxhkd/sxhkdrc<CR>

" Toggle NERDTree
nmap <silent> <leader>f :NERDTreeToggle %<CR>

" Stop highlighting search
nnoremap <silent> <C-l> :let @/ = ""<CR>

" Remap k to work in wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj' 
" Remap j to work in wrapped lines
nnoremap <expr> k v:count ? 'k' : 'gk' 

" System clipboard (and primary selection)
vnoremap <C-c> "*y :let @+=@*<CR>

" -- }}}

" -- {{{ Split and tab customization
" Tab cycling"
nnoremap H gT
nnoremap L gt

" Split navigation
nnoremap <silent> <Esc>h :winc h<CR>
nnoremap <silent> <Esc>j :winc j<CR>
nnoremap <silent> <Esc>k :winc k<CR>
nnoremap <silent> <Esc>l :winc l<CR>

" Resize split panes
"nnoremap <silent> <leader>; = :res +3<CR>
"nnoremap <silent> <leader>y = :res -3<CR>
"nnoremap <silent> <leader>, = :vert res -3<CR>
"nnoremap <silent> <leader>. = :vert res +3<CR>

nnoremap <silent> <Esc>; = :res +3<CR>
nnoremap <silent> <Esc>y = :res -3<CR>
nnoremap <silent> <Esc>, = :vert res -3<CR>
nnoremap <silent> <Esc>. = :vert res +3<CR>
" Kill focused split pane
nnoremap <C-q> <C-W>q

" Open a vertically split terminal
nnoremap <silent> <leader>t = :vert term<CR>
nnoremap <silent> <leader>ht = :term<CR>
" -- }}}

" -- {{{ Aesthetic customization
"   -- {{{ Colors
colorscheme lena

highlight Normal ctermbg=NONE
highlight LineNr term=bold cterm=bold ctermbg=NONE
"highlight Comment cterm=italic gui=italic
"   -- }}}

"   -- {{{ Cursor Shape

" Start in block
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup End

" Change cursor shape in Termite/Kitty
let &t_SI = "\<Esc>[4 q"
let &t_SR = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

" Change cursor shape on Mac
"let &t_SI = 
"\<Esc>]50;CursorShape=2\x7
"let &t_SR = 
"\<Esc>]50;CursorShape=1\x7
"let &t_EI = 
"\<Esc>]50;CursorShape=0\x7
"   -- }}}
" -- }}}

" Return to last edit position when opening files
augroup last_edit
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" -- {{{ Nerdtree configuration
" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1
" Open nerdtree on the right
let g:NERDTreeWinPos = "right"
" Show hidden files on startup
let NERDTreeShowHidden = 1
" Make nerdtree smaller
let NERDTreeWinSize = 27
" Disable help text
let NERDTreeMinimalUI = 1

function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
    if IsNERDTreeOpen()
        exec ':NERDTreeToggle'
    else
        exec ':NERDTreeFind'
    endif
endfunction
" -- }}}

" -- {{{ LaTeX settings
"let g:vimtex_view_method = 'skim'
"let g:vimtex_quickfix_ignore_filters = [
"      \ 'LaTeX Warning: Command \\under\(bar\|line\)  has changed.',
"      \ 'Over-specification in `v',
"      \ '\\headheight is too small'
"      \]
" -- }}}

" -- {{{ Auto close tags settings
let g:closetag_filenames = '*.xml, *.html,*.xhtml,*.phtml,*.jsx, *.js, *.tsx'
let g:closetag_xhtml_filenames = '*xml, *.xhtml,*.jsx, *.js, *.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml, jsx, js, tsx'
let g:closetag_xhtml_filetypes = 'xml, xhtml,jsx, js, tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '<'
let g:closetag_close_shortcut = '<leader>>'
" -- }}}

" -- {{{ Ditto (highlight repeated words)
au FileType txt,markdown,text,tex DittoOn  " Turn on Ditto's autocmds
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches
" -- }}}

" -- {{{ Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_default_coefficient = 0.7
" -- }}}

" -- {{{ Pencil
augroup pencil
    autocmd!
    autocmd FileType text,txt call pencil#init({'wrap': 'soft'})
augroup END

" -- {{{ Coc
"    -- {{{ Use tab key to navigate
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"    -- }}}
" Disable popup suggestions in text documents
autocmd FileType text,txt let b:coc_suggest_disable = 1
" -- }}}
