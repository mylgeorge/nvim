"  Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Declare the general config group for autocommand
augroup vimrc
  autocmd!
augroup END

"------------------
" general binding
"------------------

let g:mapleader = "\<Space>"
nmap <leader>o o<esc>
nmap <leader>O O<esc>
map <esc> :noh<cr>

" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"<cr>
map <leader>' ysiw'<cr>

" indent without kill the selection in vmode
vmap < <gv
vmap > >gv

"-----------------
" general config
"-----------------

" display tabs, trailing spaces

" change cursor in nvim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" colorscheme

" set the directory where the swap file will be saved
" set backupdir=~/.config/nvim/backup/
" set directory=~/.config/nvim/swap/

" save undo trees in files
if has('persistent_undo')
  silent !mkdir ~/.config/nvim/undo > /dev/null 2>&1
  set undodir=~/.config/nvim/undo
  set undofile
endif

" set line number
set number
set relativenumber

" the copy goes to the clipboard
set clipboard+=unnamedplus

" use 4 spaces instead of tab (to replace existing tab use :retab)
" copy indent from current line when starting a new line
set autoindent
set expandtab
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" when at 3 spaces, and I hit > ... go to 4, not 7
set shiftround

" number of undo saved in memory
set undolevels=10000
set history=1000

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
set gdefault   " when on, the :substitute flag 'g' is default on

" set list
set list listchars=tab:\┆\ ,trail:·,nbsp:±

set hidden      " hide buffers instead of closing - doesn't prompt a warning when opening a file and the current file was written but not saved
set lazyredraw  " speed up on large files
set mouse=      " disable mouse
set showmode    " doesn't display the mode status

" Keep cursor more in middle when scrolling down / up
set scrolloff=300

" no swap files! This is just annoying
set noswapfile
set nobackup
set nowb

" read and write automatically when quitting buffer
set autowrite
set autoread

set laststatus=1 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

" Quick way to save file
nmap <leader>w :write<CR>
nmap <Leader>r :redraw!<Enter>

" Enables you to save files with :w!! by using sudo if you forgot to open it as root
cmap w!! %!sudo tee > /dev/null %

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS> :1,$s/[  ]*$//<CR>:nohlsearch<CR>1G

" restore the position of the last cursor when you open a file
" autocmd vimrc BufReadPost * call general#RestorePosition()


" Autoinstall vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

"----------------
" install plugin
"-----------------
call plug#begin('~/.config/nvim/plugged') " Plugins initialization start {{{
" }}}
" File Navigation
" ====================================================================
" {{{
Plug 'scrooloose/nerdtree'
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeHijackNetrw = 0
  let g:NERDTreeWinSize = 31
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeCascadeOpenSingleChildDir = 1

  map <F2> :call NERDTreeToggleAndFind()<cr>
  map <F3> :NERDTreeToggle<CR>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction
" }}}

" fzf - poweful fuzzy finder
" {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader><tab>   :Buffers<CR>
  nnoremap <silent> <leader>W :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <leader>. :AgIn

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gc :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction

  function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
  endfunction
  command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
" }}}

" Text Navigation
" ====================================================================
" {{{
Plug 'Lokaltog/vim-easymotion'
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  nmap \ <Plug>(easymotion-sn)
  nmap s <Plug>(easymotion-overwin-f)
" }}}
" {{{
Plug 'rhysd/clever-f.vim'
  let g:clever_f_acro = 1
  let g:clever_f_smart_case = 1
" }}}

" Text Manipulation
" ====================================================================
" surrounding with whatever you want (paranthesis, quotes...)
Plug 'tpope/vim-surround'
" {{{
Plug 'junegunn/vim-easy-align'
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>
" }}}
" {{{
Plug 'tomtom/tcomment_vim'
"  }}}
" Plug 'Raimondi/delimitMate'
" {{{
"   let delimitMate_expand_cr = 2
"   let delimitMate_expand_space = 1 " {|} => { | }
" }}}
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'AndrewRadev/switch.vim'
" {{{
"   let g:switch_mapping = '\'
" }}}
" Plug 'AndrewRadev/sideways.vim'
" {{{
"   nnoremap <Leader>< :SidewaysLeft<CR>
"   nnoremap <Leader>> :SidewaysRight<CR>
" }}}
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-speeddating'
" Plug 'tpope/vim-abolish'

" snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" Utility
" ====================================================================

" Plug 'ludovicchabant/vim-gutentags'
" " {{{
"   let g:gutentags_exclude = [
"       \ '*.min.js',
"       \ '*html*',
"       \ 'jquery*.js',
"       \ '*/vendor/*',
"       \ '*/node_modules/*',
"       \ '*/python2.7/*',
"       \ '*/migrate/*.rb'
"       \ ]
"   let g:gutentags_generate_on_missing = 0
"   let g:gutentags_generate_on_write = 0
"   let g:gutentags_generate_on_new = 0
"   nnoremap <leader>t! :GutentagsUpdate!<CR>
" " }}}

" Plug 'StanAngeloff/php.vim'
" php autocompletion engine and tools
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
nnoremap <silent><leader>l :call PhpCsFixerFixFile()<CR>
let g:php_cs_fixer_verbose = 0
" Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
" Plug 'nishigori/vim-php-dictionary', {'for': 'php'}

" php doc autocompletion
" Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'}


" refactoring options
" Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
" Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
" Plug 'roxma/ncm-phpactor',  {'for': 'php'}
" Plug '2072/php-indenting-for-vim', {'for': 'php'}


" javascript plugins
" Plug 'pangloss/vim-javascript'
" need to run npm install in the folder ~/nvim/plugged/tern_for_vim
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }

" Syntax highlighting for vue js framework
" Plug 'posva/vim-vue'

" Plug 'roxma/nvim-completion-manager'

call plug#end()  " Plugins initialization finished {{{
" }}}

"----------------
" plugin config
"----------------

