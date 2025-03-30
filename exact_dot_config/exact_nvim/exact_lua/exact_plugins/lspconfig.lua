return {
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Note: opts = {} is the same as calling requires('fidget').setup({})
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- Helper function
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinitions")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("ge", vim.diagnostic.goto_next, "[G]oto next [E]rror")
					map("gE", vim.diagnostic.goto_prev, "[G]oto previous [E]rror")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations")
					map("<leader>r", vim.lsp.buf.rename, "[R]rename")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions", { "n", "v" })
					map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat", { "n", "v" })

					-- Highlight references of word under the cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = { Lua = { completion = { callSnippet = "Replace" } } },
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
