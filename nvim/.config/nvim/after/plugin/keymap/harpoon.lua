local nnoremap = require("user.keymap").nnoremap

local silent = { silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "

-- Terminal commands
-- ueoa is first through fourth finger left hand home row.
-- This just means I can crush, with opposite hand, the 4 terminal positions
--
-- These functions are stored in harpoon.  A plugn that I am developing
nnoremap(";a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("vv", function() require("harpoon.ui").toggle_quick_menu() end, silent)

nnoremap("<leader>h", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<leader>j", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<leader>k", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<leader>l", function() require("harpoon.ui").nav_file(4) end, silent)

