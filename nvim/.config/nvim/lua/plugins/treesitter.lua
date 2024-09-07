return {
    -- syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- all parsers need to be updated when updgrading the plugin
        event = "VeryLazy",
        dependencies = {
            {
                -- select, swap and move text objects (paragraphs)
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        opts = {
            highlight = { enable = true },
            ensure_installed = {
                "bash",
                "css",
                "go",
                "html",
                "javascript",
                "markdown",
                "lua",
                "rust",
                "typescript",
                "tsx",
                "svelte",
                "yaml",
                "vimdoc",
                "markdown_inline",
                "prisma",
                "kotlin"
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["of"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["oc"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },

                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer" },
                    goto_next_end = { ["]F"] = "@function.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer" },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- show context of the current function
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = { max_lines = 3 },
        keys = {
            {
                "[c",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                desc = "Jump to context (upwards)",
            },
            {
                "<leader>ut",
                function()
                    local tsc = require("treesitter-context")
                    tsc.toggle()
                end,
                desc = "Toggle Treesitter Context",
            },
        },
    },
}
