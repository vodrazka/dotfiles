return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").register({
      f = "Find",
      h = "Harpoon",
    }, { prefix = "<leader>" })
  end,
  opts = {}
}
