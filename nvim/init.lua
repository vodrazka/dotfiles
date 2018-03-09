-- custom functions
function P(e)
	print(vim.inspect(e))
end

-- basics
vim.cmd [[ colorscheme koehler ]]
vim.g.mapleader = " "

-- custom shortcuts
vim.keymap.set('n', '<leader>ss', ":source $MYVIMRC<CR>", { noremap = true, silent = false })
vim.keymap.set('n', '<leader>w', "<cmd>:Ex<CR>", {})
vim.keymap.set('n', '<leader>e', "<cmd>:tabe<CR>", {})
vim.keymap.set('n', '<leader>]', "<cmd>:tabn<CR>", {})
vim.keymap.set('n', '<leader>[', "<cmd>:tabp<CR>", {})
vim.keymap.set('n', '<leader>h', "<cmd>:set hls!<CR>", {})
vim.keymap.set('n', '<leader>l', "<cmd>:set list!<CR>", {})
vim.keymap.set('t', '<Esc>','<C-\\><C-n>',{})
vim.keymap.set('n', '<leader>t', function()
    vim.cmd('split | term')
end, {desc = "terminal open"})

-- intendation
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- inherit from tabstop
vim.opt.softtabstop = -1 --inherit from shiftwidth
vim.api.nvim_create_autocmd({"BufWinEnter"},{command="set formatoptions-=o"}) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
vim.opt.listchars:append {tab='<->'}
vim.opt.listchars:append {space='.'}
vim.opt.listchars:append {nbsp='␣'}
vim.opt.listchars:append {trail='-'}
vim.opt.listchars:append {extends='>'}
vim.opt.listchars:append {precedes='<'}
vim.opt.listchars:append {eol='$'}
vim.opt.mouse = ''

-- undo
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.undodir = { prefix .. "/nvim/.undo//"}
vim.opt.undofile = true
vim.opt.backupdir = { prefix .. "/nvim/.backup//"}
vim.opt.directory = { prefix .. "/nvim/.swp//"}

-- terminal
vim.opt.termguicolors = true

-- nu and gutter
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

require("plugins")

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files in telescope"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
