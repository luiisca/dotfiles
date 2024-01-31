return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
			{
				"ray-x/lsp_signature.nvim",
				event = "VeryLazy",
				opts = {
					bind = true,
					hint_prefix = "",
					handler_opts = {
						border = "none", -- double, rounded, single, shadow, none, or a table of borders
					},
					padding = " ",
				},
				config = function(_, opts)
					require("lsp_signature").setup(opts)
				end,
			},
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			require("luasnip.loaders.from_vscode").lazy_load() -- load snippets from friendly-snippets

			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert,preview",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<a-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<a-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<S-a-k>"] = cmp.mapping.scroll_docs(-4),
					["<S-a-j>"] = cmp.mapping.scroll_docs(4),
					["<a-f>"] = cmp.mapping.complete(),
					["<a-e>"] = cmp.mapping.abort(),
				}),
			})

			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			--- if you want to know more about lsp-zero and mason.nvim
			--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "rust_analyzer" },
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls({
							settings = {
								Lua = {
									completion = {
										callSnippet = "Both",
										displayContext = 4,
									},
								},
							},
						})
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})
		end,
	},
}
