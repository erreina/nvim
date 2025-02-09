return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-nvim-lua", -- source for Neovim lua API
		"hrsh7th/cmp-nvim-lsp", -- source for lsp
		"onsails/lspkind.nvim", -- vs-code like pictograms
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" }, -- useful snippets
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load() -- for vs-code snippets (ie. friendly-snippets)
		require("luasnip.loaders.from_snipmate").lazy_load() -- for my custom snippets in snipmate format

		local lspkind = require("lspkind")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp completion
				{ name = "nvim_lua" }, -- nvin lua completion
				{ name = "luasnip" }, -- snippets
				{ name = "path" }, -- file system paths
				{ name = "buffer", keyword_length = 5 }, -- text within current buffer
			}),

			formatting = {
				format = function(entry, vim_item)
					-- Add LSPKind icons
					vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind

					-- show snippet descriptions in completion menu
					if entry.source.name == "luasnip" then
						local snippet = entry:get_completion_item().labelDetails
						if snippet and snippet.detail then
							vim_item.menu = snippet.detail
						end
					end
					return vim_item
				end,
			},

			window = {
				completation = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(), -- Enables documenation window
			},
		})
	end,
}
