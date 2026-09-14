return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    require("which-key").add({
      {"<leader>d", group="Debug"},
      {"<leader>f", group="Find"},
      {"<leader>g", group="Git"},
      {"<leader>h", group="Harpoon"},
      {"<leader>r", group="Run"},
    })
  end,
  opts = {}
}
