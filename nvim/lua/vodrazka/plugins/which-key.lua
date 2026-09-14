return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").add({
      {"<leader>d", group="Debug"},
      {"<leader>f", group="Find"},
      {"<leader>g", group="Git"},
      {"<leader>h", group="Harpoon"},
      {"<leader>r", group="Rust"},
    })
  end,
  opts = {}
}
