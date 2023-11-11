vim.g.mapleader = " "
vim.keymap.set('n', '<leader>.', ":set list!<CR>", { desc = "Toggle whitespaces"})
vim.keymap.set('n', '<leader>,', ":set hls!<CR>", { desc = "Toggle highlight search"})
vim.cmd.colorscheme "koehler"
