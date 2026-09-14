return {
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

    -- Shared debug keymaps, used by both Rust (rustaceanvim) and Go (go.nvim/dap-go).
    local function map(keys, rhs, desc)
      vim.keymap.set("n", keys, rhs, { silent = true, desc = desc })
    end

    map("<leader>db", function()
      dap.toggle_breakpoint()
    end, "Debug toggle breakpoint")

    map("<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, "Debug conditional breakpoint")

    map("<leader>dc", function()
      dap.continue()
    end, "Debug continue")

    map("<leader>do", function()
      dap.step_over()
    end, "Debug step over")

    map("<leader>di", function()
      dap.step_into()
    end, "Debug step into")

    map("<leader>dO", function()
      dap.step_out()
    end, "Debug step out")

    map("<leader>dx", function()
      dap.terminate()
    end, "Debug stop")
  end,
}
