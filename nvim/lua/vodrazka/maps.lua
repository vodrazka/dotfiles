vim.g.mapleader = " "
vim.keymap.set('n', '<leader>.', ":set list!<CR>", { desc = "Toggle whitespaces"})
vim.keymap.set('n', '<leader>,', ":set hls!<CR>", { desc = "Toggle highlight search"})
vim.keymap.set('n', '<leader>j', ":bprevious<CR>", { desc = "Buffer previous"})
vim.keymap.set('n', '<leader>k', ":bnext<CR>", { desc = "Buffer next"})
vim.keymap.set('n', '<leader>x', ":bdelete<CR>", { desc = "Buffer delete"})
vim.keymap.set('n', '<leader>t', ":tabnew<CR>", { desc = "Tab new"})
vim.cmd.colorscheme "koehler"
