 " Note: Skip initialization for vim-tiny or vim-small.
 if !1 | finish | endif

if !isdirectory($HOME.'/.vim/bundle/neobundle')
  call system('git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle')
endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundle 'https://github.com/bling/vim-airline.git', { 'directory': 'airline' }
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set laststatus=2
let g:airline#extensions#branch#displayed_head_limit = 10
NeoBundle 'https://github.com/ntpeters/vim-better-whitespace.git', { 'directory': 'better-whitespace' }
NeoBundle 'https://github.com/tpope/vim-fugitive.git', { 'directory': 'fugitive' }
NeoBundle 'https://github.com/airblade/vim-gitgutter.git', { 'directory': 'gitgutter' }
NeoBundle 'https://github.com/sjl/gundo.vim.git', { 'directory': 'gundo' }
NeoBundle 'https://github.com/Shougo/neobundle.vim.git', { 'directory': 'neobundle' }
NeoBundle 'https://github.com/scrooloose/nerdtree.git', { 'directory': 'nerdtree' }
NeoBundle 'https://github.com/Xuyuanp/nerdtree-git-plugin.git', { 'directory': 'nerdtree-git' }
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>
NeoBundle 'https://github.com/saltstack/salt-vim.git', { 'directory': 'salt-vim' }
NeoBundle 'https://github.com/garbas/vim-snipmate.git', { 'directory': 'snipmate' }
NeoBundle 'https://github.com/honza/vim-snippets.git', { 'directory': 'snippets' }
NeoBundle 'https://github.com/ervandew/supertab.git', { 'directory': 'supertab' }
NeoBundle 'https://github.com/scrooloose/syntastic.git', { 'directory': 'syntastic' }
NeoBundle 'https://github.com/tomtom/tlib_vim.git', { 'directory': 'tlib' }
NeoBundle 'https://github.com/MarcWeber/vim-addon-mw-utils.git', { 'directory': 'vim-addon-mw-utils' }
NeoBundle 'https://github.com/vimwiki/vimwiki.git', { 'directory': 'vimwiki' }
NeoBundle 'https://github.com/kien/ctrlp.vim.git', { 'directory': 'ctrlp' }
NeoBundle 'https://github.com/qpkorr/vim-bufkill', { 'directory': 'bufkill' }
NeoBundle 'https://github.com/rking/ag.vim.git', { 'directory': 'ag' }

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck



             "for vimwiki
set nocompatible

             "for pathogen https://github.com/scrooloose/syntastic
"execute pathogen#infect()

             " syntax highlighting
syntax on
set background=dark

             " figure out file type
"filetype plugin on
filetype on
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

             " set status line
"set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)
"set laststatus=2

             " highlit search
set hlsearch

             " Persistent undo
if !isdirectory($HOME.'/.vim/undodir')
  call mkdir($HOME."/.vim/undodir", "p")
endif
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

  " Format JSON
com! FormatJSON %!python -m json.tool

" save with sudo access
cmap w!! w !sudo tee % >/dev/null

            " map a few thing
map <c-h> <home>
map <c-j> <pagedown>
map <c-k> <pageup>
map <c-l> <end>
map <F6> :!./%<RETURN>
nnoremap <F5> :GundoToggle<CR>
nnoremap    <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>


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
  nmap <F8> :w<CR>:!aspell -e -c %<CR>:e<CR> 
endfunction

function! Filetype_pde()
  setf arduino
  map <F7> :!make <RETURN>
  map <F8> :!make upload <RETURN>
endfunction

let mapleader=" "
