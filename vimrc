             " Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

             " Install Plug
             " https://github.com/junegunn/vim-plug
if !isdirectory($HOME.'/.vim/autoload/plug.vim')
  call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/sjl/gundo.vim.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
call plug#end()

             " Airline Options
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set laststatus=2
let g:airline#extensions#branch#displayed_head_limit = 10

             " NERDTree options
function! ToggleNERDTree()
  if exists("b:NERDTree")
    NERDTreeToggle
  else
    NERDTreeFocus
  endif
endfunction
map <C-n> :call ToggleNERDTree()<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

             " Persistent undo
if !isdirectory($HOME.'/.vim/undodir')
  call mkdir($HOME."/.vim/undodir", "p")
endif
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

             " syntax highlighting
syntax on
set background=dark

             " figure out file type
filetype plugin indent on

             " indent stuff
set smarttab
set autoindent
             " expand tabs to spaces
set et
             " shift width
set sw=2

             " Ignores case when searching
set ic

             " Set where splits open
set splitright
set splitbelow

             " highlit search
set hlsearch

  " Format JSON
com! FormatJSON %!python -m json.tool

" save with sudo access
cmap w!! w !sudo tee % >/dev/null

            " map a few thing
map <c-h> <home>
map <c-j> <pagedown>
map <c-k> <pageup>
map <c-l> <end>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>


  " sets filetypes for file extensions
au BufNewFile,BufRead *.txt call Filetype_txt()
au BufNewFile,BufRead *.wiki call Filetype_txt()
au BufNewFile,BufRead *.tex call Filetype_txt()
au BufNewFile,BufRead *.md call Filetype_txt()
au BufNewFile,BufRead COMMIT_EDITMSG call Filetype_txt()
au BufNewFile,BufRead *mutt-* call Filetype_txt()
au BufNewFile,BufRead */.gitary/* call Filetype_txt()
au BufNewFile,BufRead *.pde call Filetype_pde()

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" text file spacific stuff
function! Filetype_txt()
  set spell spelllang=en_us
  map <c-b> i<C-X>s
  imap <c-b> <C-X>s
endfunction

function! Filetype_pde()
  setf arduino
  map <F7> :!make <RETURN>
  map <F8> :!make upload <RETURN>
endfunction

imap jk <Esc>

set backspace=indent,eol,start

set cursorline

set colorcolumn=80
highlight ColorColumn ctermbg=235

