vim.g.mapleader = " "

local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")

local opts = { silent = true }

-- NVIM-TREE
-- nnoremap('sf', '<cmd>lua require("nvim-tree.api").tree.open({ winid = vim.api.nvim_get_current_win() })<cr>',
--     { desc = "Nvim-tree Explorer" })
-- nnoremap(';sf', '<cmd>silent :NvimTreeToggle<cr>', { desc = "Toggle Nvim-tree Explorer to the side" })

-- COMMANDS
nnoremap("sf", vim.cmd.Oil, { desc = "Explorer" })
nnoremap("<leader>s", vim.cmd.w, { desc = "Save" })
nnoremap("<leader>q", ":x<CR>")
inoremap("jk", "<ESC>", { silent = true, desc = "Escape" })
nnoremap("<leader>g", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear highlights" })
nnoremap("<leader>o", ":only<CR>", { desc = "Focus buffer" })
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })
nnoremap("<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Move to latest file" })
nnoremap("<leader>b", ":edit ~/", { desc = "Open home dir" })

-- MOVE LINES
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
nnoremap("<leader>J", "mzJ`z") -- takes the line below and appends it to crr line

-- SEARCH
nnoremap("n", "nzz")
nnoremap("N", "Nzz")

-- REPLACE
nnoremap("<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Global word replace" })

-- MOVEMENT
nnoremap("J", "<C-d>zz")
nnoremap("K", "<C-u>zz")
-- Move normally between wrapped lines
nnoremap("j", "gj")
nnoremap("k", "gk")
-- Move to first and last character on crr line
nnoremap("H", "^")
nnoremap("L", "$")

-- WINDOW
nnoremap("sv", ":split<Return><C-w>w", { desc = "Split current window horizontally" })
nnoremap("ss", ":vsplit<Return><C-w>w", { desc = "Split current window vertically" })
-- Move between splits
nnoremap("<leader>w", "<C-w>w", { desc = "Toggle splits" })
nnoremap("sh", "<C-w>h")
nnoremap("sk", "<C-w>k")
nnoremap("sj", "<C-w>j")
nnoremap("sl", "<C-w>l")
-- Resize splits
nnoremap("<S-Up>", ":resize -2<CR>", opts)
nnoremap("<S-Down>", ":resize +2<CR>", opts)
nnoremap("<S-Left>", ":vertical resize -2<CR>", opts)
nnoremap("<S-Right>", ":vertical resize +2<CR>", opts)

-- INDENT
-- Auto indent pasted text
nnoremap("p", "p=`]<C-o>")
nnoremap("p", "P=`]<C-o>")
-- Indent on view mode
vnoremap("<Tab>", ">gv")
vnoremap("<S-Tab>", "<gv")

-- YANK
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
nnoremap("<leader>Y", [["+Y]], { desc = "Yank current line to clipboard" })
nnoremap("Y", "yg$", { desc = "Yank from cursor to end of line" })

-- VOID REGISTER
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
nnoremap("x", '"_x', { desc = "Delete single char to void registry" })
xnoremap("<leader>p", [["_dP]], { desc = "Replace and preserve" })

-- ERRORS
nnoremap("<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
nnoremap("<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
nnoremap("<S-C>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
nnoremap("<S-C>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

-- MISC
-- Increment/decrement
nnoremap("+", "<C-a>")
nnoremap("-", "<C-x>")

-- Select all
nnoremap("<C-a>", "gg<S-v>G")

-- Move to the end after yank or paste
nnoremap("p", "p`]")
vnoremap("y", "y`]")
vnoremap("p", "p`]")

nnoremap("Q", "<nop>", { desc = "Macro recording is disabled" })

inoremap("<A-,>", "<BS>", { desc = "Delete char before cursor" })
