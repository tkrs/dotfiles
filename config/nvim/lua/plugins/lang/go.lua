return {
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		opts = {},
	},

	{
		"fredrikaverpil/neotest-golang",
		ft = "go",
	},

	{
		"neovim/nvim-lspconfig",
		ft = "go",
		opts = {
			servers = {
				bacon_ls = {
					enabled = diagnostics == "bacon-ls",
				},
				rust_analyzer = { enabled = false },
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				},
			},
		},
		setup = {
			gopls = function(_, opts)
				-- workaround for gopls not supporting semanticTokensProvider
				-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
				Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
					if not client.server_capabilities.semanticTokensProvider then
						local semantic = client.config.capabilities.textDocument.semanticTokens
						client.server_capabilities.semanticTokensProvider = {
							full = true,
							legend = {
								tokenTypes = semantic.tokenTypes,
								tokenModifiers = semantic.tokenModifiers,
							},
							range = true,
						}
					end
				end)
				-- end workaround
			end,
		},
	},

	{
		"nvim-mini/mini.icons",
		ft = "go",
		opts = {
			file = {
				[".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
			},
			filetype = {
				gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
			},
		},
	},

	{
		"nvimtools/none-ls.nvim",
		ft = "go",
		optional = true,
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = { ensure_installed = { "gomodifytags", "impl" } },
			},
		},
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				nls.builtins.formatting.goimports,
				nls.builtins.formatting.gofumpt,
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		ft = "go",
		optional = true,
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = { ensure_installed = { "golangci-lint" } },
			},
		},
		opts = {
			linters_by_ft = {
				go = { "golangcilint" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		ft = "go",
		optional = true,
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
			},
		},
	},

	{
		"mfussenegger/nvim-dap",
		ft = "go",
		optional = true,
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = { ensure_installed = { "delve" } },
			},
			{
				"leoluz/nvim-dap-go",
				opts = {},
			},
		},
	},

	{
		"nvim-neotest/neotest",
		ft = "go",
		optional = true,
		dependencies = {
			"fredrikaverpil/neotest-golang",
		},
		opts = {
			adapters = {
				["neotest-golang"] = {
					-- Here we can set options for neotest-golang, e.g.
					-- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
					dap_go_enabled = true, -- requires leoluz/nvim-dap-go
				},
			},
		},
	},
}
