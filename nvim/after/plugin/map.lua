local status, lfs = pcall(require, "telescope")
if(not status) then
    return
end
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files in telescope" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
-- harpoon
vim.keymap.set('n', '<leader>fa', ":lua require('harpoon.mark').add_file()<CR>", {})
vim.keymap.set('n', '<leader>fh', ":Telescope harpoon marks<CR>", {})
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>ds', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, opts)
-- git
vim.keymap.set('n', '<leader>gg', ":GitGutter<CR>", {desc = "refresh gitgutter!"})
vim.keymap.set('n', '<leader>gr', ":GitGutterUndoHunk<CR>", {})
vim.keymap.set('n', '<leader>gv', ":GitGutterPreviewHunk<CR>", {})
vim.keymap.set('n', '<leader>gd', ":GitGutterDiffOrig<CR>", {})
vim.keymap.set('n', '<leader>gl', ":Git log<CR>", {})
-- leap
vim.keymap.set('n', '<leader>ss', "<Plug>(leap-forward-to)", {})
vim.keymap.set('n', '<leader>sa', "<Plug>(leap-backward-to)", {})
-- folding
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
-- navigation
vim.keymap.set('n', '<leader>w', ":Ex<CR>", {})
vim.keymap.set('n', '<leader>t', ":tabe<CR>", {})
vim.keymap.set('n', '<leader>]', ":tabn<CR>", {})
vim.keymap.set('n', '<leader>[', ":tabp<CR>", {})
vim.keymap.set('n', '<leader>h', "<C-W>h", {})
vim.keymap.set('n', '<leader>j', "<C-W>j", {})
vim.keymap.set('n', '<leader>k', "<C-W>k", {})
vim.keymap.set('n', '<leader>l', "<C-W>l", {})
vim.keymap.set('n', '<leader>r', ":lua require('smart-splits').start_resize_mode()<CR>", {})
vim.keymap.set('n', '<leader>x', ":bdel<CR>", {})
vim.keymap.set('n', '<leader>X', ":bdel!<CR>", {})
vim.keymap.set('n', '<leader>-', ":new<CR>", {})
vim.opt.splitright = true
vim.keymap.set('n', '<leader>|', ":vnew<CR>", {})
vim.opt.splitbelow = true
vim.keymap.set('n', '<leader>n', ":tabe<CR>:Telescope find_files<CR>", {})
-- completion
vim.keymap.set('i', '<C-Space>', "<C-X><C-O>", { noremap = true, desc = "LSP mode" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<leader>T', function() vim.cmd('split | term') end, { desc = "terminal open" })
vim.keymap.set('n', '<leader>.', ":set list!<CR>", {})
vim.keymap.set('n', "<Leader>d.", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
local diagnostics_active = true
local toggle_diagnostics = function()
    diagnostics_active = not diagnostics_active
    vim.diagnostic.config({ virtual_text = diagnostics_active, })
end
vim.keymap.set('n', "<Leader>d,", toggle_diagnostics, {desc = "Toggle normal diagnostics"})
-- stolen from the web
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

--github copilot
-- vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
-- vim.api.nvim_set_keymap('i', '<C-K>', 'copilot#Next()', {expr=true, silent=true})
-- vim.api.nvim_set_keymap('i', '<C-L>', 'copilot#Previous()', {expr=true, silent=true})
-- vim.api.nvim_set_keymap('i', '<C-H>', 'copilot#Suggest()', {expr=true, silent=true})
