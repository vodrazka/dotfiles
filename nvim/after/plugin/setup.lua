local status, lfs = pcall(require, "telescope")
if (not status) then
    return
end
local prefix = vim.fn.expand("~/.config")
local my_search_dirs = { '.', prefix .. '/nvim', '~/code/github-desktop/paster.nvim' }
--local navic = require("nvim-navic")

require("mason").setup()
require('smart-splits').setup({})
local actions = require "telescope.actions"
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                ["<C-j>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-S-j>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
            },
        }

    },
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
vim.cmd [[ colorscheme koehler ]]
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})
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
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

-- global handler
-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
require('ufo').setup({
    fold_virt_text_handler = handler
})

-- LSP, Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'completefunc', 'v:lua.vim.lsp.omnifunc')

    -- custom hover
    local my_lsp = {
        float = {
            focusable = true,
            style = "minimal",
            border = "double",
            relative = "cursor"
        }
    }
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, my_lsp.float)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local better_lsp_hover = function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end

    -- map
    vim.keymap.set('i', '<C-Space>', "<C-X><C-O>", { noremap = true, desc = "LSP mode" })
    vim.keymap.set('i', '<C-l>', "<C-X><C-L>", { noremap = true, desc = "LSP mode" })
    vim.keymap.set('i', '<C-k>', better_lsp_hover, bufopts)
    --vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<C-k>', better_lsp_hover, bufopts)
    vim.keymap.set('n', '<C-Space>', better_lsp_hover, bufopts)
    --vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', better_lsp_hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local cfg = {
    on_attach = on_attach,
}
local cfg_rust = {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.keymap.set('n', '<leader>ww', ":RustRun<CR>", { noremap = true, desc = "rust run" })
        vim.keymap.set('n', '<leader>wp', ":RustPlay<CR>", { noremap = true, desc = "rust run" })
    end
}
require 'lspconfig'.bashls.setup(cfg)
require 'lspconfig'.dockerls.setup(cfg)
--require 'lspconfig'.gopls.setup(cfg)
require 'lspconfig'.rust_analyzer.setup(cfg_rust)
require 'neodev'.setup(cfg)
require 'lspconfig'.lua_ls.setup {
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
require("lualine").setup({ on_attach = on_attach })
require("lsp_lines").setup()
require("lsp_lines").toggle() --to be off be default
