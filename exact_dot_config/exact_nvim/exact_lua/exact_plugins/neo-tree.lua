return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>n", ":Neotree reveal<CR>", silent = true },
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				position = "right",
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(_)
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
	end,
}
