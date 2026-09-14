return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },

  dependencies = {
    "mfussenegger/nvim-dap",
  },

  init = function()
    local is_linux = vim.uv.os_uname().sysname == "Linux"
    local data = vim.fn.stdpath("data")

    local codelldb_root = data .. "/mason/packages/codelldb/extension"
    local codelldb_path = codelldb_root .. "/adapter/codelldb"
    local liblldb_path = codelldb_root
    .. "/lldb/lib/liblldb."
    .. (is_linux and "so" or "dylib")

    local codelldb_adapter = nil

    if vim.fn.executable(codelldb_path) == 1 then
      codelldb_adapter = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
          detached = false,
        },
      }
    end

    vim.g.rustaceanvim = {
      tools = {
        test_executor = "background",
      },

      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },

            procMacro = {
              enable = true,
            },

            checkOnSave = true,
            check = {
              command = "clippy",
              allTargets = true,
            },

            inlayHints = {
              bindingModeHints = {
                enable = true,
              },
              chainingHints = {
                enable = true,
              },
              closureReturnTypeHints = {
                enable = "with_block",
              },
              lifetimeElisionHints = {
                enable = "skip_trivial",
              },
              typeHints = {
                enable = true,
              },
            },

            lens = {
              enable = true,
              run = {
                enable = true,
              },
              debug = {
                enable = true,
              },
              implementations = {
                enable = true,
              },
            },
          },
        },

        on_attach = function(_, bufnr)
          local function map(keys, rhs, desc)
            vim.keymap.set("n", keys, rhs, {
              buffer = bufnr,
              silent = true,
              desc = desc,
            })
          end

          map("<leader>ra", function()
            vim.cmd.RustLsp("codeAction")
          end, "Rust code action")

          map("<leader>rR", function()
            vim.cmd.RustLsp("runnables")
          end, "Rust run target")

          map("<leader>rr", function()
            local root = vim.fs.root(bufnr, { "Cargo.toml" }) or vim.fn.getcwd()

            vim.cmd("botright split")
            vim.cmd("lcd " .. vim.fn.fnameescape(root))
            vim.cmd("terminal cargo run")
          end, "Cargo run")

          map("<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, "Rust test target")

          map("<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, "Rust debug target")

          map("<leader>rl", function()
            require("vodrazka.util.dap_terminal").open()
          end, "Rust debug logs")

          map("<leader>rm", function()
            vim.cmd.RustLsp({ "expandMacro", "vertical" })
          end, "Rust expand macro")

          map("<leader>re", function()
            vim.cmd.RustLsp("renderDiagnostic")
          end, "Rust render diagnostic")

          map("<leader>rE", function()
            vim.cmd.RustLsp("explainError")
          end, "Rust explain error")

          map("K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, "Rust hover actions")
        end,
      },

      dap = {
        adapter = codelldb_adapter,
      },
    }
  end,
}
