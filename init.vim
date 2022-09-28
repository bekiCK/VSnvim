   call plug#begin()
       Plug 'preservim/nerdtree'
       Plug 'vim-airline/vim-airline'
       Plug 'vim-airline/vim-airline-themes'
       Plug 'sainnhe/sonokai'
       Plug 'neoclide/coc.nvim', {'branch': 'release'}
       Plug 'samodostal/image.nvim'
       Plug 'nvim-lua/plenary.nvim'
    call plug#end()
  
    set number
   set mouse=a
   set termguicolors
 
   colorscheme sonokai
 
   nnoremap <C-n> :NERDTreeToggle <CR>
   nnoremap <C-q> :q! <CR>
   nnoremap <C-s> :w <CR>
   inoremap <C-s> <ESC>:w <CR>
 
   let g:airline#extensions#tabline#formatter = 'unique_tail'
   let g:sonokai_style = 'andromeda'
 
   inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()    \<CR>"
