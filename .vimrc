" Neovim true color
set termguicolors

" Insert mode cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Local directories
" Double //'s make it save the full path
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
set undodir=~/.vim/undo//

" Syntax highlighting
" set t_Co=256
syntax on

" Basic settings
set autoindent " Copy indent from last line when starting new line
set history=1000 " Increase history from 20 default to 1000
set nostartofline " Don't reset cursor to start of line when moving around
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set diffopt+=vertical " fugitive should open vertical diffs
set clipboard+=unnamed " Use system clipboards when available
set number
set undofile " Persistent Undo
set lazyredraw " Don't redraw when we don't have to
set expandtab " Expand tabs to spaces
set nowrap " Do not wrap lines
set incsearch " Highlight dynamically as pattern is typed
set scrolloff=3 " Start scrolling three lines before horizontal border of window
set shiftwidth=2 " The # of spaces for indenting
set softtabstop=2 " Tab key results in 2 spaces
set wrapscan " Searches wrap around end of file
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set listchars=tab:▸\ ,trail:▫
let mapleader=","

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Pretty print json
map <leader>j <Esc>:%!python -mjson.tool<CR>

" Better split switching
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
if has('nvim')
  nmap <BS> <C-W>h
endif

" Back space goes to previous file
" nnoremap <BS> <C-^>

" Clear last search
map <silent> <leader>qs <Esc>:noh<CR>

" Fzf
" respect node modules
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
noremap <C-p> :FZF<ENTER>

" ACK CONFIG
augroup ack_config
  autocmd!
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    cnoreabbrev ag Ack!
    cnoreabbrev Ag Ack!
  endif
  cnoreabbrev Ack Ack!
augroup END

" Nerd commenter
augroup nerd_commenter
  autocmd!

  let NERDSpaceDelims=1
  let NERDCompactSexyComs=1
  let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
augroup END

" Airline
augroup airline_config
  autocmd!
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline_theme='base16'
augroup END

augroup ale
  let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint'],
\   'html': [],
\}
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '�'
augroup END
" Neomake
" autocmd! BufWritePost * Neomake
" let g:neomake_javascript_enabled_makers = ['eslint']

" Dispatch
map <Leader>t :Dispatch rspec %<CR>

" Plugins
call plug#begin('~/.vim/plugged')
" Plug 'vim-syntastic/syntastic'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
" Indentation for javascript
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'rust-lang/rust.vim'
Plug 'w0rp/ale'
Plug 'tmhedberg/matchit'
Plug 'leafgarland/typescript-vim'
Plug 'elixir-lang/vim-elixir'
call plug#end()

set background=dark
colorscheme base16-default-dark
