-- Utilities for creating configurations
local util = require "formatter.util"
local defaults = require "formatter.defaults"
local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    css = {
        util.copyf(defaults.prettierd)
    },
    javascript = {
        util.copyf(defaults.prettierd)
    },
    javascriptreact = {
        util.copyf(defaults.prettierd)
    },
    typescript = {
        util.copyf(defaults.prettierd)
    },
    typescriptreact = {
        util.copyf(defaults.prettierd)
    },
    json = {
        util.copyf(defaults.prettierd)
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

vim.api.nvim_exec(
    [[
        augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
        augroup END
    ]]
, false)
nnoremap('<leader>f', '<cmd>:Format<CR>')
nnoremap('<leader>F', '<cmd>:FormatWrite<CR>')
