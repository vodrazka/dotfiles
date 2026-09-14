-- Tracks the integrated terminal buffer nvim-dap creates for adapters that
-- run the debuggee via a runInTerminal reverse request (codelldb/Rust does
-- this; delve/Go streams output through DAP Output events into the repl
-- instead, see dap.repl.open()). That buffer survives after the window
-- closes -- it's only hidden -- so it can be reopened once the session and
-- its dapui panels are gone.
local M = {}

M.last_bufnr = nil

function M.terminal_win_cmd(config)
  vim.cmd("belowright new")
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  M.last_bufnr = buf
  return buf, win
end

function M.open()
  if not (M.last_bufnr and vim.api.nvim_buf_is_valid(M.last_bufnr)) then
    vim.notify("No debug terminal output captured yet.", vim.log.levels.WARN)
    return
  end
  vim.cmd("belowright sbuffer " .. M.last_bufnr)
end

return M
