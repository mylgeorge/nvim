let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 init.vim
badd +28 ~/code/app/Http/Controllers/Api/DocumentsController.php
badd +778 /usr/share/nvim/runtime/doc/starting.txt
badd +70 /usr/share/nvim/runtime/doc/windows.txt
badd +1 /usr/share/nvim/runtime/doc/eval.txt
badd +128 ~/code/vendor/laravel/framework/src/Illuminate/Http/Concerns/InteractsWithInput.php
badd +17 ~/code/app/Document.php
badd +76 plugged/lightline.vim/doc/lightline.txt
badd +19 ~/code/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php
badd +55 ~/code/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Concerns/HasRelationships.php
badd +252 ~/code/vendor/laravel/framework/src/Illuminate/Support/Str.php
badd +0 ~/code/resources/assets/js/app.js
argglobal
silent! argdel *
$argadd init.vim
edit /usr/share/nvim/runtime/doc/eval.txt
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
exe '1resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 96 + 96) / 192)
exe '2resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 96 + 96) / 192)
exe '3resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 95 + 96) / 192)
exe '4resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 95 + 96) / 192)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let s:l = 8029 - ((11 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8029
normal! 057|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists('~/.config/nvim/init.vim') | buffer ~/.config/nvim/init.vim | else | edit ~/.config/nvim/init.vim | endif
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 422 - ((11 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
422
normal! 08|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists('~/code/resources/assets/js/app.js') | buffer ~/code/resources/assets/js/app.js | else | edit ~/code/resources/assets/js/app.js | endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 80 - ((11 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
80
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists('~/code/app/Http/Controllers/Api/DocumentsController.php') | buffer ~/code/app/Http/Controllers/Api/DocumentsController.php | else | edit ~/code/app/Http/Controllers/Api/DocumentsController.php | endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 102 - ((11 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
102
normal! 0
lcd ~/
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 1resize ' . ((&columns * 96 + 96) / 192)
exe '2resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 96 + 96) / 192)
exe '3resize ' . ((&lines * 24 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 95 + 96) / 192)
exe '4resize ' . ((&lines * 23 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 95 + 96) / 192)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
