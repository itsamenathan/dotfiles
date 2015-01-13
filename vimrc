             "for vimwiki
set nocompatible

             "for pathogen https://github.com/scrooloose/syntastic
execute pathogen#infect()

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

             " set status line
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)
set laststatus=2 

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
