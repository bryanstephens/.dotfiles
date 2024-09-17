return {
  "williamboman/mason.nvim",
  dependencies = {
    "folke/neoconf.nvim",
    'folke/neodev.nvim',
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-java/nvim-java",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
			registries = {
				'github:nvim-java/mason-registry',
				"github:mason-org/mason-registry",
			}
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
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
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "goimports", -- go import optimizer
        "gofumpt", -- go formatter
      },
    })
  end,
}
