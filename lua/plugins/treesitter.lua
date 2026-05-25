return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local configs = require("nvim-treesitter")

		configs.setup({
			-- Download automatisch de juiste parser zodra je een nieuw bestandstype opent
			auto_install = true,
			highlight = {
				enable = true,
			},
		})

		configs.install({ "c_sharp" })
	end,
}
