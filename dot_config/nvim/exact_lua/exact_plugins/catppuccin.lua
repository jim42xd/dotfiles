return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			transparent_background = true,
			integrations = {
				lsp_saga = true,
				cmp = true,
				telescope = { enabled = true },
			},
			custom_highlights = function(colors)
				return {
					-- Floating windows will have a solid background
					NormalFloat = { bg = colors.base },
					FloatBorder = { bg = colors.base, fg = colors.surface1 },
					Pmenu = { bg = colors.base },
					PmenuSel = { bg = colors.surface1 },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
