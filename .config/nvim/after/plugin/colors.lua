local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
  return
end

vim.cmd.colorscheme("tokyonight-night")

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

