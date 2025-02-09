return {
	-- General
	{ "echasnovski/mini.basics", version = false, config = true },
	{ "echasnovski/mini.bracketed", version = false, config = true },
	{ "echasnovski/mini.diff", version = false, config = true },
	{ "echasnovski/mini-git", version = false, main = "mini.git", config = true },

	-- Appearance
	{ "echasnovski/mini.cursorword", version = false, config = true },
	{ "echasnovski/mini.trailspace", version = false, config = true },

	-- Text editing
	{ "echasnovski/mini.ai", version = false, config = true },
	{ "echasnovski/mini.align", version = false, config = true },
	{ "echasnovski/mini.comment", version = false, config = true },
	{ "echasnovski/mini.completion", version = false, config = true },
	{ "echasnovski/mini.move", version = false, config = true },
	{ "echasnovski/mini.operators", version = false, config = true },
	{ "echasnovski/mini.pairs", version = false, config = true },
	{ "echasnovski/mini.splitjoin", version = false, config = true },
	-- { "echasnovski/mini.surround", version = false, config = true },

	-- Snippets
	{
		"echasnovski/mini.snippets",
		version = false,
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local gen_loader = require("mini.snippets").gen_loader
			require("mini.snippets").setup({
				snippets = {
					-- Load custom file with global snippets first (adjust for Windows)
					gen_loader.from_file("~/.config/nvim/snippets/global.json"),

					-- Load snippets based on current language by reading files from
					-- "snippets/" subdirectories from 'runtimepath' directories.
					gen_loader.from_lang(),
				},
			})
		end,
	},
}
