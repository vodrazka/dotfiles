return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("lspconfig")
    local rt = require("rust-tools")
    rt.setup {
      server = {
        on_attach = function(_,buffnr)
          vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr , desc = "Code action"})
          -- vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, keymap_opts)
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
          vim.keymap.set('n', '<leader>l', ":RustFmt<CR>", { desc = "[Rust] Format file"})
          vim.keymap.set('n', '<leader>r', ":w | RustRun<CR>", { desc = "[Rust] Run"})
        end
      }
    }
  end,
}
