local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", ":Telescope")

-- Searching files
nnoremap(";f", function(opts)
      opts = opts or {}
      opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or ''
        require'telescope.builtin'.find_files(opts)
end)
nnoremap(";gf", function()
    require('telescope.builtin').find_files()
end)

-- Searching words
nnoremap(";r", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap(";w", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)

-- Utils
nnoremap('\\\\', function()
  require('telescope.builtin').buffers()
end)
nnoremap(';;', function()
  require('telescope.builtin').resume({initial_mode = 'normal'})
end)
nnoremap(';e', function()
  require('telescope.builtin').diagnostics()
end)
nnoremap(";t", function()
    require('telescope.builtin').help_tags()
end)

-- Git
nnoremap("<leader>gc", function()
    require('user.telescope').git_branches()
end)
nnoremap("<leader>gw", function()
    require('telescope').extensions.git_worktree.git_worktrees()
end)
nnoremap("<leader>gm", function()
    require('telescope').extensions.git_worktree.create_git_worktree()
end)



