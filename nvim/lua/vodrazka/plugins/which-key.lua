return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").add({
      {"<leader>c", group="Code"},
      {"<leader>f", group="Find"},
      {"<leader>g", group="Git"},
      {"<leader>h", group="Harpoon"},
    })
  end,
  opts = {}
}
