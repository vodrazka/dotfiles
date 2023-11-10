return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    "tsakirist/telescope-lazy.nvim",
  },
  config = function()
    require("telescope").load_extension "lazy"
    require("telescope").load_extension "harpoon"
  end,
  keys = {
    {'<leader>ff', function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    {'<leader>fg', function() require("telescope.builtin").live_grep() end, desc = "Find Grep" },
    {'<leader>fb', function() require("telescope.builtin").buffers() end, desc = "Find Buffers"},
    {'<leader>fs', function() require("telescope.builtin").grep_string() end, desc = "Find String" },
    {'<leader>fl', function() require("telescope").extensions.lazy.lazy() end, desc = "Find Plugins" },
    {'<leader>fh', function() require("telescope").extensions.harpoon.marks() end, desc = "Find Harpoon" },
  },
}
