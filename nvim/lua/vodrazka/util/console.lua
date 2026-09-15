-- Tracks whichever run/debug output was produced most recently -- a plain
-- `go run`/`cargo run` terminal (<leader>rr) or a debug session's output
-- (<leader>rd) -- so <leader>rl always reopens that one, regardless of
-- which command produced it last.
--
-- Debug output takes one of two shapes depending on the adapter:
--   - delve (Go) streams output through DAP Output events into dap's REPL
--     buffer instead of a real terminal, so it's tracked as kind = "repl"
--     and left to dap.repl's own open/close/toggle, which already restores
--     focus to the previous window (see nvim-dap's dap/repl.lua). Marked via
--     M.set_repl(), called from dev/dap.lua's event_initialized listener
--     once a Go session actually starts.
--   - codelldb (Rust) launches the debuggee via a runInTerminal reverse
--     request, landing in a real terminal buffer just like a normal run --
--     see M.terminal_win_cmd below, wired up as
--     dap.defaults.fallback.terminal_win_cmd in dev/dap.lua.
local M = {}

-- { kind = "buf", bufnr = number } | { kind = "repl" } | nil
M.last = nil

function M.terminal_win_cmd(config)
  vim.cmd("belowright new")
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  M.set_buf(buf)
  return buf, win
end

function M.set_buf(bufnr)
  M.last = { kind = "buf", bufnr = bufnr }
end

function M.set_repl()
  M.last = { kind = "repl" }
end

function M.toggle()
  if not M.last then
    vim.notify("No run/debug output captured yet.", vim.log.levels.WARN)
    return
  end

  if M.last.kind == "repl" then
    require("dap").repl.toggle()
    return
  end

  if not vim.api.nvim_buf_is_valid(M.last.bufnr) then
    vim.notify("No run/debug output captured yet.", vim.log.levels.WARN)
    return
  end

  local win = vim.fn.bufwinid(M.last.bufnr)
  if win ~= -1 then
    vim.api.nvim_win_close(win, false)
  else
    local prev_win = vim.api.nvim_get_current_win()
    vim.cmd("belowright sbuffer " .. M.last.bufnr)
    vim.api.nvim_set_current_win(prev_win)
  end
end

return M
