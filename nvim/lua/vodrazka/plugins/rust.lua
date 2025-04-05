return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "rust-lang/rust.vim",
  },
  config = function()
    require("lspconfig")
    local rt = require("rust-tools")
    rt.setup {
      server = {
        on_attach = function(_,buffnr)
          vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr , desc = "[Rust] Code action"})
          -- vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "[Rust] Format file"})
          vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { desc = "[Rust] Go to definition"})
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "[Rust] Docs"})
          vim.keymap.set("n", "gD", vim.lsp.buf.implementation, { desc = "[Rust] Go to implementation"})
          vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, { desc = "[Rust] signature_help"})
          vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, { desc = "[Rust] type_definition"})
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[Rust] references"})
          vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { desc = "[Rust] document_symbol"})
          vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { desc = "[Rust] workspace_symbol"})
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[Rust] Go to definition"})
          -- overrides
          vim.keymap.set('n', '<leader>l', ":RustFmt<CR>", { desc = "[Rust] Format file"})
          vim.keymap.set('n', '<leader>r', ":w | RustRun<CR>", { desc = "[Rust] Run"})
        end
      }
    }
  end,
}
