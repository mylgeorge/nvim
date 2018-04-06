" Skip initialization for vim-tiny or vim-small.
" twig
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Declare the general config group for autocommand
augroup vimrc
  autocmd!
augroup END

" Autoinstall vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
"
"----------------
" install plugin
"-----------------
call plug#begin('~/.config/nvim/plugged')


" File Navigation
" ====================================================================
Plug 'scrooloose/nerdtree'
" {{{
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
" }}}<Paste>

" fzf - poweful fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
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
Plug 'Lokaltog/vim-easymotion'
" {{{
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_off_screen_search = 0
  nmap ; <Plug>(easymotion-s2)
" }}}
Plug 'rhysd/clever-f.vim'
" {{{
  let g:clever_f_across_no_line = 1
" }}}

" Text Manipulation
" ====================================================================

" surrounding with whatever you want (paranthesis, quotes...)
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
" {{{
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>
" }}}
" Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-commentary'
" {{{
  map <C-_> gcc
"  }}}
Plug 'Raimondi/delimitMate'
" {{{
  let delimitMate_expand_cr = 2
  let delimitMate_expand_space = 1 " {|} => { | }
" }}}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
" {{{
  let g:switch_mapping = '\'
" }}}
Plug 'AndrewRadev/sideways.vim'
" {{{
  nnoremap <Leader>< :SidewaysLeft<CR>
  nnoremap <Leader>> :SidewaysRight<CR>
" }}}
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'

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
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}

" php doc autocompletion
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'}


" refactoring options
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'roxma/ncm-phpactor',  {'for': 'php'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}


" javascript plugins
Plug 'pangloss/vim-javascript'
" need to run npm install in the folder ~/nvim/plugged/tern_for_vim
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }

" Syntax highlighting for vue js framework
Plug 'posva/vim-vue'

Plug 'roxma/nvim-completion-manager'

call plug#end()  " Plugins initialization finished {{{
" }}}

"----------------
" plugin config
"----------------

"------------------
" general binding
"------------------

map <SPACE> <leader>
let g:mapleader = "\<Space>"
nmap <leader>o o<esc>

" Enables you to save files with :w!! by using sudo if you forgot to open it as root
cmap w!! %!sudo tee > /dev/null %

" display tabs, trailing spaces

"-----------------
" general config
"-----------------

" change cursor in nvim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" colorscheme

" set the directory where the swap file will be saved
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/

" save undo trees in files
set undofile
set undodir=~/.config/nvim/undo/

" set line number
set number
set relativenumber

" the copy goes to the clipboard
set clipboard+=unnamedplus

" use 4 spaces instead of tab (to replace existing tab use :retab)
" copy indent from current line when starting a new line
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" when at 3 spaces, and I hit > ... go to 4, not 7
set shiftround

" number of undo saved in memory
set undolevels=10000

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
set gdefault   " when on, the :substitute flag 'g' is default on

" set list
set list listchars=tab:\┆\ ,trail:·,nbsp:±

set hidden      " hide buffers instead of closing - doesn't prompt a warning when opening a file and the current file was written but not saved
set lazyredraw  " speed up on large files
set mouse=      " disable mouse
set noshowmode  " doesn't display the mode status

" Keep cursor more in middle when scrolling down / up
set scrolloff=30

" no swap file! This is just annoying
set noswapfile

" write automatically when quitting buffer
set autowrite

set laststatus=2 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

" Quick way to save file
nnoremap <leader>w :w<CR><Paste>

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS> :1,$s/[  ]*$//<CR>:nohlsearch<CR>1G

