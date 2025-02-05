return {
	"stevearc/oil.nvim",
	opts = { default_file_explorer = false },
	keys = { { "-", "<CMD>Oil<CR>", desc = "Open Oil file explorer in parent directory" } },
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
