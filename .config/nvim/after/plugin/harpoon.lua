local ok, mark = pcall(require, "harpoon.mark")

if not ok then
  return
end

local ok, ui = pcall(require, "harpoon.ui")

if not ok then
  return
end

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-f>", function() ui.nav_file(2) end)
