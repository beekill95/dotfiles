call plug#begin()

" Plugin for intellisense, code complete.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy find finder.
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Comment code.
Plug 'https://github.com/tpope/vim-commentary.git'

" Surrounding code.
Plug 'https://github.com/tpope/vim-surround.git'

" Show git changes.
Plug 'https://github.com/airblade/vim-gitgutter.git'

" Dart language.
Plug 'dart-lang/dart-vim-plugin'

" Checking grammar.
Plug 'https://github.com/rhysd/vim-grammarous.git'

" Themes.
" Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'

" Swift syntax highlight + filetypes
Plug 'apple/swift', { 'branch': 'main', 'rtp': 'utils/vim', 'as': 'swift-syntax'}

" Julia language
Plug 'JuliaEditorSupport/julia-vim'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" Set leader
let mapleader="\\"

" Plugin configurations.
let g:nvim_config_root = stdpath('config')
let g:nvim_config_files = [
            \ 'coc.vim',
            \ 'coc-extensions.vim',
            \ 'fzf.vim'
            \ ]
for f in g:nvim_config_files
    execute 'source ' . g:nvim_config_root . '/' . f
endfor

" Enable line number
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set relativenumber
augroup END

" Use spaces instead of tab.
set tabstop=4
set shiftwidth=4
set expandtab

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Theme config.
if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme gruvbox

" Automatically reload file, heck one time after 4s of inactivity in normal mode.
set autoread
augroup autochecktime
    autocmd!
    au CursorHold * checktime
augroup END

" Enable auto comment in when hitting o in normal mode.
set formatoptions+=cro

" Enable spell checking.
set spell spelllang=en_us

" Search options.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Usually, I don't like line wrap
set nowrap

" Splits should go to the right place.
set splitright
set splitbelow

" Key maps.
" Switching buffers faster.
nnoremap <Leader>b :ls<Cr>:b<Space>
nnoremap <Leader>vb :ls<Cr>:vsp<Space>\|<Space>b<Space>
nnoremap <Leader>sb :ls<Cr>:sp<Space>\|<Space>b<Space>

" Easier way to switch to normal mode in insert mode.
inoremap jk <esc>

" Open coc-explorer.
nmap <C-e> :CocCommand explorer<cr>

