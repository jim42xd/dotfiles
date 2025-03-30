return {
	{
		"linrongbin16/lsp-progress.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lsp-progress").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "linrongbin16/lsp-progress.nvim" },
		config = function()
			require("lualine").setup({
				options = { theme = "codedark" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = { require("lsp-progress").progress },
				},
			})

			-- listen to lsp-progress event and refresh lualine
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
		end,
	},
}
