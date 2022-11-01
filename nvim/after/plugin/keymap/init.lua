-- local tmux = require("twitchy.window.tmux")
-- local tail = require("twitchy.window.tail")

local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Silent keymap option
local opts = { silent = true }
--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

nnoremap("<leader>pv", ":Ex<CR>")
nnoremap("<leader>u", ":UndotreeShow<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("n", "nzzzv")
-- nnoremap("N", "Nzzzv")
-- nnoremap("J", "mzJ`z")
nnoremap("J", "<C-d>zz")
nnoremap("K", "<C-u>zz")

-- greatest remap ever
xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

nnoremap("Q", "<nop>")
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")

-- nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- nnoremap("<leader>tc", function()
    -- tail.reset()
    -- tmux.reset()
-- end);
--
-- nnoremap("<leader>ta", function()
    -- tail.reset()
    -- tmux.reset()
-- end);


nnoremap('x', '"_x')

-- Space + s to save
nnoremap('<leader>s', ':write<Enter>', opts)

-- Space + r redraw vim
nnoremap('<leader>r', ':redraw<Enter>', opts)

-- Move normally between wrapped lines
nnoremap('j', 'gj')
nnoremap('k', 'gk')

-- Move to first and last character on crr line
nnoremap('H', '^')
nnoremap('L', '$')

-- Increment/decrement
nnoremap('+', '<C-a>')
nnoremap('-', '<C-x>')

-- Select all
nnoremap('<C-a>', 'gg<S-v>G')

-- Split window
nnoremap('sv', ':split<Return><C-w>w')
nnoremap('ss', ':vsplit<Return><C-w>w')

-- Move window
nnoremap('<leader>', '<C-w>w')
nnoremap('sh', '<C-w>h')
nnoremap('sk', '<C-w>k')
nnoremap('sj', '<C-w>j')
nnoremap('sl', '<C-w>l')

-- Resize with arrows
nnoremap("<C-Up>", ":resize -2<CR>", opts)
nnoremap("<C-Down>", ":resize +2<CR>", opts)
nnoremap("<C-Left>", ":vertical resize -2<CR>", opts)
nnoremap("<C-Right>", ":vertical resize +2<CR>", opts)

-- Shift + q - Quit
nnoremap('<leader>q', ':x<Enter>')

-- Auto indent pasted text
nnoremap('p', 'p=`]<C-o>')
nnoremap('p', 'P=`]<C-o>')

-- Indent on view mode
vnoremap('<Tab>', '>gv')
vnoremap('<S-Tab>', '<gv')

-- Move to the end after yank or paste
nnoremap('p', 'p`]')
vnoremap('y', 'y`]')
vnoremap('p', 'p`]')

-- Space + o to focus buffer between others
nnoremap('<leader>o', ':only<CR>')

-- Clear highlights
nnoremap("<leader>g", "<cmd>nohlsearch<CR>", opts)

-- Fixes pasting after visual selection
vnoremap("p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
inoremap("jk", "<ESC>", opts)

-- Switch to last file
nnoremap('<leader><leader>', '<c-^>')
