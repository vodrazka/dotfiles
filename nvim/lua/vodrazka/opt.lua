local prefix = vim.fn.expand("~/.config")
local opt = vim.opt
-- basics
vim.g.mapleader = " "
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "set formatoptions-=o" }) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "set formatoptions-=r" }) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
-- toot
vim.opt.backupcopy = 'yes'
-- intendation
opt.completeopt:remove "preview"
opt.wrap = false
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 0 -- inherit from tabstop
opt.softtabstop = -1 --inherit from shiftwidth
opt.listchars:append { tab = '<->' }
opt.listchars:append { space = '.' }
opt.listchars:append { nbsp = '␣' }
opt.listchars:append { trail = '-' }
opt.listchars:append { extends = '>' }
opt.listchars:append { precedes = '<' }
opt.listchars:append { eol = '$' }
opt.mouse = ''
opt.signcolumn = 'yes'
-- undo
opt.undodir = { prefix .. "/nvim/.undo//" }
opt.undofile = true
opt.directory = { prefix .. "/nvim/.swp//" }
-- terminal
opt.termguicolors = true
-- nu and gutter
opt.number = true
opt.numberwidth = 2
opt.relativenumber = false
opt.cursorline = true
-- fold
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true
