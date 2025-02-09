return {
	"leath-dub/snipe.nvim",
	keys = {
		{
			"<leader>gb",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open snipe buffer menu",
		},
	},
	opts = {},
}
