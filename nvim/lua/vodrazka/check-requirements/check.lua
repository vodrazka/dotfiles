-- Checks that external binaries used by the other plugin modules are on PATH.
-- Not a real plugin: uses the `dir` trick so lazy.nvim treats this config
-- directory as an already-installed local plugin (no clone/build).
return {
  dir = vim.fn.stdpath("config"),
  name = "check-requirements",
  lazy = false,
  priority = 1000,

  config = function()
    -- bin: a binary name, or a list of alternatives (any one satisfies the check)
    local requirements = {
      {
        bin = "git",
        desc = "lazy.nvim plugin installs, gitsigns.nvim, Treesitter parser downloads",
      },
      {
        bin = { "curl", "wget" },
        desc = "mason.nvim and crates.nvim downloads",
      },
      {
        bin = "unzip",
        desc = "mason.nvim archive extraction",
      },
      {
        bin = "tar",
        desc = "mason.nvim archive extraction",
      },
      {
        bin = "gzip",
        desc = "mason.nvim archive extraction",
      },
      {
        bin = { "cc", "gcc", "clang" },
        desc = "compiling Treesitter parsers (:TSUpdate) and LuaSnip's jsregexp",
      },
      {
        bin = "make",
        desc = "building LuaSnip's optional jsregexp extension",
      },
      {
        bin = "rustc",
        desc = "Rust support (rustaceanvim, crates.nvim, blink.cmp's rust fuzzy matcher)",
      },
      {
        bin = "cargo",
        desc = "Rust support (rustaceanvim, <leader>rr cargo run)",
      },
      {
        bin = "rust-analyzer",
        desc = "Rust LSP server used by rustaceanvim (install via `rustup component add rust-analyzer`)",
      },
      {
        bin = "go",
        desc = "Go support (go.nvim, gopls/goimports install, delve build, <leader>rr go run)",
      },
      {
        bin = "gopls",
        desc = "Go LSP server used by go.nvim (auto-installed by :GoInstallBinaries once `go` is present)",
      },
      {
        bin = "rg",
        desc = "Telescope's live_grep and grep_string pickers",
      },
      {
        bin = "fd",
        desc = "faster Telescope find_files (falls back to internal search without it)",
      },
    }

    local function label(bin)
      if type(bin) == "table" then
        return table.concat(bin, "/")
      end
      return bin
    end

    local function found(bin)
      if type(bin) == "table" then
        for _, alt in ipairs(bin) do
          if vim.fn.executable(alt) == 1 then
            return true
          end
        end
        return false
      end
      return vim.fn.executable(bin) == 1
    end

    local function run(verbose)
      local missing = {}

      for _, req in ipairs(requirements) do
        if not found(req.bin) then
          table.insert(missing, req)
        end
      end

      if #missing == 0 then
        if verbose then
          vim.notify(
            ("check-requirements: all %d binaries found"):format(#requirements),
            vim.log.levels.INFO
          )
        end
        return
      end

      local lines = { "check-requirements: missing binaries" }
      for _, req in ipairs(missing) do
        table.insert(lines, ("  - %s (%s)"):format(label(req.bin), req.desc))
      end

      vim.notify(table.concat(lines, "\n"), vim.log.levels.WARN)
    end

    vim.api.nvim_create_user_command("CheckRequirements", function()
      run(true)
    end, { desc = "Check that all binaries used by plugins are installed" })

    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        run(false)
      end,
    })
  end,
}
