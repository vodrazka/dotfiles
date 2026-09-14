local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "vodrazka.check-requirements" }, -- Warns about missing system binaries on startup
    { import = "vodrazka.plugins" },
    { import = "vodrazka.dev" }, -- Shared dev tooling (mason, dap-ui, debug keymaps) for Rust and Go
    { import = "vodrazka.rust" }, -- Rust toolchain (rust-analyzer, crates); comment out to disable
    { import = "vodrazka.go" }, -- Go toolchain (gopls, dap); comment out to disable
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "zipPlugin",
        "netrwPlugin",
        "tarPlugin",
      },
    },
  },
})

