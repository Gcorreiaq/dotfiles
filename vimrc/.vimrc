execute pathogen#infect()
syntax on
let NERDTreeShowHidden=1
let vim_markdown_preview_github=1
let vim_markdown_preview_use_xdg_open=1

set nobackup
set wildmenu
set wildmode=list:longest

map [ :tabprevious <CR>
map ] :tabnext <CR>
map <leader>f :NERDTreeToggle<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>
nnoremap <leader>w :q<CR>
nnoremap <leader>e :tabnew<CR>
nnoremap YY "+yy
nnoremap DD "+dd
nnoremap <c-j> jzz
nnoremap <c-k> kzz
inoremap jj <esc>l
inoremap JJ <esc>:w<CR>
vnoremap YY "+y
nnoremap PP "+p
set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab
set number
:colorscheme zenburn


set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

execute 'normal "zz"'
