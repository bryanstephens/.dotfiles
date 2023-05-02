local ok, builtin = pcall(require, "telescope.builtin")
if not ok then
  return
end

require("telescope").setup({
  pickers = {
    live_grep = {
      additional_args = {"--hidden"}
    }
  }
})

vim.keymap.set('n', '<leader>pf', function()
  builtin.find_files({hidden = true})
end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
