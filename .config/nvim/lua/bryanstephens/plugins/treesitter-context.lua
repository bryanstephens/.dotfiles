return {
	"nvim-treesitter/nvim-treesitter-context",
	after = "nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			context = {
				enable = true,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 10,
				trim_scope = 'outer',
				mode = 'cursor',
				on_attach = function(bufnr, _)
					require("nvim-treesitter-context").on_attach(bufnr)
				end,
			},
		})

		vim.keymap.set("n", "[c", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { silent = true })
	end,

}
