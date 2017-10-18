set termguicolors

" Color scheme
set background=dark
colorscheme onedark

" Local directories
" Double //'s make it save the full path
set backupdir=~/.nvim/backups//
set directory=~/.nvim/swaps//
set undodir=~/.nvim/undo//

" Syntax highlighting
syntax on

" Basic settings
set autoindent " Copy indent from last line when starting new line
set history=1000 " Increase history from 20 default to 1000
set nostartofline " Don't reset cursor to start of line when moving around
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set diffopt+=vertical " fugitive should open vertical diffs
set clipboard+=unnamed " Use system clipboards when available
set ignorecase " Case insensitive matching
set smartcase " Ignore case insensitive if an upper case letter is used
set number
set rnu
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
filetype plugin on

let mapleader=","

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Pretty print json
nmap <leader>j <Esc>:%!python -mjson.tool<CR>

" Better split switching
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
map <space> :
if has('nvim')
  nmap <BS> <C-W>h
endif

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

" Clear last search
nmap <leader>h :noh<CR>

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
map <C-p> :FZF<ENTER>

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
" augroup airline_config
  " autocmd!
  " let g:airline_powerline_fonts = 1
  " let g:airline#extensions#tabline#buffer_nr_format = '%s '
  " let g:airline#extensions#tabline#enabled = 0
  " let g:airline#extensions#tabline#fnamecollapse = 1
  " let g:airline#extensions#tabline#buffer_nr_show = 1
  " let g:airline_theme='onedark'
  " let g:airline_left_sep=''
  " let g:airline_right_sep=''
" augroup END

let g:lightline = {
      \ 'colorscheme': 'onedark',
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
  let g:ale_sign_error = '⚠'
  let g:ale_sign_warning = '�'
augroup END


" Switch between solarized light & dark
" nmap  <leader>B :<c-u>exe "colors" (g:colors_name =~# "dark"
      " \ ? substitute(g:colors_name, 'dark', 'light', '')
      " \ : substitute(g:colors_name, 'light', 'dark', '')
      " \ )<cr>

" Dispatch
map <Leader>t :Dispatch rspec %<CR>

" Toggle golden ratio
nmap <Leader>g <Plug>(golden_ratio_toggle)

" minpack shortcuts
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Plugins
packadd minpac
call minpac#init()
call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
call minpac#add('junegunn/fzf.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('itchyny/lightline.vim')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('tpope/vim-repeat')
call minpac#add('roman/golden-ratio')
call minpac#add('k-takata/minpac', { 'type': 'opt' })
call minpac#add('w0rp/ale')
call minpac#add('tmhedberg/matchit')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('tpope/vim-surround')
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('mileszs/ack.vim')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-projectionist')
