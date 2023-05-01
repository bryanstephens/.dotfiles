local ok, lsp = pcall(require, "lsp-zero")
if not ok then
  return
end

local lsp = lsp.preset({"recommended"})

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function () vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function () vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vca", function () vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function () vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function () vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function () vim.lsp.buf.signature_help() end, opts)
end)

lsp.ensure_installed({
  "bashls",
  "cssls",
  "dockerls",
  "docker_compose_language_service",
  "gopls",
  "gradle_ls",
  "html",
  "jsonls",
  "lua_ls",
  "rust_analyzer",
  "sqlls",
  "tsserver",
  "volar",
  "yamlls",
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.rust_analyzer.setup({
  root_dir = lspconfig.util.root_pattern('Cargo.toml'),
})

lsp.setup()

local ok, cmp = pcall(require,"cmp")
if not ok then
  return
end

local ok, cmp_action = pcall(require,"lsp-zero")
if not ok then
  return
end

local cmp_action = cmp_action.cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = true}),

    ['<C-space>'] = cmp.mapping.complete(),

    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

