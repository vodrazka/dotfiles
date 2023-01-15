local prefix = vim.fn.expand("~/.config")
local my_search_dirs = { '.', prefix .. '/nvim', '~/code/github-desktop/paster.nvim' }
local navic = require("nvim-navic")
require('telescope').setup {
    pickers = {
        find_files = {
            search_dirs = my_search_dirs
        },
        live_grep = {
            search_dirs = my_search_dirs
        }
    }
}
require("telescope").load_extension('harpoon')
require("tokyonight").setup {
    transparent = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    }
}
vim.cmd [[ colorscheme tokyonight ]]
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})
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
vim.keymap.set('n', '<leader>gg', ":GitGutter<CR>", {})
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
vim.keymap.set('n', '<leader>"', ":new<CR>", {})
vim.opt.splitright = true
vim.keymap.set('n', '<leader>%', ":vnew<CR>", {})
vim.opt.splitbelow = true
vim.keymap.set('n', '<leader>n', ":tabe<CR>:Telescope find_files<CR>", {})
-- completion
vim.keymap.set('i', '<C-Space>', "<C-X><C-O>", { noremap = true, desc = "LSP mode" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<leader>T', function() vim.cmd('split | term') end, { desc = "terminal open" })
vim.keymap.set('n', '<leader>.', ":set list!<CR>", {})
vim.keymap.set('n', "<Leader>d.", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
-- stolen from the web
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })
--github copilot
-- vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
-- vim.api.nvim_set_keymap('i', '<C-K>', 'copilot#Next()', {expr=true, silent=true})
-- vim.api.nvim_set_keymap('i', '<C-L>', 'copilot#Previous()', {expr=true, silent=true})
-- vim.api.nvim_set_keymap('i', '<C-H>', 'copilot#Suggest()', {expr=true, silent=true})
-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    navic.attach(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local cfg = {
    on_attach = on_attach,
}

require 'lspconfig'.bashls.setup(cfg)
require 'lspconfig'.dockerls.setup(cfg)
require 'lspconfig'.gopls.setup(cfg)
require 'lspconfig'.rust_analyzer.setup(cfg)
require 'neodev'.setup(cfg)
require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
require("lualine").setup({
    on_attach = on_attach,
    sections = {
        lualine_c = {
            { navic.get_location, cond = navic.is_available },
        }
    }
})
require("lsp_lines").setup()
vim.diagnostic.config({
    virtual_text = false,
})
require('smart-splits').setup({})
-- leap
local leap = require('leap')
leap.opts.case_sensitive = false
leap.opts.substitute_chars = { ['\r'] = '¬' }
leap.opts.safe_labels = { 'a', 's', 'd', 'f', 'j', 'k', 'l', ';' }
-- folding
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

-- global handler
-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
require('ufo').setup({
    fold_virt_text_handler = handler
})

-- buffer scope handler
-- will override global handler if it is existed
-- local bufnr = vim.api.nvim_get_current_buf()
-- require('ufo').setFoldVirtTextHandler(bufnr, handler)
-- rust
local rt = require("rust-tools")
local rt_opts = {
    server = {
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            vim.api.nvim_create_user_command('W', ":w | RustRun", { nargs = 0 })
        end,
    },
}
rt.setup(rt_opts)
