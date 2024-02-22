-- Left line
vim.opt.nu = true                       -- line number
vim.opt.relativenumber = true           -- relative line number
vim.opt.fillchars:append({ eob = " " }) -- show empty lines at the end of a buffer as ` ` {default `~`}

-- Text
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.startofline = true -- Jump to first non-blank character

vim.opt.updatetime = 50    -- CursorHold autocommand will run after this ms if no new key is pressed, used by some plugins

-- File
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- to have longer undo history
vim.opt.undofile = true

vim.opt.autowriteall = true

-- Search
-- vim.opt.hlsearch = false -- highlight search matches
vim.opt.incsearch = true  -- highlight search match as I type

vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true

-- Appearence
vim.opt.termguicolors = true

vim.opt.showtabline = 0 -- never show tab pages
vim.opt.laststatus = 3  -- only the last window will always have a status line

vim.opt.scrolloff = 8   -- never less than 8 lines above or below cursor
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5
vim.opt.isfname:append("@-@")
