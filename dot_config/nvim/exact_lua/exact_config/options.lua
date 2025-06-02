-- Tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 8
vim.o.smarttab = true
vim.o.expandtab = false

-- Numbers
vim.wo.number = true
vim.wo.relativenumber = false

-- Search options
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.wrapscan = true

vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = false
vim.wo.signcolumn = "auto"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	desc = "Fastlane files as ruby",
	pattern = { "Fastfile", "Appfile", "Matchfile", "Pluginfile" },
	command = "set filetype=ruby"
})
