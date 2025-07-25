-- vim.lsp.set_log_level(vim.log.levels.TRACE) -- Use the enum

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

	-- Snippets
	-- {
	-- 	"SirVer/ultisnips",
	-- 	dependencies = { "honza/vim-snippets" },
	-- 	config = function()
	-- 		local default_dirs = {
	-- 			vim.fn.stdpath("config") .. "/snips",
	-- 			"UltiSnips",
	-- 		}
	--
	-- 		vim.g.UltiSnipsSnippetDirectories = default_dirs
	--
	-- 		-- vim.g.UltiSnipsExpandTrigger = "<tab>"
	-- 		-- vim.g.UltiSnipsJumpForwardTrigger = "<c-a-b>"
	-- 		-- vim.g.UltiSnipsJumpBackwardTrigger = "<c-a-y>"
	-- 		-- Tex-specific configuration
	--
	-- 		-- vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	-- 		-- 	pattern = "tex",
	-- 		-- 	callback = function()
	-- 		-- 		-- Set tex-specific directories
	-- 		-- 		vim.g.UltiSnipsSnippetDirectories = {
	-- 		-- 			vim.fn.stdpath("config") .. "/snips",
	-- 		-- 		}
	-- 		-- 		vim.g.UltiSnipsEnableSnipMate = 0
	-- 		-- 	end,
	-- 		-- })
	-- 		--
	-- 		-- -- Reset configuration for non-tex buffers
	-- 		-- vim.api.nvim_create_autocmd({ "BufLeave", "FileType" }, {
	-- 		-- 	pattern = "tex",
	-- 		-- 	callback = function()
	-- 		-- 		-- Restore default directories
	-- 		-- 		vim.g.UltiSnipsSnippetDirectories = default_dirs
	-- 		-- 		vim.g.UltiSnipsEnableSnipMate = 1
	-- 		-- 	end,
	-- 		-- })
	--
	-- 		vim.g.UltiSnipsEditSplit = "vertical"
	-- 	end,
	-- },

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
			-- {
			-- 	"quangnguyen30192/cmp-nvim-ultisnips",
			-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
			-- 	config = function()
			-- 		-- optional call to setup (see customization section)
			-- 		require("cmp_nvim_ultisnips").setup({})
			-- 	end,
			-- },
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

			-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert,preview",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				sources = {
					-- { name = "ultisnips" },
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	cmp_ultisnips_mappings.compose({ "expand" })(fallback)
					-- end),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					-- ["<c-z>"] = cmp.mapping(function(fallback)
					-- 	cmp_ultisnips_mappings.compose({ "jump_backwards" })(fallback)
					-- end),
					["<a-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<a-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					-- ["<c-b>"] = cmp.mapping(function(fallback)
					-- 	cmp_ultisnips_mappings.compose({ "jump_forwards" })(fallback)
					-- end),
					["<S-a-k>"] = cmp.mapping.scroll_docs(-4),
					["<S-a-j>"] = cmp.mapping.scroll_docs(4),
					["<a-f>"] = cmp.mapping.complete(),
					["<a-e>"] = cmp.mapping.abort(),
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			-- cmp.setup.cmdline(":", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources({
			-- 		{ name = "path" },
			-- 	}, {
			-- 		{ name = "cmdline" },
			-- 	}),
			-- 	matching = { disallow_symbol_nonprefix_matching = false },
			-- })

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
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

				lsp_zero.default_keymaps({ buffer = bufnr })

				vim.keymap.set("n", "gn", vim.lsp.buf.hover, { desc = "LSP buffer" })
				-- vim.keymap.set("n", "gv", vim.lsp.buf.references, { desc = "LSP references" })
				vim.keymap.set("n", "gv", function()
					require("telescope.builtin").lsp_references({
						show_line = false,
					})
				end, { desc = "LSP references" })
				vim.keymap.set("n", "vd", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
				vim.keymap.set("n", "gd", function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end, { desc = "Goto Definition" })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
				-- organize imports
				vim.keymap.set("n", "<leader>ooi", function()
					vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })
				end, { buffer = bufnr, desc = "Organize Imports" })
				vim.keymap.set("n", "<leader>oi", function()
					local params = {
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(0) },
						title = "",
					}
					vim.lsp.buf.execute_command(params)
				end, { buffer = bufnr, desc = "Organize ts Imports" })
			end)
			lsp_zero.set_server_config({
				single_file_support = false,
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"lua_ls",
					"ts_ls",
					"denols",
					"tailwindcss",
					"prismals",
					"svelte",
					"texlab",
				},
				handlers = {
					lsp_zero.default_setup,
					ts_ls = function()
						require("lspconfig").ts_ls.setup({
							root_dir = require("lspconfig").util.root_pattern({ "package.json", "tsconfig.json" }),
							single_file_support = false,
							settings = {},
						})
					end,
					denols = function()
						require("lspconfig").denols.setup({
							root_dir = require("lspconfig").util.root_pattern({ "deno.json", "deno.jsonc" }),
							single_file_support = false,
							settings = {},
						})
					end,
					lua_ls = function()
						-- local util = require("lspconfig.util")
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls({
							-- root_dir = function(filename)
							-- 	return util.path.dirname(filename)
							-- end,
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
					texlab = function()
						local util = require("lspconfig.util")
						require("lspconfig").texlab.setup({
							cmd = { "texlab" },
							filetypes = { "tex", "bib" },
							root_dir = function(filename)
								return util.path.dirname(filename)
							end,
							settings = {
								texlab = {
									auxDirectory = ".",
									bibtexFormatter = "texlab",
									build = {
										args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
										executable = "latexmk",
										forwardSearchAfter = false,
										onSave = true,
									},
									chktex = {
										onEdit = true,
										onOpenAndSave = true,
									},
									diagnosticsDelay = 300,
									formatterLineLength = 80,
									forwardSearch = {
										args = {},
									},
									latexFormatter = "latexindent",
									latexindent = {
										modifyLineBreaks = false,
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
