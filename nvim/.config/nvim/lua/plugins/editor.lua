local detail = false

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
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
        keys = {
            { "<leader>:",       "<cmd>Telescope command_history<cr>", desc = "Command History" },

            -- find
            { "<leader><space>", "<cmd>Telescope find_files<cr>",      desc = "Find files" },
            { ";o",              "<cmd>Telescope oldfiles<cr>",        desc = "Recent" },
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
            { ";l",  "<cmd>Telescope live_grep<cr>",                 desc = "Grep (root dir)" },
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
            { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "commits" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>",   desc = "status" },
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
                    path_display = {
                        shorten = { len = 3, exclude = { 1, -1 } }
                    }
                },
            }
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
        },
        config = function ()
            local harpoon = require('harpoon')
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                }
            })
            vim.keymap.set("n", ";a", function() harpoon:list():add() end, {desc = "Harpoon mark add file"})
            vim.keymap.set("n", "vv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoon toggle quick menu"})
            vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end, {desc = "Harpoon navigate file 1"})
            vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end, {desc = "Harpoon navigate file 2"})
            vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end, {desc = "Harpoon navigate file 3"})
            vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end, {desc = "Harpoon navigate file 4"})
        end,
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

    -- undotree
    {
        "mbbill/undotree",
    },

    -- foldings
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
            vim.keymap.set('n', 'zK', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = 'Close all folds' })

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'lsp', 'indent' }
                end,
                fold_virt_text_handler = handler
            })
        end
    },

    -- zen-mode
    {
        "folke/zen-mode.nvim"
    },

    -- vinegar
    -- {
    --     "tpope/vim-vinegar"
    -- },

    -- oil
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            keymaps = {
                ["gn"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
        },
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },

    -- AI
    {
        "Exafunction/codeium.vim",
        event = 'BufEnter',
        config = function()
            vim.g.codeium_no_map_tab = 1
            vim.keymap.set('i', '<A-g>', function() return vim.fn['codeium#Accept']() end,
                { expr = true, silent = true, desc = 'codeium accept' })
            vim.keymap.set('i', '<A-r>', function() return vim.fn['codeium#Clear']() end,
                { expr = true, silent = true, desc = 'codeium clear' })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- vimtex
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"
            -- vim.g.vimtex_quickfix_mode = 0
        end
    }
}
