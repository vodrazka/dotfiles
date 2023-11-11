return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "ray-x/go.nvim",
    "ray-x/guihua.lua",
    'ray-x/navigator.lua',
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")

    mason.setup()

    lspconfig.lua_ls.setup {}

    require("go").setup({
      lsp_cfg = true,
      lsp_on_attach = function(client, bufnr)
        require("navigator").setup()
        require "lsp_signature".setup()
        vim.keymap.set('n', '<leader>dc', function()
          vim.cmd "GoDebug"
        end, { buffer = bufnr, desc = "GoDebug" })
        vim.keymap.set('n', '<leader>lf', function()
          require("go.format").goimport()
        end, { buffer = bufnr, desc = "GoDebug" })
        vim.keymap.set('n', '<leader>lh', function()
          vim.cmd "GoGenReturn"
        end, { buffer = bufnr, desc = "GoGenReturn" })
        vim.keymap.set('n', '<leader>l/', ":GoCheat ", { buffer = bufnr, desc = "GoGenReturn" })
      end,
    })

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = "Show errors in float" })
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Go to next error" })
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Go to prev error" })
    vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = "Show errors in loclist" })
    vim.keymap.set('n', '<leader>db', function()
      require("dap").toggle_breakpoint()
    end, { desc = "Breakpoint" })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Definition" })
        vim.keymap.set('n', '<leader>lc', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Declaration" })
        vim.keymap.set('n', '<leader>le', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type definition" })
        vim.keymap.set('n', '<leader>ll', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
        vim.keymap.set('n', '<leader>lj', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
        vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Implementation" })
        vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Help" })
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
        vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
        vim.keymap.set('n', '<leader>lu', vim.lsp.buf.references, { buffer = ev.buf, desc = "Usages" })
        vim.keymap.set('n', '<leader>lf', function()
          vim.lsp.buf.format { async = true }
        end, { buffer = ev.buf, desc = "Format" })
      end,
    })
  end,
}
