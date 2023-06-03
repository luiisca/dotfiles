-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install plugins here
packer.startup(function(use)
	use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" })
	use({ "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" })
	use({ "kyazdani42/nvim-web-devicons", commit = "9061e2d355ecaa2b588b71a35e7a11358a7e51e1" }) -- File icons
	use({ "windwp/nvim-autopairs", commit = "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4" })
	use({ "windwp/nvim-ts-autotag", commit = "fdefe46c6807441460f11f11a167a2baf8e4534b" })
	use({ "numToStr/Comment.nvim", commit = "ad7ffa8ed2279f1c8a90212c7d3851f9b783a3d6" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })
	use({ "ThePrimeagen/harpoon", commit = "4dfe94e633945c14ad0f03044f601b8e6a99c708" })
	use({ "ThePrimeagen/git-worktree.nvim", commit = "d7f4e2584e81670154f07ca9fa5dd791d9c1b458" })
	use({ "ThePrimeagen/refactoring.nvim", commit = "c9ca8e3bbf7218101f16e6a03b15bf72b99b2cae" })
	use({ "mbbill/undotree", commit = "bd60cb564e3c3220b35293679669bb77af5f389d" })
	use({ "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" })
	use({ "nvim-lualine/lualine.nvim", commit = "3325d5d43a7a2bc9baeef2b7e58e1d915278beaf" })
	use({ "mhartington/formatter.nvim", commit = "1646b0bdc1c7e7d746aa0556d79d7be2394caa7b" })
	use({ "akinsho/toggleterm.nvim", commit = "8f302c9a05ff53fc3f891cbf09c5f959b10392a3" })
	use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })
	use({ "ahmedkhalf/project.nvim", commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4" })
	use({ "kyazdani42/nvim-tree.lua", commit = "cbb5313f9044a2ccf0b3e0f85a9e6a4e0fd0dd40" })
	use({ "Exafunction/codeium.vim", commit = "48eaf767680e7e35b89110e0193f99520e76f666" })

	-- Lodash of neovim
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }) -- Common utilities
	use({ "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" })
	use({ "nvim-telescope/telescope.nvim", commit = "97847309cbffbb33e442f07b8877d20322a26922" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
	})

	-- Colorschemes
	-- use { "sainnhe/gruvbox-material", commit = "2807579bd0a9981575dbb518aa65d3206f04ea02" }
	use({ "sainnhe/everforest", commit = "1db527e770deb8cbb3b5b60d8921f80bd2a4c12c" })

	-- CMP plugins
	use({ "hrsh7th/nvim-cmp", commit = "cdb77665bbf23bd2717d424ddf4bf98057c30bb3" }) -- Completion
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completitions
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }) -- path completitions
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" }) -- nvim-cmp source for neovim's built-in LSP
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "9166622781a39a829878d1fd24c174529d996838" })
	use({ "onsails/lspkind-nvim", commit = "57610d5ab560c073c465d6faf0c19f200cb67e6e" })
	use({ "williamboman/mason.nvim", commit = "7d7efc738e08fc5bee822857db45cb6103f0b0c1" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "f0ce33f4794a2364eb08d09d09380e8b04ec5e6a" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "77e53bc3bac34cc273be8ed9eb9ab78bcf67fa48" }) -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua. Depends on plenary
	use({ "RRethy/vim-illuminate", commit = "a2907275a6899c570d16e95b9db5fd921c167502" }) -- highlights occurrencies of current hovered word
	use({ "simrat39/symbols-outline.nvim", commit = "512791925d57a61c545bc303356e8a8f7869763c" }) -- A tree like view for symbols (functions, classes, etc)

	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) -- snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "c93311fbcc840210a2c0db574177d84a35a2c9c1" }) -- a bunch of snippets to use

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", commit = "9ada5f70f98d51e9e3e76018e783b39fd1cd28f7" })
	use({ "romgrk/nvim-treesitter-context", commit = "0dd5eae6dbf226107da2c2041ffbb695d9e267c1" })

	-- Zen mode
	use({ "folke/zen-mode.nvim", commit = "6f5702db4fd4a4c9a212f8de3b7b982f3d93b03c" })
	-- use({
	-- "iamcco/markdown-preview.nvim",
	-- run = function() vim.fn["mkdp#util#install"]() end,
	-- })
	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "6321c884b1a462918b1a7c7c016bcc2f0944832c" })
	use({ "TimUntersberger/neogit", commit = "1acb13c07b34622fe1054695afcecff537d9a00a" })
	use({ "dinhhuy258/git.nvim", commit = "dc876affe71de46c6dc4303ee6e0f217814a754e" }) -- For git blame & browse
end)
