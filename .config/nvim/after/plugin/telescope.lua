local ok, builtin = pcall(require, "telescope.builtin")
if not ok then
  return
end

vim.keymap.set('n', '<leader>pf', function()
  builtin.find_files({hidden = true})
end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
