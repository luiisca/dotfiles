local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end
local nnoremap = require("user.keymap").nnoremap

nnoremap('sf', '<cmd>lua require"nvim-tree".open_replacing_current_buffer()<cr>')
nnoremap(';sf', '<cmd>silent :NvimTreeToggle<cr>')

local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup {
  hijack_netrw = true,
    hijack_cursor = true,
    hijack_directories = {
        enable = true,
    },
    open_on_setup = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
        highlight_opened_files = "all", -- 'none', 'icon', 'name', 'all'
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
        centralize_selection = true,
    width = 40,
        number = true,
        relativenumber = true,

    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "H", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "h", action = "dir_up" },
        { key = "s", action = "" },
        { key = "<CR>", action = "edit_in_place" }
      },
    },

  },
    filters = {
        custom = { "^.git$" }
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
        remove_file = {
            close_window = false,
        }
    },
}
