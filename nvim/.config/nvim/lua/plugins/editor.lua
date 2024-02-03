return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		keys = {
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

			-- find
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ ";o", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{
				";gf",
				function(opts)
					opts = opts or {}
					opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or ""
					require("telescope.builtin").find_files(opts)
				end,
				desc = "Git files",
			},

			-- search
			{
				";r",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ") })
				end,
				desc = "Grep string",
			},
			{ ";l", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
			{ ";fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Crr buffer fzf" },
			{
				";w",
				function()
					require("telescope.builtin").grep_string({ word_match = "-w" })
				end,
				desc = "Grep current word",
			},
			{
				";w",
				function()
					require("telescope.builtin").grep_string()
				end,
				mode = "v",
				desc = "Grep current word",
			},
			{
				";;",
				function()
					require("telescope.builtin").resume({ initial_mode = "normal" })
				end,
				desc = "Resume",
			},
			{
				";h",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help tags",
			},
			{
				";e",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>uc",
				function()
					require("telescope.builtin").colorscheme({ enable_preview = true })
				end,
				desc = "Colorscheme with preview",
			},
			-- { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },

			-- git
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
		},
		opts = function()
			local actions = require("telescope.actions")

			local find_files_no_ignore = function()
				local action_state = require("telescope.actions.state")
				local line = action_state.get_current_line()
				require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
			end
			local find_files_with_hidden = function()
				local action_state = require("telescope.actions.state")
				local line = action_state.get_current_line()
				require("telescope.builtin").find_files({ hidden = true, default_text = line })
			end

			return {
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					mappings = {
						i = {
							["<a-i>"] = find_files_no_ignore,
							["<a-h>"] = find_files_with_hidden,
							["<C-Down>"] = actions.cycle_history_next,
							["<C-Up>"] = actions.cycle_history_prev,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_up,
						},
						n = {
							["q"] = actions.close,
						},
					},
				},
			}
		end,
	},

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
			},
		},
		keys = {
			{
				";a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Harpoon mark add file",
			},
			{
				"vv",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Harpoon toggle quick menu",
			},
			{
				"<leader>h",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Harpoon navigate file 1",
			},
			{
				"<leader>j",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Harpoon navigate file 2",
			},
			{
				"<leader>k",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Harpoon navigate file 3",
			},
			{
				"<leader>l",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = "Harpoon navigate file 4",
			},
		},
	},

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- Automatically highlights other instances of the word under your cursor.
	{
		"RRethy/vim-illuminate",
		opts = {
			providers = { "lsp", "treesitter" },
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}
