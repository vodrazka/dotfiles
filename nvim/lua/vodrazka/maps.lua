vim.g.mapleader = " "
vim.keymap.set('n', '<leader>.', ":set list!<CR>", { desc = "Toggle whitespaces"})
vim.keymap.set('n', '<leader>,', ":set hls!<CR>", { desc = "Toggle highlight search"})
vim.keymap.set('n', '<leader>k', ":bprevious<CR>", { desc = "Buffer previous"})
vim.keymap.set('n', '<leader>j', ":bnext<CR>", { desc = "Buffer next"})
vim.keymap.set('n', '<leader>x', ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Buffer delete"}) --delete but do not exit, strange that vim closes the windows by default...
vim.keymap.set('n', '<leader>t', ":tabnew<CR>", { desc = "Tab new"})
vim.keymap.set('n', '<leader>l', ":normal! ggVG=<C-O><CR>", { desc = "Format file"})
vim.cmd.colorscheme "koehler"
