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
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "[Go] Code action"})
          vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { desc = "[Go] Go to definition"})
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "[Go] Docs"})
          vim.keymap.set("n", "gD", vim.lsp.buf.implementation, { desc = "[Go] Go to implementation"})
          vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, { desc = "[Go] Signature help"})
          vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, { desc = "[Go] Go to type definition"})
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[Go] Go to references"})
          vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { desc = "[Go] document_symbol"})
          vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { desc = "[Go] workspace_symbol"})
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[Go] Go to definition"})
          -- overrides
          vim.keymap.set('n', '<leader>l', ":GoFmt<CR>", { desc = "[Go] Format file"})
          vim.keymap.set('n', '<leader>r', ":w | !go run .<CR>", { desc = "[Go] Run"})
          vim.keymap.set('n', '<leader>rr', ":w | !go run . ", { desc = "[Go] Run with args"})
          vim.keymap.set('n', '<leader>ct', "gg:GoCodeLenAct<CR>", { desc = "[Go] Toggle GoCodeLenAct"})
        end
    })
    require("go.format").goimports()  -- goimports + gofmt
  end,
  event = {"CmdlineEnter"},
  ft = {"go"},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
