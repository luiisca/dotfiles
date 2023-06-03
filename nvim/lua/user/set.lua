vim.cmd("autocmd!")

vim.opt.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.wo.number = true -- Show line number

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.backup = false
vim.opt.showcmd = true -- Don't show extra info at the end of command line
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5
vim.opt.shell = 'zsh'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.splitbelow = true -- Force all horizontal split to go below current window
vim.opt.splitright = true
vim.opt.inccommand = 'nosplit' -- Live replace with additional buffer
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.wrap = false -- No Wrap lines
vim.opt.linebreak = true
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
-- vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.ruler = true -- Show cursor position
vim.opt.updatetime = 50 -- Bad experience when it's default 4000
vim.opt.lazyredraw = true
vim.opt.relativenumber = true
vim.opt.shortmess:append({ A = true }) -- Ignore annoying swapfile messages
vim.opt.shortmess:append({ I = true }) -- No splash screen
vim.opt.shortmess:append({ O = true }) -- File-read message overwrites previous
vim.opt.shortmess:append({ T = true }) -- Truncate non-file message in middle
vim.opt.shortmess:append({ W = true }) -- Don't echo "[w]"/"[written]" when writing
vim.opt.shortmess:append({ a = true }) -- Use abreviations in messages eg. `[RO]` instead of [readonly]`
vim.opt.shortmess:append({ c = true }) -- Don't give |ins-completion-menu| messages
vim.opt.shortmess:append({ o = true }) -- Overwrite file-written messages
vim.opt.shortmess:append({ t = true }) -- truncate file messages at start

vim.opt.signcolumn = 'yes' -- Always show signcolumns
vim.opt.autoread = true -- Update vim after file update from outside

-- No swap files
vim.api.nvim_command("set noswapfile")
vim.api.nvim_command("set nobackup")
vim.api.nvim_command("set nowritebackup")
vim.api.nvim_command("set nowb")

-- Persistent undo
-- keep undo history across sessions, by storing in file.
vim.api.nvim_exec(
  [[
    if has('persistent_undo')
      silent !mkdir ~/.vim/backups > /dev/null 2>&1
      set undodir=~/.vim/backups
      set undofile
    endif
  ]], false)

vim.opt.autowrite = true
vim.opt.ttimeoutlen = 0 -- Reduce Command timeout for faster escape and O
vim.api.nvim_command("set nostartofline") -- Jump to first non-blank character
vim.opt.showmatch = true -- Highlight matching bracket
vim.api.nvim_command("set noshowmode")
vim.opt.showtabline = 0 -- always show tabs
vim.opt.conceallevel = 0 -- Neosnippets conceal marker
vim.opt.mouse = 'a' -- Disable mouse scrolling
vim.opt.cursorline = true -- highlight the current line
vim.opt.laststatus = 3 -- only the last windows will always have a status line
vim.opt.numberwidth = 2 -- minimal number of columns to use for the line number {default 4}
vim.opt.fillchars.eob = " " -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append "c" -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"


-- Cursor
vim.opt.gcr = 'a:blinkon0' -- Disable cursor blinking
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50' -- Set gui cursor

vim.opt.hidden = true -- This makes vim act like all other editors, buffers can exist in the background without being in a window.

-- Allows to use gui colors in terminal
vim.api.nvim_command("set t_Co=256")
vim.opt.termguicolors = true

-- Colorscheme
vim.opt.background = 'dark'
vim.g.everforest_background = 'hard'
vim.g.everforest_better_performance = 1
vim.cmd [[ colorscheme everforest ]]

vim.opt.gdefault = true
vim.opt.ttyfast = true
vim.opt.diffopt = { 'vertical' }
vim.api.nvim_command("syntax on")

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
