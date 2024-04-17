return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  ft = { "java" },
  config = function()
    local jdtls_install_dir = vim.fn.stdpath("data") .. "/mason"
    local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local jdtls = require('jdtls')
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    local lsp_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- mappings here
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

      opts.desc = "organize imports"
      keymap.set("n", "<leader>coi", jdtls.organize_imports, opts)
    end

    local config = {
      cmd = {
        vim.fn.expand("~/.asdf/installs/java/temurin-20.0.1+9/bin/java"),
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",

        "-jar", jdtls_install_dir .. "/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",

        "-configuration", jdtls_install_dir .. "/share/jdtls/config/",

        -- See `data directory configuration` section in the README
        "-data", vim.fn.expand("~/.cache/jdtls") .. workspace_dir
      },
      filetypes = {"java"},
      root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', '.tool-versions' }),
      on_attach = lsp_attach,
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          maven = {
            downloadSources = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          inlayHints = {
            parameterNames = {
              enabled = true,
            },
          },
          signatureHelp = {
            enabled = true,
          },
        },
      },
    }
    jdtls.start_or_attach(config)
  end,
}
