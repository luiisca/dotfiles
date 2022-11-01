local neogit = require('neogit')
local nnoremap = require('user.keymap').nnoremap

neogit.setup {}

-- Silent keymap option
local opts = { silent = true }
--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

nnoremap("<leader>gn", "<cmd>:Neogit<cr>");

nnoremap("<leader>gnf", "<cmd>!git fetch --all<CR>");
