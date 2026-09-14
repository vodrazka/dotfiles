return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    priority = 1000,
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "codelldb", -- Rust dap adapter
        "delve", -- Go dap adapter
      },
      run_on_start = true,
      auto_update = false,
    },
  },
}
