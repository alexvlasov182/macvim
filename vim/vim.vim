set nocompatible	" be iMproved, required
filetype off		" required

call plug#begin('~/.vim/bundle/plugged')

Plug 'tpope/vim-fugitive'
Plug 'janko/vim-test'
Plug 'tpope/vim-rails'
Plug 'airblade/vim-gitgutter'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-endwise'
Plug 'rhysd/vim-crystal'
Plug 'ddollar/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'} " https://github.com/fatih/vim-go
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}  " https://github.com/neoclide/coc.nvim

call plug#end()

filetype plugin indent on 	" required
set guifont=Monaco:h19

" strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" line numbers
set number

" highlight current line
set cursorline

" Two space tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Set some file types
" Set the Ruby filetype for a number of common Ruby files without .rb
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby

" Gruvbox theme
syntax enable
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'soft'

" Scroll in window from left and right side
set guioptions=

" Allow using ctrl-j k l h to navigate between window splits
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

inoremap { {}<left>
inoremap [ []<left>
inoremap ( ()<left>
inoremap ' ''<left>
inoremap " ""<left>
inoremap {;<CR> {<CR>};<ESC>O
inoremap {<CR> {<CR>}<ESC>O
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
" Nerdtree open by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let NERDTreeQuitOnOpen = 0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
" Don't wrap long lines
set nowrap           " do not automatically wrap on load
set formatoptions-=t " do not automatically wrap text when typing
" Toggle nerdcommenter with command+/
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


map <silent> <C-n> :NERDTreeFocus<CR>
set listchars+=space:.
set listchars+=trail:.
set listchars+=tab:->

" Golang
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"
" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

" For syntax highlighting, use these options
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:go_bin_path = $HOME."/go/bin"

" au filetype go inoremap <buffer> . .<C-x><C-o>

" Ruby
let g:coc_global_extensions = ['coc-solargraph']

" HTML, ERB
autocmd FileType html
autocmd BufNewFile,BufRead *.html.erb set filetype=html
set omnifunc=htmlcomplete#CompleteTags

" Icons

