return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				priority = 15,
				style = {
					{ fg = "#806d9c" },
					{ fg = "#c21f30" },
				},
				use_treesitter = true,
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				textobject = "",
				max_file_size = 1024 * 1024,
				error_sign = true,
				-- animation related
				duration = 100,
				delay = 100,
			},
			line_num = {
				enable = true,
				style = "#806d9c",
				use_treesitter = true,
				priority = 20,
			},
		})
	end
}
