return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "show lsp references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts) -- show definition, references

			opts.desc = "go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "show lsp definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts) -- show lsp definitions

			opts.desc = "show lsp implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts) -- show lsp implementations

			opts.desc = "show lsp type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts) -- show lsp type definitions

			opts.desc = "see available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "show buffer diagnostics"
			keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<cr>", opts) -- show  diagnostics for file

			opts.desc = "show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "restart lsp"
			keymap.set("n", "<leader>rs", ":LspRestart<cr>", opts) -- mapping to restart lsp if necessary

			opts.desc = "code format"
			keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- change the diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { error = " ", warn = " ", hint = "󰠠 ", info = " " }
		for type, icon in pairs(signs) do
			local hl = "diagnosticsign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure typescript server with plugin
		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure graphql language server
		lspconfig["graphql"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$vimruntime/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- configure golang server
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end,
		})

		-- configure bash server
		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure docker-compose server
		lspconfig["docker_compose_language_service"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure docker server
		lspconfig["dockerls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure eslint server
		local root_pattern = require("lspconfig.util").root_pattern
		lspconfig["eslint"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
			settings = {
				packageManager = "yarn",
			},
			root_dir = root_pattern(".eslintrc.js", "node_modules", ".git"),
		})

		-- configure gradle server
		lspconfig["gradle_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure json server
		lspconfig["jsonls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure xml server
		lspconfig["lemminx"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure markdown server
		lspconfig["marksman"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure rust server
		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure sql server
		lspconfig["sqlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure toml server
		lspconfig["taplo"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure terraform server
		lspconfig["terraformls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure vuejs server
		local util = require("lspconfig.util")
		local function get_typescript_server_path(root_dir)
			local global_ts = "/Users/bryan.stephens/.npm/lib/node_modules/typescript/lib"
			-- Alternative location if installed as root:
			-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
			local found_ts = ""
			local function check_dir(path)
				found_ts = util.path.join(path, "node_modules", "typescript", "lib")
				if util.path.exists(found_ts) then
					return path
				end
			end
			if util.search_ancestors(root_dir, check_dir) then
				return found_ts
			else
				return global_ts
			end
		end

		lspconfig["volar"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			on_new_config = function(new_config, new_root_dir)
				new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
			end,
		})

		-- configure yaml server
		lspconfig["yamlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
