return {
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
}
