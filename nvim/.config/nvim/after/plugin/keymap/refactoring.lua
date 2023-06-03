local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>ri", function()
    require("refactoring").refactor("Inline Variable")
end);
