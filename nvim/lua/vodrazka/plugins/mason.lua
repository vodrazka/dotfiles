return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  lazy = true,
  cmd = "Mason",
  config = function()
    require("mason").setup{}
    require("mason-lspconfig").setup {
    ensurerinstalled = { "lua_ls", "rust_analyzer", "codelldb", "typos_lsp" },
}
  end,
}
