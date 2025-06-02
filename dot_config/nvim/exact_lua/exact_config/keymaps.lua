-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP', { desc = "Paste and retain" })
vim.keymap.set("n", "<esc>", ":nohl<CR>", { desc = "Remove highlight", silent = true })
vim.keymap.set("n", "U", "<c-r>", { desc = "Nicer re-do" })

-- Improve navigation
vim.keymap.set("n", "{", "}")
vim.keymap.set("n", "}", "{")
