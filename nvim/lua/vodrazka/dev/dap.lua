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

    -- Captures the bufnr of any integrated terminal nvim-dap opens for a
    -- runInTerminal request (codelldb/Rust), so it can be reopened later via
    -- <leader>rl (see util/console.lua, rustaceanvim.lua, go.lua).
    dap.defaults.fallback.terminal_win_cmd = require("vodrazka.util.console").terminal_win_cmd

    -- delve (Go) has no runInTerminal terminal to hook into -- it streams
    -- output through DAP Output events into dap's REPL instead -- so mark
    -- Go sessions as repl-backed explicitly once they actually start.
    dap.listeners.after.event_initialized["console_tracker"] = function()
      local session = dap.session()
      if session and session.config and session.config.type == "go" then
        require("vodrazka.util.console").set_repl()
      end
    end

    -- Plain normal-mode keys (u, n, s, o, c, b, ...) are hijacked for the
    -- duration of any dap session -- see hijack_bind/hijack_unmap below,
    -- registered generically so it fires for every adapter (Go via delve,
    -- Rust via rustaceanvim/codelldb), not just whichever one happened to
    -- run first. go.nvim's own equivalent (go/dap.lua) is disabled via
    -- dap_debug_keymap = false in go.lua so the two don't fight over the
    -- same keys. Surface what's active so `u` not undoing doesn't come as
    -- a surprise.
    --
    -- This is a real split, not a floating window: floats only ever draw on
    -- *top* of whatever's underneath (tabline, dapui panels, code) -- they
    -- never reflow the layout, so there's no row a float can pick that's
    -- guaranteed overlap-free. A `topleft split` actually claims its own
    -- rows and pushes everything else down instead.
    local shortcuts_bar_bufnr, shortcuts_bar_winid

    local shortcuts_bar_items = {
      "c continue",
      "n step-over",
      "s step-into",
      "o step-out",
      "u stack-up",
      "D stack-down",
      "C run-to-cursor",
      "b breakpoint",
      "P pause",
      "S stop",
      "p hover/eval",
      "K float",
      "B breakpoints",
      "R repl",
      "O scopes",
      "a stacks",
      "w watches",
    }

    -- Greedily wraps the shortcut list to fit `width`, adding lines as
    -- needed instead of truncating, so the full cheatsheet is always shown.
    local function build_shortcuts_lines(width)
      width = math.max(width, 1)
      local prefix = " DEBUG  "
      local sep = "  |  "
      local lines = {}
      local current = ""
      local first_line = true

      local function budget()
        return first_line and (width - #prefix) or width
      end

      for _, item in ipairs(shortcuts_bar_items) do
        local candidate = current == "" and item or (current .. sep .. item)
        if #candidate > budget() and current ~= "" then
          table.insert(lines, (first_line and prefix or "") .. current)
          first_line = false
          current = item
        else
          current = candidate
        end
      end
      if current ~= "" or #lines == 0 then
        table.insert(lines, (first_line and prefix or "") .. current)
      end

      for i, l in ipairs(lines) do
        if #l < width then
          lines[i] = l .. string.rep(" ", width - #l)
        elseif #l > width then
          lines[i] = l:sub(1, width)
        end
      end

      return lines
    end

    local function set_shortcuts_bar_lines(lines)
      vim.bo[shortcuts_bar_bufnr].modifiable = true
      vim.api.nvim_buf_set_lines(shortcuts_bar_bufnr, 0, -1, false, lines)
      vim.bo[shortcuts_bar_bufnr].modifiable = false
    end

    local function render_shortcuts_bar()
      if not (shortcuts_bar_winid and vim.api.nvim_win_is_valid(shortcuts_bar_winid)) then
        return
      end
      local width = vim.api.nvim_win_get_width(shortcuts_bar_winid)
      local lines = build_shortcuts_lines(width)
      if vim.api.nvim_win_get_height(shortcuts_bar_winid) ~= #lines then
        vim.api.nvim_win_set_height(shortcuts_bar_winid, #lines)
      end
      set_shortcuts_bar_lines(lines)
    end

    local function open_shortcuts_bar()
      if shortcuts_bar_winid and vim.api.nvim_win_is_valid(shortcuts_bar_winid) then
        return
      end

      local prev_win = vim.api.nvim_get_current_win()

      shortcuts_bar_bufnr = vim.api.nvim_create_buf(false, true)
      vim.bo[shortcuts_bar_bufnr].buftype = "nofile"
      vim.bo[shortcuts_bar_bufnr].bufhidden = "wipe"
      vim.bo[shortcuts_bar_bufnr].swapfile = false

      local lines = build_shortcuts_lines(vim.o.columns)

      vim.cmd("topleft " .. #lines .. "split")
      shortcuts_bar_winid = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(shortcuts_bar_winid, shortcuts_bar_bufnr)

      set_shortcuts_bar_lines(lines)

      vim.wo[shortcuts_bar_winid].winfixheight = true
      vim.wo[shortcuts_bar_winid].number = false
      vim.wo[shortcuts_bar_winid].relativenumber = false
      vim.wo[shortcuts_bar_winid].signcolumn = "no"
      vim.wo[shortcuts_bar_winid].cursorline = false
      vim.wo[shortcuts_bar_winid].spell = false
      vim.wo[shortcuts_bar_winid].statusline = " "

      vim.api.nvim_set_hl(0, "DebugShortcutsBar", { link = "StatusLine", default = true })
      vim.wo[shortcuts_bar_winid].winhighlight = "Normal:DebugShortcutsBar,EndOfBuffer:DebugShortcutsBar"

      vim.api.nvim_set_current_win(prev_win)

      vim.api.nvim_create_autocmd("VimResized", {
        group = vim.api.nvim_create_augroup("DebugShortcutsBarResize", { clear = true }),
        callback = render_shortcuts_bar,
      })
    end

    local function close_shortcuts_bar()
      pcall(vim.api.nvim_del_augroup_by_name, "DebugShortcutsBarResize")
      if shortcuts_bar_winid and vim.api.nvim_win_is_valid(shortcuts_bar_winid) then
        vim.api.nvim_win_close(shortcuts_bar_winid, true)
      end
      shortcuts_bar_winid = nil
      shortcuts_bar_bufnr = nil
    end

    -- Bare-key overrides applied for the duration of any dap session, then
    -- fully restored on exit -- mirrors go.nvim's go/dap.lua keybind()/
    -- unmap(), but adapter-agnostic and armed from the first session rather
    -- than only after go.nvim's own :GoDebug has run once. Keys match
    -- shortcuts_bar_items above 1:1.
    local hijack_backup

    local function hijack_keys()
      return {
        c = dap.continue,
        n = dap.step_over,
        s = dap.step_into,
        o = dap.step_out,
        u = dap.up,
        D = dap.down,
        C = dap.run_to_cursor,
        b = dap.toggle_breakpoint,
        P = dap.pause,
        S = dap.terminate,
        p = dapui.eval,
        K = function()
          dapui.float_element()
        end,
        B = function()
          dapui.float_element("breakpoints")
        end,
        R = function()
          dapui.float_element("repl")
        end,
        O = function()
          dapui.float_element("scopes")
        end,
        a = function()
          dapui.float_element("stacks")
        end,
        w = function()
          dapui.float_element("watches")
        end,
      }
    end

    local function hijack_bind()
      hijack_backup = vim.api.nvim_get_keymap("n")
      for lhs, rhs in pairs(hijack_keys()) do
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = "dap: " .. lhs })
      end
    end

    -- Restores exactly what was overwritten (including keys that had no
    -- prior mapping, which are simply deleted) rather than assuming a
    -- fixed "default" behavior for each key.
    local function hijack_unmap()
      local keys = hijack_keys()
      for lhs in pairs(keys) do
        pcall(vim.keymap.del, "n", lhs)
      end
      for _, saved in ipairs(hijack_backup or {}) do
        if keys[saved.lhs] then
          vim.keymap.set(saved.mode == " " and "n" or saved.mode, saved.lhs, saved.rhs or saved.callback, {
            noremap = saved.noremap == 1,
            silent = saved.silent == 1,
            expr = saved.expr == 1,
            desc = saved.desc,
          })
        end
      end
      hijack_backup = nil
    end

    dap.listeners.after.event_initialized["hijack_keys"] = hijack_bind
    dap.listeners.before.event_terminated["hijack_keys"] = hijack_unmap
    dap.listeners.before.event_exited["hijack_keys"] = hijack_unmap

    -- dapui builds its own sidebar with a plain `:topleft vsplit` (see
    -- dapui/windows/init.lua), which blindly targets whatever window
    -- currently sits in the tabpage's top-left corner. Open the bar *after*
    -- dapui has laid out its panels, so that split lands against dapui's
    -- windows rather than dapui splitting into ours; close the bar *before*
    -- dapui.close() so its own cleanup only ever sees the windows it made.
    -- dap.listeners iterates listener tables with `pairs`, so ordering
    -- across separate named listeners isn't guaranteed -- sequencing both
    -- steps in one listener each keeps it deterministic.
    dap.listeners.after.event_initialized["dapui_auto_open"] = function()
      dapui.open()
      open_shortcuts_bar()
    end

    dap.listeners.before.event_terminated["dapui_auto_close"] = function()
      close_shortcuts_bar()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_auto_close"] = function()
      close_shortcuts_bar()
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

    -- <leader>rl (go.lua, rustaceanvim.lua) toggles whichever run/debug
    -- output -- normal run or debug session -- was produced most recently,
    -- for either language, via util/console.lua.
  end,
}
