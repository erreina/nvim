return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_installation = true,

			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls", -- lua
				"bashls", -- bash
				"clangd", -- C and C++
				"yamlls", -- yaml
				"eslint", -- javascript
				"ruff", -- python
				"rust_analyzer", -- rust
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"prettier", -- prettier formatter
				"clang-format", -- c, c++ formatter
				"yamllint", -- yaml linter
				"ruff", -- python linter
				"cspell", -- spell check
				"eslint_d", -- javascript linter
			},
		})
	end,
}
