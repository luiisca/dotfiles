return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf, lsp_fallback = true })
			end,
		})
	end,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			markdown = { { "prettierd", "prettier" } },
			javascript = { { "prettierd", "prettier" } },
		},
	},
}
