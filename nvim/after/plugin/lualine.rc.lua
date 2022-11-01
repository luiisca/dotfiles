local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" }, 
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  colored = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}
local filename = {
  'filename',
  file_status = true, -- displays file status (readonly status, modified status)
  path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
}
local filetype = {
  "filetype",
  icons_enabled = true,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {"branch"},
    lualine_c = { filename },
    lualine_x = { diagnostics, diff, filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
}
