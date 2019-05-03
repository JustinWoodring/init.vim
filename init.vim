if !has('gui_running')
set t_Co=256
endif
set noshowmode
set encoding=utf-8
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
Plug 'mikelue/vim-maven-plugin'
Plug 'junegunn/seoul256.vim'

call plug#end() 

"Functions

function SetToolset(toolset)
	let g:toolset = a:toolset
    if (a:toolset ==? 'c')
	    nmap <silent> <F6> excecute ':terminal cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . ' && make && make run'<CR>
	    nmap <silent> <F7> :edit g:NERDTree.ForCurrentTab().getRoot().path.str() . "/Makefile"<CR>
	elseif (a:toolset ==? 'html')
	    nmap <silent> <F6> :let g:html_toolset_webaddress = input('Enter full webaddr: ') <bar> :echo "\nWeb Address set to ".g:html_toolset_webaddress<CR>
	    nmap <silent> <F7> :execute '!xdg-open '. g:html_toolset_webaddress . '/' . expand('%:t')<CR>
	elseif (a:toolset ==? 'java')
		nmap <silent> <F5><y> :execute '!cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . ' && mvn archetype:generate -DgroupId=com.booglejr.rootyjr -DartifactId=java-project -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false'<CR>
		nmap <silent> <F6> :terminal java %<CR>    
		nmap <silent> <F7> :edit g:NERDTree.ForCurrentTab().getRoot().path.str() . "/pom.xml"<CR>
    elseif (a:toolset ==? 'python')
	    nmap <silent> <F6> :terminal python3 %<CR>
	elseif (a:toolset ==? 'rust')
	    nmap <silent> <F5><y> :execute '!cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . ' && cargo init'<CR>
        nmap <silent> <F6> :execute '!cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . ' && cargo run'<CR>
        nmap <silent> <F7> :execute 'edit ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . '/Cargo.toml'<CR>
    elseif (a:toolset ==? 'vim')
        nmap <silent> <F6> :source $MYVIMRC<CR>
        nmap <silent> <F7> :edit $MYVIMRC<CR>
    endif
endfunction

function ToggleToolset()
    let g:toollist = ['C', 'HTML', 'JAVA', 'PYTHON', 'RUST', 'VIM']
    let n = -1
    for i in g:toollist
       let n = n + 1
	   if(i ==? g:toolset)
          let c = n
       endif
       let e = n
	endfor
    if (c < e)
       execute ':call SetToolset(g:toollist['.c.'+1])'
    else
       execute ':call SetToolset(g:toollist['.0.'])'
    endif
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineToolset()
  let a:toolset = g:toolset
  return a:toolset
endfunction

"Variables
let g:syntastic_vim_checkers = ['vint']
let g:ycm_rust_src_path = '/home/rootyjr/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rustc'
let python_highlight_all=1
syntax on
set nu
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = 'latex'
colorscheme oceandeep

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'gitbranch', 'filename'],
      \             [ 'paste']],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'toolset', 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename',
      \   'toolset':  'LightlineToolset',
      \ },
      \ }
      
"Commands
command -nargs=0 ToggleToolset execute 'call ToggleToolset(<args>)'
command -nargs=1 SetToolset execute 'call SetToolset(<args>)'


"Keys
nmap <silent> <F1><C-y> :execute '!cd ' . g:NERDTree.ForCurrentTab().getRoot().path.str() . ' && git reset --hard origin/master'<CR>
nmap <silent> <F3> :NERDTreeToggle<CR>
nmap <silent> <F4> :execute '!xdg-open '. expand("%:p:h")<CR>
nmap <silent> <F8> :ToggleToolset<CR>
nmap <silent> <F9> :Gstatus<CR>
nmap <silent> <F10> :Gcommit<CR>
nmap <silent> <F11> :Gpull %<CR>
nmap <silent> <F12> :Gpush %<CR>
nmap <silent> <C-i><F12> :execute '!git init ' . g:NERDTree.ForCurrentTab().getRoot().path.str()<CR>

call SetToolset('RUST')

