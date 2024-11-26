return {
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    require('lspconfig').gopls.setup({
      -- gopls
    })
    require("go").setup({
      lsp_cfg = true,
      lsp_on_attach = function(_,buffnr)
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, keymap_opts)
          vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
          vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
          vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
          vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
          vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
          -- overrides
          vim.keymap.set('n', '<leader>l', ":GoFmt<CR>", { desc = "[Go] Format file"})
          vim.keymap.set('n', '<leader>r', ":w | !go run .<CR>", { desc = "[Go] Run"})
          vim.keymap.set('n', '<leader>rr', ":w | !go run . ", { desc = "[Go] Run with args"})
          vim.keymap.set('n', '<leader>cl', "ologrus.Info()<ESC>ha", { desc = "[Go] Insert logger below"})
        end
    })
    require("go.format").goimports()  -- goimports + gofmt
  end,
  event = {"CmdlineEnter"},
  ft = {"go"},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
