set nocompatible
filetype off
let mapleader = ","

call plug#begin()
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe'
call plug#end()

filetype plugin indent on

" status bar
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" colors
syntax enable
color default
hi Search ctermfg=black ctermbg=yellow

" command tab completion
set wildmenu
set wildmode=list:longest

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

" file explorer
let g:netrw_liststyle=3

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

" :make, improved
nnoremap <leader>m :silent make\|redr!\|bo cw\|cc<CR>

" misc settings
set mouse=a
set wildignore+=*.o,*.swp
set hidden
set tags=./tags;
set noswapfile
set splitbelow
set splitright
set showmatch
set cinoptions+=:O
set cm=blowfish2
set backspace=2

" Highlight over 80 chars for C/C++
autocmd FileType c,cpp highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType c,cpp match OverLength /\%81v.\+/

" Quickfix list navigation
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" plugin settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_match_window = 'results:40' " overcome limit imposed by max height
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
