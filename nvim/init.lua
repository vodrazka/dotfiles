-- custom functions
function P(e)
	print(vim.inspect(e))
end
local prefix = vim.fn.expand("~/.config")

-- basics
vim.cmd [[ colorscheme tokyonight-night ]]
vim.g.mapleader = " "

-- custom shortcuts
vim.api.nvim_create_user_command('Reload', ":source $MYVIMRC", { nargs=0 })
-- toot
vim.opt.backupcopy = 'yes'
-- navigation
vim.keymap.set('n', '<leader>w', ":Ex<CR>", {})
vim.keymap.set('n', '<leader>t', ":tabe<CR>", {})
vim.keymap.set('n', '<leader>]', ":tabn<CR>", {})
vim.keymap.set('n', '<leader>[', ":tabp<CR>", {})
vim.keymap.set('n', '<leader>h', "<C-W>h", {})
vim.keymap.set('n', '<leader>j', "<C-W>j", {})
vim.keymap.set('n', '<leader>k', "<C-W>k", {})
vim.keymap.set('n', '<leader>l', "<C-W>l", {})
vim.keymap.set('n', '<leader>x', ":bdel<CR>", {})
vim.keymap.set('n', '<leader>X', ":bdel!<CR>", {})
vim.keymap.set('n', '<leader>"', ":new<CR>", {})
vim.opt.splitright = true
vim.keymap.set('n', '<leader>%', ":vnew<CR>", {})
vim.opt.splitbelow = true
vim.keymap.set('n', '<leader>n', ":tabe<CR>:Telescope find_files<CR>", {})
-- harpoon
vim.keymap.set('n', '<leader>i', ":lua require('harpoon.mark').add_file()<CR>", {})
vim.keymap.set('n', '<leader>o', ":Telescope harpoon marks<CR>", {})
-- git
vim.keymap.set('n', '<leader>gg', ":GitGutter<CR>", {})
vim.keymap.set('n', '<leader>gr', ":GitGutterUndoHunk<CR>", {})
vim.keymap.set('n', '<leader>gd', ":GitGutterPreviewHunk<CR>", {})
vim.keymap.set('n', '<leader>gD', ":GitGutterDiffOrig<CR>", {})
-- completion
vim.keymap.set('i', '<C-Space>', "<C-N>", { noremap = true, desc="thomas default"})
vim.keymap.set('i', '<S-C-Space>', "<C-P>", { noremap = true, desc="thomas default"})
vim.opt.completeopt:remove "preview"
vim.keymap.set('t', '<Esc>','<C-\\><C-n>',{})
vim.keymap.set('n', '<leader>T', function()
    vim.cmd('split | term')
end, {desc = "terminal open"})
vim.keymap.set('n', '<leader>.', ":set list!<CR>", {})
-- stolen from the web
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true})

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
vim.opt.signcolumn='yes'

-- undo
vim.opt.undodir = { prefix .. "/nvim/.undo//"}
vim.opt.undofile = true
vim.opt.directory = { prefix .. "/nvim/.swp//"}

-- terminal
vim.opt.termguicolors = true

-- nu and gutter
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.cursorline = true
-- vim.opt.cursorlineopt = "number"

require("plugins")
