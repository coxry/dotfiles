filetype plugin on
set termguicolors
filetype indent plugin on

scriptencoding utf-8
set encoding=utf-8

" Local directories
" Double //'s make it save the full path
set backupdir=~/.nvim/backups//
set directory=~/.nvim/swaps//
set undodir=~/.nvim/undo//

" Syntax highlighting
syntax on

" Basic settings
set autoindent " Copy indent from last line when starting new line
set hidden " Don't kill terminal buffers
set history=1000 " Increase history from 20 default to 1000
set nostartofline " Don't reset cursor to start of line when moving around
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set diffopt+=vertical " fugitive should open vertical diffs
set clipboard+=unnamed " Use system clipboards when available
set ignorecase " Case insensitive matching
set smartcase " Ignore case insensitive if an upper case letter is used
set number " Show the number of the current line
set rnu " Relative line numbers
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
set winheight=5
set winminheight=5
set inccommand=nosplit " Neovim substitute with live feedback

" Normal mode mappings
let mapleader=","
nmap <leader>l :set list!<CR>
nmap <leader>j <Esc>:%!python -mjson.tool<CR>
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
if has('nvim')
  nmap <BS> <C-W>h
  tnoremap <C-[> <C-\><C-n>
  tnoremap <A-[> <Esc>
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-l> <C-\><C-n><C-w>l
endif
nmap <leader>h :noh<CR>
nmap <leader>f :FZF<CR>
nmap <leader>l :Lines<CR>
nmap <leader>c :Commits<CR>
nmap <leader>b :Buffer<CR>
nmap <leader>rg :Rg<Space>
nmap <leader>p :e package.json<CR>

" FZF command
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --glob "!.git/*"'

" Use homebrew python 2/3
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Nerd commenter
augroup nerd_commenter
  autocmd!

  let NERDSpaceDelims=1
  let NERDCompactSexyComs=1
  let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
augroup END

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component': {
      \   'filepath': '%F'
      \ },
      \ }

augroup ale
  let g:ale_linters = {
        \   'ruby': ['rubocop'],
        \   'javascript': ['eslint'],
        \   'html': [],
        \}
  let g:ale_fixers = {
        \ '*': ['trim_whitespace', 'remove_trailing_lines'],
        \ 'javascript': ['eslint', 'trim_whitespace', 'remove_trailing_lines'],
        \ 'typescript': ['eslint', 'trim_whitespace', 'remove_trailing_lines'],
        \}
  let g:ale_fix_on_save = 1
  let g:ale_sign_error = '⚠'
  let g:ale_sign_warning = '�'
augroup END

augroup deoplete
  let g:deoplete#enable_at_startup = 1
augroup END

" Create directories if they don't exist
if !exists('*s:MkNonExDir')
  function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
        call mkdir(dir, 'p')
      endif
    endif
  endfunction
endif

augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Cursor highlighting in for terminal mode so that it's easier to know where it pastes
if has('nvim')
  hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=7 guibg=#93a1a1 cterm=NONE gui=NONE
endif

" Startup speedup
let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }


" Custom header
let g:ascii = [
      \ '        __',
      \ '.--.--.|__|.--------.',
      \ '|  |  ||  ||        |',
      \ ' \___/ |__||__|__|__|',
      \ ''
      \]
let g:startify_custom_header =
      \ 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'

" Plugins
call plug#begin('~/.nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'roman/golden-ratio'
Plug 'w0rp/ale'
Plug 'tmhedberg/matchit'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-endwise'
Plug 'mhinz/vim-startify'
Plug 'chriskempson/base16-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

set background=dark
" Color scheme
colorscheme base16-default-dark
