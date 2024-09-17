return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		ensure_installed = {
			"prettier", -- prettier formatter
			"stylua",  -- lua formatter
			"isort",   -- python formatter
			"black",   -- python formatter
			"pylint",  -- python linter
			"goimports", -- go import optimizer
			"gofumpt", -- go formatter
		},
		run_on_start = true,
	},
}
