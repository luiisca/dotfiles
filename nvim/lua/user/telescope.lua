local status, telescope = pcall(require, "telescope")
if (not status) then return end

local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " >",
		color_devicons = true,
        selection_caret = " ",
        file_ignore_patterns = { ".git"},

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
                ["<CR>"] = actions.select_default,
                ["<Down>"] = actions.cycle_history_next,
                ["<Up>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                -- ["<C-k>"] = actions.move_selection_previous,
			},
            n = {
                ["q"] = actions.close,
                ["<S-j>"] = actions.move_to_bottom,
                [";j"] = actions.move_to_middle,
                ["<S-k>"] = actions.move_to_top,
                ["<S-d>"] = actions.preview_scrolling_up,
                ["<S-f>"] = actions.preview_scrolling_down,
            },
        }
	},
})

telescope.load_extension("git_worktree")
telescope.load_extension('fzf')

local M = {}

function M.reload_modules()
	-- Because TJ gave it to me.  Makes me happpy.  Put it next to his other
	-- awesome things.
	local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
	for _, dir in ipairs(lua_dirs) do
		dir = string.gsub(dir, "./lua/", "")
		require("plenary.reload").reload_module(dir)
	end
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end

return M
