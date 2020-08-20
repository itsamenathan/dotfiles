" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

"+----------+
"| SETTINGS |
"+----------+

set background=dark            " Use colors that look good on a dark background
set backspace=indent,eol,start " Allow backspacing over anything in insert mode
set colorcolumn=80             " Color column
set expandtab                  " Use spaces when tab is inserted
set hlsearch                   " Highlight search pattern
set ignorecase                 " Case insensitive searching
set noshowmode                 " Hide mode infomation on the last line
set pastetoggle=<c-o>          " Toggle paste mode
set splitbelow                 " New window from split is below the current one
set splitright                 " New window is put right of the current one
set smartcase                  " CAse sensitive searching if using uppercase
filetype plugin indent on      " Enable file type detection
syntax on                      " Turn on syntax highlighting
highlight ColorColumn ctermbg=235

" Change cursor shape in different modes
let &t_EI = "\033[2 q" " NORMAL  █
let &t_SI = "\033[5 q" " INSERT  |
let &t_SR = "\033[3 q" " REPLACE _

" save with sudo access
cmap w!! w !sudo tee % >/dev/null

" Persistent undo
if !isdirectory($HOME.'/.vim/undodir')
  call mkdir($HOME."/.vim/undodir", "p")
endif
set undodir=$HOME/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Common Swap directory
if !isdirectory($HOME.'/.vim/swp')
  call mkdir($HOME."/.vim/swp", "p")
endif
set directory^=$HOME/.vim/swp//

"+---------+
"| PLUGINS |
"+---------+

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
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/hashivim/vim-terraform.git'
Plug 'https://github.com/will133/vim-dirdiff.git'
Plug 'https://github.com/mhinz/vim-grepper.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/ryanoasis/vim-devicons.git'
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git'
Plug 'https://github.com/vim-scripts/vim-auto-save.git'
call plug#end()

"+----------------+
"| PLUGINS CONFIG |
"+----------------+

" Airline Options
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set laststatus=2
let g:airline#extensions#branch#displayed_head_limit = 10

"" GitGutter Options
autocmd BufWritePost * GitGutter
highlight clear SignColumn
highlight GitGutterAdd          ctermfg=Green
highlight GitGutterChange       ctermfg=Yellow
highlight GitGutterDelete       ctermfg=Red
highlight GitGutterChangeDelete ctermfg=Blue

" NERDTree options
let NERDTreeShowHidden=1
function! ToggleNERDTree()
  if exists("b:NERDTree")
    NERDTreeToggle
  else
    NERDTreeFocus
  endif
endfunction
map <C-n> :call ToggleNERDTree()<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntastic Options
let g:syntastic_python_checkers = ['python3']

" vim-markdown Options
let g:vim_markdown_folding_disabled = 1

" vim-autosave Options
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

"+-------------+
"| KEY MAPPING |
"+-------------+

imap jk <Esc>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>

"+---------------+
"+ FILE MAPPINGS |
"+---------------+

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
