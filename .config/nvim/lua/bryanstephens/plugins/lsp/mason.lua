return {
	"williamboman/mason.nvim",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
			ensure_installed = {
				"html",
				"cssls",
				"graphql",
				"pyright",
				"lua_ls",
				"bashls",
				"docker_compose_language_service",
				"dockerls",
				"eslint",
				"gopls",
				"gradle_ls",
				"jsonls",
				"lemminx",
				"marksman",
				"rust_analyzer",
				"sqlls",
				"taplo",
				"terraformls",
				"volar",
				"yamlls",
			},
		},
		automatic_installation = true, -- not the same as ensure_installed
	},
}
