-- custom functions
function P(e)
    print(vim.inspect(e))
end
local prefix = vim.fn.expand("~/.config")
-- basics
vim.g.mapleader = " "
-- custom shortcuts
vim.api.nvim_create_user_command('Reload', ":source $MYVIMRC", { nargs = 0 })
-- toot
vim.opt.backupcopy = 'yes'
-- intendation
vim.opt.completeopt:remove "preview"
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- inherit from tabstop
vim.opt.softtabstop = -1 --inherit from shiftwidth
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "set formatoptions-=o" }) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "set formatoptions-=r" }) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
vim.opt.listchars:append { tab = '<->' }
vim.opt.listchars:append { space = '.' }
vim.opt.listchars:append { nbsp = '␣' }
vim.opt.listchars:append { trail = '-' }
vim.opt.listchars:append { extends = '>' }
vim.opt.listchars:append { precedes = '<' }
vim.opt.listchars:append { eol = '$' }
vim.opt.mouse = ''
vim.opt.signcolumn = 'yes'
-- undo
vim.opt.undodir = { prefix .. "/nvim/.undo//" }
vim.opt.undofile = true
vim.opt.directory = { prefix .. "/nvim/.swp//" }
-- terminal
vim.opt.termguicolors = true
-- nu and gutter
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.cursorline = true
-- vim.opt.cursorlineopt = "number"
require("plugins")
