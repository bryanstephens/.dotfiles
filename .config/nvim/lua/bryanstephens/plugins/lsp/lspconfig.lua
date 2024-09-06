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

    -- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
    local goplsCapabilities = vim.deepcopy(capabilities)
    goplsCapabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
        relativePatternSupport = false,
      }
    }

    -- configure golang server
    lspconfig["gopls"].setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
      capabilities = goplsCapabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the file
            -- twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-8"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
            vim.lsp.buf.format({async = false})
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

    lspconfig["jdtls"] = nil

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
    -- configure yaml server
    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
