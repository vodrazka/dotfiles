return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/vim-vsnip",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    require("lspconfig")
    --Set completeopt to have a better completion experience
    -- :help completeopt
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force to select one from the menu
    -- shortness: avoid showing extra messages when using completion
    -- updatetime: set updatetime for CursorHold
    vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
    vim.opt.shortmess = vim.opt.shortmess + { c = true}
    vim.api.nvim_set_option('updatetime', 300) 

    -- Fixed column for diagnostics to appear
    -- Show autodiagnostic popup on cursor hover_range
    -- Goto previous / next diagnostic warning / error 
    -- Show inlay_hints more frequently 
    vim.keymap.set("n", "<Leader>cd", function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end, {desc = "Toggle diagnostics"})
    -- vim.cmd([[
    -- set signcolumn=yes
    -- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    -- ]])
    -- Completion Plugin Setup
    local cmp = require("cmp")
    cmp.setup({
      -- Enable LSP snippets
      snippet = {
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body)
          require'luasnip'.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
      },
      preselect = cmp.PreselectMode.None,
      -- Installed sources:
      sources = {
        { name = 'path' },                              -- file paths
        { name = 'luasnip', priority = 8},
        { name = 'nvim_lsp', keyword_length = 3, priority = 5 },      -- from language server
        { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
        { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer', keyword_length = 2 },        -- source current buffer
        -- { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
        { name = 'calc'},                               -- source for math calculation
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
          local menu_icon ={
            nvim_lsp = 'λ',
            vsnip = '⋗',
            luasnip = '✂︎',
            buffer = 'Ω',
            path = 'P',
          }
          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },
    })
  end,
}
