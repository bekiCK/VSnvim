call plug#begin('~/.local/share/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'm4xshen/autoclose.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'romgrk/barbar.nvim'
Plug 'akinsho/toggleterm.nvim'

call plug#end()

autocmd BufEnter * startinsert
autocmd BufLeave term://* startinsert


syntax on
colorscheme gruvbox

set encoding=UTF-8
set background=dark
set number
set showtabline=2
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set ignorecase
set smartcase
set timeoutlen=500
set nowrap
set sidescroll=2
set sidescrolloff=15


" Key Bindings
nnoremap <esc> i

noremap <C-n> <esc>:NERDTreeToggle<CR>
inoremap <C-n> <esc>:NERDTreeToggle<CR>
inoremap <C-f> <esc>:CocCommand prettier.forceFormatDocument<CR>i
inoremap <c-s> <esc>:w<CR>i
inoremap <C-z> <esc>u<CR>i
inoremap <C-y> <esc><C-r>i
vnoremap <C-c> "+y<CR>i
vnoremap <C-x> "+d<CR>i
inoremap <C-v> <esc>"+p<CR>i
inoremap <c-q> <esc>:q<CR>
inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<CR>"
inoremap <silent><expr> <C-Space> coc#refresh()


"" system key Bindings
inoremap <A-r> <esc>:source $MYVIMRC<CR>i
inoremap <A-s> <esc>:edit $MYVIMRC<CR>


" Coc.nvim for auto-completion
let g:coc_global_extensions = ['coc-pyright', 'coc-tsserver', 'coc-json']



" Set up clipboard integration for Termux
if executable('termux-clipboard-get') && executable('termux-clipboard-set')
set clipboard=unnamedplus
     let g:clipboard = {
           \'name': 'termux',
             \   'copy': {
                 \      '+': 'termux-clipboard-set',
                 \      '*': 'termux-clipboard-set',
                 \    },
              \   'paste': {

       \      '+': 'termux-clipboard-get',
                  \      '*': 'termux-clipboard-get',
                  \   },

\   'cache_enabled': 0,
                                                 \ }
endif



lua << EOF
require("autoclose").setup({
  disable_when_touch = true,
  keys = {
        ["<"] = { escape = false, close = true,pair="<>" }, -- Auto-close `<` with `>`
          }
  })
EOF

lua << EOF
require("toggleterm").setup{
  size = 20, -- Height of the terminal window
  open_mapping = [[<C-t>]], -- Keybinding to toggle terminal
  direction = "horizontal", -- "vertical", "horizontal", "tab", or "float"
  close_on_exit = true, -- Close terminal when process exits
  shell = vim.o.shell, -- Default shell
}

-- Terminal mode keybindings
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
EOF


lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx"},
  highlight = {
    enable = true,-- Enable Treesitter-based highlighting
    additional_vim_regex_highlighting = false,
            },
}
EOF
