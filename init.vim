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

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

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
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns


autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
nmap <leader>f :Files<CR>
nmap <leader>l :Lines<CR>
nmap <leader>c :Commits<CR>
nmap <leader>b :Buffer<CR>
nmap <leader>m :Marks<CR>
nmap <leader>rg :Rg<Space>
nmap <leader>v :e ~/.config/nvim/init.vim<CR>

" inoremap { {}<Esc>i<Space>

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
      \ 'colorscheme': 'one',
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
      \ '',
      \ '',
      \]
let g:commands = [
      \ 'gd  - definition',
      \ 'gy  - type definition',
      \ 'gi  - implementation',
      \ 'gr  - references',
      \ 'rn  - rename variable',
      \ 'aap - do something for paragraph',
      \ 'K   - show documentation',
      \]
let g:startify_custom_header =
      \ 'map(g:ascii + g:commands, "\"   \".v:val")'
" let g:startify_custom_header =
      " \ 'map(g:commands + startify#fortune#boxed(), "\"   \".v:val")'


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Plugins
call plug#begin('~/.nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'roman/golden-ratio'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'rakr/vim-one'
Plug 'airblade/vim-rooter'

call plug#end()

set background=dark
colorscheme one
