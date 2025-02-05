return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"MaximilianLloyd/adjacent.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local fb_actions = require("telescope._extensions.file_browser.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-h>"] = actions.preview_scrolling_left,
						["<C-l>"] = actions.preview_scrolling_right,

						["<M-k>"] = actions.results_scrolling_up,
						["<M-j>"] = actions.results_scrolling_down,
						["<M-h>"] = actions.results_scrolling_left,
						["<M-l>"] = actions.results_scrolling_right,

						["<C-q>"] = function(prompt_bufnr)
							actions.smart_send_to_qflist(prompt_bufnr)
							vim.cmd("Trouble quickfix")
						end,
					},
					n = {
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-h>"] = actions.preview_scrolling_left,
						["<C-l>"] = actions.preview_scrolling_right,

						["<M-k>"] = actions.results_scrolling_up,
						["<M-j>"] = actions.results_scrolling_down,
						["<M-h>"] = actions.results_scrolling_left,
						["<M-l>"] = actions.results_scrolling_right,

						["<C-q>"] = function(prompt_bufnr)
							actions.smart_send_to_qflist(prompt_bufnr)
							vim.cmd("Trouble quickfix")
						end,
					},
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
					mappings = {
						n = {
							["<C-d>"] = actions.delete_buffer,
							["<C-f>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								builtin.find_files()
							end,
						},
						i = {
							["<C-d>"] = actions.delete_buffer,
							["<C-f>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								builtin.find_files()
							end,
						},
					},
				},
			},
			extensions = {
				file_browser = {
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					display_stat = { date = false, size = false, mode = false },
					git_status = true,
					mappings = {
						["i"] = {
							["<C-h>"] = fb_actions.toggle_hidden,
							-- your custom insert mode mappings
						},
						["n"] = {
							["h"] = fb_actions.toggle_hidden,
							-- your custom normal mode mappings
						},
					},
				},
				adjacent = {
					mappings = {
						["i"] = {
							["<C-f>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								builtin.find_files()
							end,
						},
						["n"] = {
							["<C-f>"] = function(prompt_bufnr)
								actions.close(prompt_bufnr)
								builtin.find_files()
							end,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("ui-select")
		telescope.load_extension("file_browser")
		telescope.load_extension("adjacent")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find open buffers" })
		keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set(
			"n",
			"<leader>fg",
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
			{ desc = "Live grep with args in cwd" }
		)
		keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fB", ":Telescope file_browser<CR>", { desc = "Open file browser in cwd" })
		keymap.set(
			"n",
			"<leader>fc",
			":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			{ desc = "Open file browser on directory of buffer" }
		)
		keymap.set("n", "<leader>fa", "<cmd>Telescope adjacent<CR>", { noremap = true, silent = false })
	end,
}
