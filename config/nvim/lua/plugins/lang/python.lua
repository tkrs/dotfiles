return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
					on_attach = function(client, _)
						client.server_capabilities.hoverProvider = false
					end,
				},
				ty = {
					settings = {
						ty = {
							-- disableLanguageServices = true,
							diagnosticMode = "workspace",
						},
					},
				},
			},
		},
	},
	{
		"nvim-neotest/neotest-python",
	},
	{
		"mfussenegger/nvim-dap-python",
		keys = {
			{
				"<leader>dPt",
				function()
					require("dap-python").test_method()
				end,
				desc = "Debug Method",
				ft = "python",
			},
			{
				"<leader>dPc",
				function()
					require("dap-python").test_class()
				end,
				desc = "Debug Class",
				ft = "python",
			},
		},
		config = function()
			require("dap-python").setup("debugpy-adapter")
		end,
	},
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		opts = {
			options = {
				notify_user_on_venv_activation = true,
				override_notify = false,
			},
		},
		ft = "python",
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
			config = function()
				require("dap-python").setup("debugpy-adapter")
			end,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		opts = function(_, opts)
			opts.auto_brackets = opts.auto_brackets or {}
			table.insert(opts.auto_brackets, "python")
		end,
	},
}
