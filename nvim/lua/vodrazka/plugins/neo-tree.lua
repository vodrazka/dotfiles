return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "main", -- HACK: force neo-tree to checkout `main` for initial v3 migration since default branch has changed
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  init = function() vim.g.neo_tree_remove_legacy_commands = true end,
  opts = function()
    return {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      window = {
        mappings = {
          ["l"] = { "open", config = { use_float = false, use_image_nvim = true } },
          ["h"] = { "close_node" },
        }
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
      },
    }
  end,
  keys = {
    {"<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer On/Off"},
    {"<leader>o", function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd.wincmd "p"
    else
      vim.cmd.Neotree "focus"
    end
  end, desc = "Explorer On/Focus" }
  }

}
