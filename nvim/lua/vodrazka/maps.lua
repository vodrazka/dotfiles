vim.g.mapleader = " "
vim.keymap.set("n", "<leader>.", ":set list!<CR>", { desc = "Toggle whitespaces" })
vim.keymap.set("n", "<leader>,", ":set hls!<CR>", { desc = "Toggle highlight search" })
vim.keymap.set("n", "<leader>k", ":bprevious<CR>", { desc = "Buffer previous" })
vim.keymap.set("n", "<leader>j", ":bnext<CR>", { desc = "Buffer next" })
vim.keymap.set("n", "<leader>x", ":bp<bar>sp<bar>bn<bar>bd!<CR>", { desc = "Buffer delete" }) --delete but do not exit, strange that vim closes the windows by default...
vim.keymap.set("n", "<leader>t", ":enew<CR>", { desc = "new buffer" })
vim.keymap.set("n", "<leader>l", ":normal! ggVG=<C-O><CR>", { desc = "Format file" })
vim.keymap.set("n", "<leader>w", ":cclose<CR>", { desc = "Close quickfix" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<leader>/", "gcc", {
  remap = true,
  silent = true,
  desc = "Toggle line comment",
})

vim.keymap.set("v", "<leader>/", "gc", {
  remap = true,
  silent = true,
  desc = "Toggle selected lines comment",
})
