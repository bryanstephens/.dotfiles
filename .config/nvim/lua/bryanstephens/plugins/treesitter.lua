return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = {
          enable = true,
          disable = { 'yaml' }
        },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        -- autotag = {
        --   enable = true,
        -- },
        -- ensure these language parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "java",
          "typescript",
          "yaml",
          "html",
          "css",
          "scss",
          "markdown",
          "markdown_inline",
          "graphql",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "rust",
          "go",
          "c",
          "vimdoc",
          "query",
          "vue",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}
