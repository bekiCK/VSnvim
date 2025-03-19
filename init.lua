-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins using lazy.nvim
require("lazy").setup({
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neoclide/coc.nvim", branch = "release" },
  { "morhetz/gruvbox" },
  { "m4xshen/autoclose.nvim" },
  { "windwp/nvim-autopairs" },
  { "romgrk/barbar.nvim",dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  }},
  { "akinsho/toggleterm.nvim" },
  { 'rmagatti/auto-session',
        lazy = false,},
  {
        'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' }
          }
})

-- Autoclose setup
require("autoclose").setup({
  disable_when_touch = true,
  keys = {
    ["<"] = { escape = false, close = true, pair = "<>" }
  }
})

require("lualine").setup()

require("auto-session").setup()

require("nvim-tree").setup()

-- ToggleTerm setup
require("toggleterm").setup({
  size = 20,
  open_mapping = [[<C-t>]],
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
})

-- Terminal keybindings
function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Treesitter setup
require("nvim-treesitter.configs").setup({
  ensure_installed = { "javascript", "typescript", "tsx" },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
})

-- General settings
vim.opt.encoding = "utf-8"
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.showtabline = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 500
vim.opt.wrap = false
vim.opt.sidescroll = 2
vim.opt.sidescrolloff = 15
vim.cmd("colorscheme gruvbox")

-- Auto start insert mode in terminal
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "startinsert" })
vim.api.nvim_create_autocmd("BufLeave", { pattern = "term://*", command = "startinsert" })

-- Key Mappings
vim.keymap.set("n", "<Esc>", "i", { noremap = true })
vim.keymap.set("n", "<C-n>", ":NvimTreeTogrgle<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-n>", "<Esc>:NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-f>", "<Esc>:CocCommand prettier.forceFormatDocument<CR>i", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })
vim.keymap.set("i", "<C-z>", "<Esc>u<CR>i", { noremap = true, silent = true })
vim.keymap.set("i", "<C-y>", "<Esc><C-r>i", { noremap = true, silent = true })
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "<C-x>", '"+d', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<Esc>"+p<CR>i', { noremap = true, silent = true })
vim.keymap.set("i", "<C-q>", "<Esc>:q<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-Space>", "coc#refresh()", { noremap = true, expr = true, silent = true })
vim.keymap.set("i", "<Tab>", "pumvisible() ? coc#_select_confirm() : '<CR>'", { noremap = true, expr = true, silent = true })

-- System Key Mappings
vim.keymap.set("i", "<A-r>", "<Esc>:source $MYVIMRC<CR>i", { noremap = true, silent = true })
vim.keymap.set("i", "<A-s>", "<Esc>:edit $MYVIMRC<CR>", { noremap = true, silent = true })
vim.keymap.set("i","<A-l>","<Esc>:Coc",{noremap = true})
-- Clipboard integration for Termux
if vim.fn.executable("termux-clipboard-get") == 1 and vim.fn.executable("termux-clipboard-set") == 1 then
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "termux",
    copy = {
      ["+"] = "termux-clipboard-set",
      ["*"] = "termux-clipboard-set",
    },
    paste = {
      ["+"] = "termux-clipboard-get",
      ["*"] = "termux-clipboard-get",
    },
    cache_enabled = 0,
  }
end
