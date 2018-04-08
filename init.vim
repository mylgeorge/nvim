" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Declare the general config group for autocommand
augroup vimrc
  autocmd!
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
    set nocompatible
endif

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set autowrite

" the copy goes to the clipboard
set clipboard+=unnamedplus

" Sets how many lines of history VIM has to remember
set history=1000
set undolevels=10000

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" save undo trees in files
if has('persistent_undo')
  silent !mkdir ~/.config/nvim/undo > /dev/null 2>&1
  set undodir=~/.config/nvim/undo
  set undofile
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let g:mapleader = "\<Space>"

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <leader>e :e!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the Wild menu
set wildmenu
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set number " set line number
set scrolloff=300 " Keep cursor more in middle when scrolling down / up
set hidden        " hide buffers instead of closing - doesn't prompt a warning when opening a file and the current file was written but not saved
set ruler         " Displays cursor position on bottom right of screen
set ignorecase    " Case Insensitive Searching
set smartcase     " Lowercase = case insensitive, any uppercase = case sensitive
set hlsearch      " Highlight all search results
set incsearch     " Search while typing
set gdefault      " when on, the :substitute flag 'g' is default on
set lazyredraw    " speed up on large files
set magic         " For regular expressions turn magic on
set showmatch     " Show matching brackets when text indicator is over them
set mat=2         " How many tenths of a second to blink when matching brackets

set autoindent
set smartindent
set expandtab     " Use spaces instead of tabs
set smarttab      " Be smart when using tabs ;)
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround    " when at 3 spaces, and I hit > ... go to 4, not 7

set lbr           " Linebreak on 500 characters
set tw=500
set nowrap
set textwidth=0   " disable auto break long lines

set list listchars=tab:\┆\ ,trail:·,nbsp:±
set laststatus=2 " always show status line
set mouse=      " disable mouse
set noshowmode  " doesn't display the mode status
set cursorline
au WinEnter * setlocal cursorline " | setlocal cursorcolumn
au WinLeave * setlocal nocursorline " | setlocal nocursorcolumn

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
set background=dark
set t_Co=256

try
    colorscheme monokai
catch
    colorscheme desert
endtry

set encoding=utf8    " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac " Use Unix as the standard file type

    " PHP {{{
        hi! link phpIdentifier Normal
        hi! link phpVarSelector phpIdentifier
        hi! link phpFunction SublimeOrange
        hi! link phpFunctions Typedef
        hi! link phpMethod Tag
        hi! link phpType Define
        hi! link phpKeyword Define
        hi! link phpParent Normal
        hi! link phpStatement Keyword
        hi! link phpDefine phpStatement
        hi! link phpInclude phpStatement
        hi! link phpNull Boolean
    " }}}
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>h :noh<CR>
nnoremap <cr> o

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS> :1,$s/[  ]*$//<CR>:nohlsearch<CR>1G
" }}}



" -----------------------------------------------------------------------

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
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" colorscheme

" hi Normal guifg=#fefefe guibg=#272822 guisp=#272822 gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
" hi operator guifg=eeee guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
" hi! link phpIdentifier Cyan
" hi! link phpQuoteSingle StringDelimiter
" hi! link phpQuoteDouble StringDelimiter
" hi! link phpBoolean Constant
" hi! link phpNull Constant
" hi! link phpArrayPair Operator
" hi! link phpOperator Normal
" hi! link phpRelation Normal
" set the directory where the swap file will be saved
" set backupdir=~/.config/nvim/backup/
" set directory=~/.config/nvim/swap/




" use 4 spaces instead of tab (to replace existing tab use :retab)
" copy indent from current line when starting a new line

" number of undo saved in memory

" Use case insensitive search, except when using capital letters
"------  Searching  ------
"Following line clears the search highlights when pressing Lb





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
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>W :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>t :BTags<CR>
  nnoremap <silent> <leader>T :Tags<CR>
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
" {{{
Plug 'Raimondi/delimitMate'
   let delimitMate_expand_cr = 2
   let delimitMate_expand_space = 1 " {|} => { | }
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
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
" snippets
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Autocomplete
" ====================================================================
let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#custom#converters = ['converter_auto_paren']
endif
" let g:deoplete#converter_auto_paren = 1
" let g:deoplete#tag#cache_limit_size = 900000000
" let g:deoplete#source = {}
" let g:deoplete#source._ = ['buffer', 'tag']
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
" command! PadawanStart call deoplete#sources#padawan#StartServer()
" command! PadawanStop call deoplete#sources#padawan#StopServer()
" command! PadawanRestart call deoplete#sources#padawan#RestartServer()
" command! PadawanInstall call deoplete#sources#padawan#InstallServer()
" command! PadawanUpdate call deoplete#sources#padawan#UpdateServer()
" command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" Utility
" ====================================================================

Plug 'ludovicchabant/vim-gutentags'
" " {{{
let g:gutentags_cache_dir = '~/.config/nvim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']
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
nnoremap <leader>tt :GutentagsUpdate!<CR>
" " }}}

" php autocompletion engine and tools
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
nnoremap <silent><leader>l :call PhpCsFixerFixFile()<CR>
let g:php_cs_fixer_verbose = 0
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
" Plug 'nishigori/vim-php-dictionary', {'for': 'php'}

" php doc autocompletion
" Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'}


" refactoring options
" Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
" Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
" Plug 'roxma/ncm-phpactor',  {'for': 'php'}
" Plug '2072/php-indenting-for-vim', {'for': 'php'}


" javascript plugins
Plug 'pangloss/vim-javascript'
" need to run npm install in the folder ~/nvim/plugged/tern_for_vim
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }

" Syntax highlighting for vue js framework
Plug 'posva/vim-vue'

" Plug 'roxma/nvim-completion-manager'
" Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

call plug#end()  " Plugins initialization finished {{{
" }}}

"----------------
" plugin config
"----------------
" vim: fdm=marker
