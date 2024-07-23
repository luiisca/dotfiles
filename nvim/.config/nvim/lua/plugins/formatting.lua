return {
    {
        "artemave/workspace-diagnostics.nvim"
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>zz",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>zZ",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>zL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>zQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        }
    },
    {
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

        -- tailwind class sorting
        -- {
        --     'laytan/tailwind-sorter.nvim',
        --     event = "VeryLazy",
        --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        --     build = 'cd formatter && npm i && npm run build',
        --     config = true,
        -- },
    }
}
