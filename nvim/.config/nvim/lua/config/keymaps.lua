vim.g.mapleader = " "
vim.keymap.set("n", "sf", vim.cmd.Ex)
vim.keymap.set("n", "<leader>s", vim.cmd.w)

vim.keymap.set("n", "gn", vim.lsp.buf.hover)
