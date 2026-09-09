-- if true then return {} end

return {
	{ "ellisonleao/gruvbox.nvim" },

	{ "folke/tokyonight.nvim" },

	{ "nvim-lua/plenary.nvim" },

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},

	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function(self, opts)
			require("Comment").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "scala" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		ft = "rust",
		opts = { ensure_installed = { "rust", "ron" } },
	},

	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"goimports",
				"gofumpt",
				"delve",
				"golangci-lint",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>gF",
				function()
					require("telescope.builtin").git_files()
				end,
				mode = { "n" },
				silent = true,
			},
		},
		config = function(self, opts)
			require("telescope").setup(opts)
		end,
	},
}
