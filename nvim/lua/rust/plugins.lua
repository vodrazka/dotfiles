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
        "codelldb",
      },
      run_on_start = true,
      auto_update = false,
    },
  },

  {
    "saghen/blink.cmp",
    lazy = false,
    version = "1.*",

    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    opts = {
      keymap = {
        preset = "enter",
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = false,
        },
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },

    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
  "rcarriga/nvim-dap-ui",

  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_auto_open"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_auto_close"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_auto_close"] = function()
      dapui.close()
    end
  end,
},


  {
    "saecki/crates.nvim",
    ft = { "toml" },
    opts = {},
  },
}

