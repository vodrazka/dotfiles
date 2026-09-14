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
  end,
}
