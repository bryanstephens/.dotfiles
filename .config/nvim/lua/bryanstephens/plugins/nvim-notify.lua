return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "static",
			render = "compact",
			background_colour = "FloatShadow",
			timeout = 3000,
		})
		vim.notify = require("notify")
	end,
}
