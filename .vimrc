" vim:fdm=marker

" Settings -------------------------------------------------------------

" Preamble {{{

" NeoVim {{{
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}

" Syntax highlighting {{{
set t_Co=256
syntax on
" }}}

" Mapleader {{{
let mapleader=","
" }}}


set re=0

" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" }}}

" Set some junk {{{
set autoindent " Copy indent from last line when starting new line
set clipboard+=unnamedplus " Use system clipboards when available
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
if !has('nvim')
  set encoding=utf-8 nobomb " BOM often causes trouble
end
set esckeys " Allow cursor keys in insert mode
set expandtab " Expand tabs to spaces
set hidden " When a buffer is brought to foreground, remember undo history and marks
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set lazyredraw " Don't redraw when we don't have to
set magic " Enable extended regexes
set mouse=a " Enable mouse in all in all modes
set noerrorbells " Disable error bells
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set nu " Enable line numbers
set ofu=syntaxcomplete#Complete " Set omni-completion method
set regexpengine=1 " Use the old regular expression engine (it's faster for certain language syntaxes)
set report=0 " Show all changes
set ruler " Show the cursor position
set scrolloff=3 " Start scrolling three lines before horizontal border of window
set shiftwidth=2 " The # of spaces for indenting
set shortmess=atI " Don't show the intro message when starting vim
set showtabline=2 " Always show tab bar
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2 " Tab key results in 2 spaces
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set switchbuf=""
set title " Show the filename in the window titlebar
set undofile " Persistent Undo
" set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set winminheight=0 " Allow splits to be reduced to a single line
set wrapscan " Searches wrap around end of file
set listchars=tab:▸\ ,trail:▫

" }}}

" }}}


" Configuration -------------------------------------------------------------

" FastEscape {{{
" Speed up transition from modes
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
" }}}

" General {{{
augroup general_config
  autocmd!
  " delete trailing spaces on save {{{
  autocmd BufWritePre * :%s/\s\+$//e
  " }}}

  " Speed up viewport scrolling {{{
  nnoremap <C-e> 3<C-e>
  nnoremap <C-y> 3<C-y>
  " }}}

  " Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l) {{{
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  nnoremap <C-j> <C-W>j
  nnoremap <C-k> <C-W>k
  nnoremap <C-H> <C-W>h
  nnoremap <C-L> <C-W>l
  nnoremap Q <nop>

  " Map new term keys {{{
  command! Tsp sp term://zsh
  command! Tvsp vsp term://zsh
  " }}}

  " Important fix for ctrl-h being interpreted as backspace on osx
  nmap <BS> <C-W>h
  " }}}

  " Sudo write (,W) {{{
  noremap <leader>W :w !sudo tee %<CR>
  " }}}

  " Remap :W to :w {{{
  command! W w
  " }}}

  " Better mark jumping (line + col) {{{
  nnoremap ' `
  " }}}

  " Hard to type things {{{
  iabbrev >> →
  iabbrev << ←
  iabbrev ^^ ↑
  iabbrev VV ↓
  iabbrev aa λ
  " }}}

  " Toggle show tabs and trailing spaces (,c) {{{
  set lcs=tab:›\ ,trail:·,eol:¬,nbsp:_
  set fcs=fold:-
  nnoremap <silent> <leader>c :set nolist!<CR>
  " }}}

  " Clear last search (,qs) {{{
  map <silent> <leader>qs <Esc>:noh<CR>
  " }}}

  " Paste toggle (,p) {{{
  set pastetoggle=<leader>p
  map <leader>p :set invpaste paste?<CR>
  " }}}

  " Yank from cursor to end of line {{{
  nnoremap Y y$
  " }}}

  " Search and replace word under cursor (,*) {{{
  nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>
  vnoremap <leader>* "hy:%s/\V<C-r>h//<left>
  " }}}

  " Strip trailing whitespace (,ss) {{{
  function! StripWhitespace () " {{{
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  endfunction " }}}
  noremap <leader>ss :call StripWhitespace ()<CR>
  " }}}

  " Join lines and restore cursor location (J) {{{
  nnoremap J mjJ`j " }}}

  " Toggle folds (<Space>) {{{
  nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>
  " }}}

  " Fix page up and down {{{
  map <PageUp> <C-U>
  map <PageDown> <C-D>
  imap <PageUp> <C-O><C-U>
  imap <PageDown> <C-O><C-D>
  " }}}

  " Pretty print json {{{
  map <leader>j <Esc>:%!python -mjson.tool<CR>
  " }}}

  " Relative numbers {{{
  set relativenumber " Use relative line numbers. Current line is still in status bar.
  au BufReadPost,BufNewFile * set relativenumber
  " }}}

" NERD Commenter {{{
augroup nerd_commenter
  autocmd!

  let NERDSpaceDelims=1
  let NERDCompactSexyComs=1
  let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }
augroup END
" }}}

" Buffers {{{
augroup buffer_control
  autocmd!

  " Buffer navigation (,,) (gb) (gB) (,ls) {{{
  map <Leader>, <C-^>
  map <Leader>ls :buffers<CR>
  map gb :bnext<CR>
  map gB :bprev<CR>
  " }}}

  " Jump to buffer number (<N>gb) {{{
  let c = 1
  while c <= 99
    execute "nnoremap " . c . "gb :" . c . "b\<CR>"
    let c += 1
  endwhile
  " }}}

  " Close Quickfix window (,qq) {{{
  map <leader>qq :cclose<CR>
  " }}}
augroup END
" }}}

" Highlight Interesting Words {{{
augroup highlight_interesting_word
  autocmd!
  " This mini-plugin provides a few mappings for highlighting words temporarily.
  "
  " Sometimes you're looking at a hairy piece of code and would like a certain
  " word or two to stand out temporarily.  You can search for it, but that only
  " gives you one color of highlighting.  Now you can use <leader>N where N is
  " a number from 1-6 to highlight the current word in a specific color.
  function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
  endfunction " }}}

  " Mappings {{{
  nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
  nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
  nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
  nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
  nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
  nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
  " }}}

  " Default Highlights {{{
  " hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
  " hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
  " hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
  " hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
  " hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
  " hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
  " }}}
augroup END
" }}}

" Word Processor Mode {{{
augroup word_processor_mode
  autocmd!

  function! WordProcessorMode() " {{{
    setlocal formatoptions=t1
    map j gj
    map k gk
    setlocal smartindent
    setlocal spell spelllang=en_ca
    setlocal noexpandtab
    setlocal wrap
    setlocal linebreak
    Goyo 100
  endfunction " }}}
  com! WP call WordProcessorMode()
augroup END
" }}}


" Filetypes -------------------------------------------------------------

" C {{{
augroup filetype_c
  autocmd!

  " Highlight Custom C Types {{{
  autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
  autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
  autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
  autocmd BufRead,BufNewFile *.[ch] endif
  " }}}
augroup END
" }}}

" Coffee {{{
augroup filetype_coffee
  autocmd!
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
augroup END
" }}}

" Handlebars {{{
augroup filetype_hbs
  autocmd!
  au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb setl ft=mustache syntax=mustache
augroup END
" }}}

" Jade {{{
augroup filetype_jade
  autocmd!
  au BufRead,BufNewFile *.jade set ft=jade syntax=jade
augroup END
" }}}

" JavaScript {{{
augroup filetype_javascript
  autocmd!
  let g:jsx_ext_required = 0
augroup END
" }}}

" JSON {{{
augroup filetype_json
  autocmd!
  au BufRead,BufNewFile *.json set ft=json syntax=javascript
augroup END
" }}}

" Markdown {{{
augroup filetype_markdown
  autocmd!
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END
" }}}

" Ruby {{{
augroup filetype_ruby
  autocmd!

  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

  " Ruby.vim
  let ruby_operators = 1
  let ruby_space_errors = 1
augroup END
" }}}

" XML {{{
augroup filetype_xml
  autocmd!
  au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
augroup END
" }}}

" ZSH {{{
augroup filetype_zsh
  autocmd!
  au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh
augroup END
" }}}


" Plugin Configuration -------------------------------------------------------------

" Airline.vim {{{
augroup airline_config
  autocmd!
  let g:airline_powerline_fonts = 1
  " let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':p:.'
augroup END
" }}}

" Silver Searcher {{{
augroup ag_config
  autocmd!

  if executable("ag")
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m

    " Have the silver searcher ignore all the same things as wilgignore
    let b:ag_command = 'ag %s -i --nocolor --nogroup'

    for i in split(&wildignore, ",")
      let i = substitute(i, '\*/\(.*\)/\*', '\1', 'g')
      let b:ag_command = b:ag_command . ' --ignore "' . substitute(i, '\*/\(.*\)/\*', '\1', 'g') . '"'
    endfor

    let b:ag_command = b:ag_command . ' --hidden -g ""'
    ca Ag Ag!
  endif
augroup END
" }}}

" EasyAlign.vim {{{
augroup easy_align_config
  autocmd!
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
augroup END
" }}}

" Notes.vim {{{
augroup notes_config
autocmd!
let g:notes_directories = ['~/Dropbox/Notes']
augroup END
" }}}

"Neomake {{{
autocmd BufReadPost,BufWritePost *.js Neomake
autocmd BufReadPost,BufWritePost *.rb Neomake
let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
let g:neomake_place_signs=1
let g:neomake_echo_current_error=1
let g:neomake_javascript_enabled_makers = ['jshint', 'jscs']
let g:neomake_ruby_enabled_makers=['rubocop']
"}}}
"}}}
"FZF {{{
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
noremap <C-p> :FZF<ENTER>
"}}}

"Term split settings {{{
" highlight TermCursor ctermfg=5 guifg=#FF0000
set splitbelow
set splitright
tnoremap <Leader><ESC> <C-\><C-n>
" }}}

" NerdTree {{{
map <C-n> :NERDTreeToggle<CR>
" }}}
"
" Gutentags {{{
let g:gutentags_exclude=['phonegap']
" }}}

" Plugins -------------------------------------------------------------

" Load plugins {{{
call plug#begin('~/.nvim/plugged')
" Highlights colors in css
Plug 'ap/vim-css-color'
" Airline
Plug 'bling/vim-airline'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Syntax files
Plug 'JulesWang/css.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
 Plug 'tpope/vim-markdown', { 'for': 'markdown' }
 Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Visual mode <Enter> <align around>
 Plug 'junegunn/vim-easy-align'
" <C-n>
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
 Plug 'tpope/vim-vinegar'
" Distrcation free writing :Goyo
 Plug 'junegunn/goyo.vim'
" Snips
"  Plug 'SirVer/UltiSnips'
"  Plug 'honza/vim-snippets'
" Indent guidelines <leader> ig
" Plug 'nathanaelkane/vim-indent-guides'
" The silver searcher
Plug 'rking/ag.vim'
" Commenting <leader>ci
Plug 'scrooloose/nerdcommenter'

" Plug 'ngmy/vim-rubocop'
" Lightweight rspec runner
" Plug 'thoughtbot/vim-rspec'
" Badass git vim plugin
Plug 'tpope/vim-fugitive'
" Allows plugins to repeat (like surround)
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }
" Used for vim-notes
Plug 'xolox/vim-misc'
" :Note
Plug 'xolox/vim-notes'
" Automatically create a file/dir that doesn't exist
Plug 'pbrisbin/vim-mkdir'
"
"[<space> ]<space>
Plug 'tpope/vim-unimpaired'
Plug 'b4winckler/vim-objc'

Plug 'benekastah/neomake'
" Plug 'scrooloose/syntastic'

" Color schemes
" Plug 'junegunn/seoul256.vim'
Plug 'sjl/badwolf'

Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-lang/vim-elixir'

Plug 'ludovicchabant/vim-gutentags'
call plug#end()

set background=dark
colorscheme badwolf
