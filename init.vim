set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin('~/.vim/plugged')


" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'
Plug 'rust-lang/rust.vim'
Plug 'valloric/YouCompleteMe'
Plug 'racer-rust/vim-racer'
Plug 'vim-syntastic/syntastic'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'timonv/vim-cargo'

call plug#end() 

let g:ycm_rust_src_path = '/home/rootyjr/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rustc'

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
nmap <silent> <F3> :NERDTreeToggle<CR>
colorscheme oceandeep

nmap <silent> <F4> :execute '!cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . " && cargo run"<CR>
nmap <silent> <F8> :execute '!xdg-open '. expand("%:p:h")<CR>
nmap <silent> <F1><C-y> :execute '!cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . " && git reset --hard origin/master"<CR>
nmap <silent> <F9> :Gsdiff<CR>
nmap <silent> <F10> :Gcommit %<CR>
nmap <silent> <F11> :Gpull %<CR>
nmap <silent> <F10> :Gpush %<CR>

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'gitbranch', 'filename' ],
      \             [ 'paste']]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
