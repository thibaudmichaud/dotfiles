set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'derekwyatt/vim-protodef'
Plugin 'derekwyatt/vim-fswitch'

call vundle#end()
filetype plugin indent on

" status bar
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" colors
syntax enable
color default
au BufNewFile,BufRead *.i set filetype=swig
au BufNewFile,BufRead *.swg set filetype=swig 
au BufNewFile,BufRead *.tig set filetype=tiger

" abbreviations
autocmd FileType tex iabbr <buffer> ... \ldots
autocmd FileType tex iabbr <buffer> img \includegraphics[]{}<esc>i
autocmd FileType c,cpp iabbr <buffer> def #define
autocmd FileType c,cpp iabbr <buffer> inc #include

" command tab completion
set wildmenu
set wildmode=full

" tab behavior
set expandtab
set shiftwidth=2
set softtabstop=2

" folds
set foldmethod=syntax
set nofoldenable
hi Folded ctermbg=234

" search
set incsearch
set hlsearch
set smartcase
noremap <f4> :set hlsearch!<CR>

" file explorer
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_winsize=80
let g:netrw_liststyle=3

"gui
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" call git grep from vim and list results in the quickfix window
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  silent exe s
  cw
  redraw!
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

" auto header guard
function! s:header_guard()
  let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . guardname
  execute "normal! o# define " . guardname
  execute "normal! Go#endif /* !" . guardname . " */"
  execute "normal! O\<cr>\<cr>\<up>"
endfunction
autocmd BufNewFile *.{h,hpp,hh} call <SID>header_guard()

" switch between cpp source and header
function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cc")
    find %:t:r.hh
  else
    find %:t:r.cc
  endif
endfunction
autocmd FileType cpp nmap ,h :call SwitchSourceHeader()<CR>

" Epita coding-style compliant comments
autocmd FileType c,cpp set comments=s0:/*,mb:**,ex:*/

" :make, improved
nnoremap <leader>m :silent make\|redr!\|bo cw\|cc<CR>

" misc settings
let mapleader = ","
autocmd FileType mail set textwidth=72
set textwidth=80
set formatoptions+=t
set wrap
set mouse=a
set wildignore+=*.o,*.swp
set hidden
set tags=./tags;
let g:acp_enableAtStartup=0
set noswapfile
set splitbelow
set splitright
set showmatch
set cinoptions+=:O

" misc mapping
nnoremap <leader>p :set paste!<cr>
nnoremap <leader>s :w<CR>
cmap w!! w !sudo tee > /dev/null %
nnoremap du :diffupdate<CR>
nnoremap dp :diffput<CR>
nnoremap dg :diffget<CR>
nnoremap <silent> zj o<esc>
nnoremap <silent> zk O<esc>

" plugin settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
