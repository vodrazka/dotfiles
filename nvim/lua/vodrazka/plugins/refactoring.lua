return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()
  end,
  keys = {
    vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end, { desc = "Extract function" }),
    vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, { desc = "Extract function to file" }),
    -- Extract function supports only visual mode,
    vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, { desc = "Extract variable" }),
    -- Extract variable supports only visual mode,
    vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end, { desc = "Inline function" }),
    -- Inline func supports only normal,
    vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, { desc = "Inline variable" }),
    -- Inline var supports both normal and visual mode,
    vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end, { desc = "Extract block" }),
    vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end, { desc = "Extract block to file" }),
  }
}
