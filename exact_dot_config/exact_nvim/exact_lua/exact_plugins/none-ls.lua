return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git", "pom.xml"),
			sources = {
				null_ls.builtins.formatting.stylua,
			},
		})
	end,
}
