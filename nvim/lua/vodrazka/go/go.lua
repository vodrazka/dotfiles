return {
  "ray-x/go.nvim",
  ft = { "go", "gomod", "gowork", "gosum" },

  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },

  build = ':lua require("go.install").update_all_sync()',

  init = function()
    -- `go install`-ed tools (gopls, delve, ...) land in `go env GOPATH`/bin.
    -- Make sure that dir is on PATH even if the shell that launched Neovim
    -- never sourced it, so gopls reliably resolves and the LSP attaches.
    if vim.fn.executable("go") == 1 then
      local gopath = vim.trim(vim.fn.system("go env GOPATH"))
      local gopath_bin = gopath .. "/bin"

      if gopath ~= "" and vim.fn.isdirectory(gopath_bin) == 1 then
        local sep = vim.fn.has("win32") == 1 and ";" or ":"
        if not vim.tbl_contains(vim.split(vim.env.PATH or "", sep), gopath_bin) then
          vim.env.PATH = gopath_bin .. sep .. (vim.env.PATH or "")
        end
      end
    end
  end,

  config = function()
    require("go").setup({
      lsp_cfg = {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,

            analyses = {
              unusedparams = true,
            },

            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },

      lsp_keymaps = false,

      dap_debug = true,

      lsp_on_attach = function(_, bufnr)
        local function map(keys, rhs, desc)
          vim.keymap.set("n", keys, rhs, {
            buffer = bufnr,
            silent = true,
            desc = desc,
          })
        end

        map("<leader>ra", function()
          vim.lsp.buf.code_action()
        end, "Go code action")

        map("<leader>rR", function()
          vim.cmd("GoRun")
        end, "Go run target")

        map("<leader>rr", function()
          local root = vim.fs.root(bufnr, { "go.mod", "go.work" }) or vim.fn.getcwd()

          vim.cmd("botright split")
          vim.cmd("lcd " .. vim.fn.fnameescape(root))
          vim.cmd("terminal go run .")
        end, "Go run")

        map("<leader>rt", function()
          vim.cmd("GoTest")
        end, "Go test target")

        map("<leader>rd", function()
          vim.cmd("GoDebug")
        end, "Go debug target")

        map("<leader>re", function()
          vim.diagnostic.open_float()
        end, "Go render diagnostic")

        map("K", function()
          vim.lsp.buf.hover()
        end, "Go hover")
      end,
    })
  end,

  event = { "CmdlineEnter" },
}
