local status, lfs = pcall(require, "telescope")
if(not status) then
    return
end
local builtin = require('telescope.builtin')

--github copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Next()', {expr=true, silent=true})
-- telescope
vim.keymap.set('n', '<leader>/', ':map <lt>leader>', { desc = "help menu" })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "find grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "find buffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "find help" })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "find string" })
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { noremap = true, silent = true, desc = "preview diag" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "prev diag" })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "next diag" })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "open full diag" })
-- git
vim.keymap.set('n', '<leader>gr', ":GitGutter<CR>", {desc = "refresh"})
vim.keymap.set('n', '<leader>gu', ":GitGutterUndoHunk<CR>", { desc = "undo" })
vim.keymap.set('n', '<leader>gg', ":GitGutterPreviewHunk<CR>", { desc = "preview" })
vim.keymap.set('n', '<leader>gf', ":GitGutterDiffOrig<CR>", { desc = "full diff" })
vim.keymap.set('n', '<leader>gl', ":Git log<CR>", { desc = "log" })
vim.keymap.set('n', '<leader>gn', ":GitGutterNextHunk<CR>", { desc = "next hunk" })
vim.keymap.set('n', '<leader>gp', ":GitGutterPrevHunk<CR>", { desc = "previous hunk" })
vim.keymap.set('n', '<leader>ga', ":GitGutterStageHunk<CR>", { desc = "stage" })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "find git status" })
-- navigation
vim.keymap.set('n', '<leader>e', ":Ex<CR>", { desc = "open Expolorer" })
vim.keymap.set('n', '<leader>t', ":tabe<CR>", { desc = "new tab" })
vim.keymap.set('n', '<leader>]', ":tabn<CR>", { desc = "next tab" })
vim.keymap.set('n', '<leader>[', ":tabp<CR>", { desc = "prev tab" })
vim.keymap.set('n', '<leader>h', "<C-W>h", { desc = "left" })
vim.keymap.set('n', '<leader>j', "<C-W>j", { desc = "down" })
vim.keymap.set('n', '<leader>k', "<C-W>k", { desc = "up" })
vim.keymap.set('n', '<leader>l', "<C-W>l", { desc = "right" })
vim.keymap.set('n', '<leader>r', ":lua require('smart-splits').start_resize_mode()<CR>", { desc = "resize" })
vim.keymap.set('n', '<leader>x', ":bdel<CR>", { desc = "del buffer" })
vim.keymap.set('n', '<leader>X', ":bdel!<CR>", { desc = "force del buffer" })
vim.keymap.set('n', '<leader>-', ":new<CR>", { desc = "new split down" })
vim.opt.splitright = true
vim.keymap.set('n', '<leader>|', ":vnew<CR>", { desc = "new split right" })
vim.opt.splitbelow = true
vim.keymap.set('n', '<leader>n', ":tabe<CR>:Telescope find_files<CR>", { desc = "new tab and search" })
-- completion
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<leader>T', function() vim.cmd('split | term') end, { desc = "terminal open" })
vim.keymap.set('n', '<leader>.', ":set list!<CR>", { desc = "toogle whitespaces"})
local diagnostics_active = true
local toggle_diagnostics = function()
    diagnostics_active = not diagnostics_active
    vim.diagnostic.config({ virtual_text = diagnostics_active, })
end
-- stolen from the web
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })
