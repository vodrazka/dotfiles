return {
  'ThePrimeagen/harpoon',
  dependencies = {'nvim-lua/plenary.nvim'},
  keys = {
    {'<leader>hh', function() require("harpoon.mark").add_file() end, desc = "Add File" },
    {'<leader>hr', function() require("harpoon.mark").rm_file() end, desc = "Remove File" },
  }

}
