return {
  'theprimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    require('harpoon').setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      }
    })
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    vim.keymap.set("n", "<C-j>", function() ui.nav_next() end)
    vim.keymap.set("n", "<C-f>", function() ui.nav_prev() end)
  end,
}
