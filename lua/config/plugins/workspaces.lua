return {
	"natecraddock/workspaces.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	keys = {
		{
			"<leader>fW",
			"<cmd>Telescope workspaces<cr>",
			desc = "Workspaces",
		},
	},
	config = function()
		require("workspaces").setup({})
	end,
}
