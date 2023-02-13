call plug#begin()
        Plug 'preservim/nerdtree'
        Plug 'kqito/vim-easy-replace'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'vim-airline/vim-airline'
        Plug 'morhetz/gruvbox'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'preservim/tagbar'
        Plug 'jiangmiao/auto-pairs'
        Plug 'ryanoasis/vim-devicons'
        Plug 'rhysd/vim-clang-format'
call plug#end()

autocmd VimEnter * :startinsert
autocmd BufEnter * :startinsert
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

colorscheme gruvbox

set number
set mouse=a
set encoding=UTF-8



inoremap <a-q> <esc>:q! <cr>
inoremap <C-q> <esc>:bdelete! <cr>
inoremap <C-s> <esc>:w <cr>i
inoremap <a-s> <esc>:wa<cr>i
inoremap <C-u> <esc>:u <cr>i
inoremap <C-r> <esc>:redo <cr>i
inoremap <C-c> <esc>y<cr>i
inoremap <C-v> <esc>P i
inoremap <c-b> <esc>:make build<cr>
inoremap <a-r> <esc>:make run<cr>
inoremap <C-o> <esc>:NERDTreeToggle<cr>
nnoremap <C-o> <esc>:NERDTreeToggle<cr>
inoremap <c-t> :TagbarToggle<CR>
inoremap <c-p> <esc>:ClangFormat<cr>i

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:easy_replace_launch_key ="<c-f>"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='jellybeans'
