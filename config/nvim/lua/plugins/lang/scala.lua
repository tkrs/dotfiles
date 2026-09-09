return {
	{
		"mfussenegger/nvim-dap",
		ft = { "scala", "sbt", "java" },
		optional = true,
		config = function(_self, opts)
			-- Debug settings if you're using nvim-dap
			local dap = require("dap")

			dap.configurations.scala = {
				{
					type = "scala",
					request = "launch",
					name = "RunOrTest",
					metals = {
						runType = "runOrTestFile",
						--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
					},
				},
				{
					type = "scala",
					request = "launch",
					name = "Test Target",
					metals = {
						runType = "testTarget",
					},
				},
			}
		end,
	},

	{
		"scalameta/nvim-metals",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "mfussenegger/nvim-dap" },
			{ "j-hui/fidget.nvim" },
		},
		ft = { "scala", "sbt", "java" },
		keys = {
			{
				"<leader>me",
				function()
					require("telescope").extensions.metals.commands()
				end,
				desc = "Metals commands",
			},
			{
				"<leader>mc",
				function()
					require("metals").compile_cascade()
				end,
				desc = "Metals compile cascade",
			},
			{
				"<leader>mh",
				function()
					require("metals").hover_worksheet()
				end,
				desc = "Metals hover worksheet",
			},
		},
		opts = function()
			local metals_config = require("metals").bare_config()

			metals_config.init_options.statusBarProvider = "off"

			metals_config.settings = {
				serverVersion = "latest.stable",
				verboseCompilation = true,
				-- showImplicitArguments = true,
				-- showImplicitConversionsAndClasses = true,
				-- showInferredType = true,
				superMethodLensesEnabled = true,
				excludedPackages = {
					"akka.actor.typed.javadsl",
					"org.apache.pekko.actor.typed.javadsl",
					"com.github.swagger.akka.javadsl",
				},
				testUserInterface = "Test Explorer",
			}

			metals_config.on_attach = function(client, bufnr)
				-- your on_attach function
				require("metals").setup_dap()
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
			vim.api.nvim_create_autocmd("DiagnosticChanged", {
				callback = function()
					vim.diagnostic.setqflist({ open = false })
				end,
			})
		end,
	},
}
