-- custom functions
function P(e)
	print(vim.inspect(e))
end
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")

-- basics
vim.cmd [[ colorscheme koehler ]]
vim.g.mapleader = " "

-- custom shortcuts
vim.api.nvim_create_user_command('Reload', ":source $MYVIMRC", { nargs=0 })
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

-- undo
vim.opt.undodir = { prefix .. "/nvim/.undo//"}
vim.opt.undofile = true
vim.opt.directory = { prefix .. "/nvim/.swp//"}
-- vim.opt.backup = true
-- vim.opt.writebackup = true
-- vim.opt.backupdir = { prefix .. "/nvim/.backup//"}

-- terminal
vim.opt.termguicolors = true

-- nu and gutter
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = false
vim.opt.cursorline = true
-- vim.opt.cursorlineopt = "number"

require("plugins")

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files in telescope"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
local my_search_dirs={'.', prefix, '~/code/github-desktop/paster.nvim'}
require('telescope').setup{
  pickers = {
    find_files = {
       search_dirs = my_search_dirs
    },
    live_grep = {
       search_dirs = my_search_dirs
    }
  }
}

-- lsp
-- globals
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-Space>', "<C-X><C-O>", { noremap = true, desc="LSP mode"})
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<Tab>', "<C-N>", { noremap = true, desc="LSP mode"})
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<S-Tab>', "<C-P>", { noremap = true, desc="LSP mode"})

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- lsp bash
require'lspconfig'.bashls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
-- lsp Dockerfile
require'lspconfig'.dockerls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
