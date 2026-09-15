-- Default vim.ui.select (used by RustLsp testables/debuggables etc.) asks for a
-- number via inputlist with nothing pre-filled. Override it so the prompt
-- defaults to "1" and <CR> accepts it immediately.
vim.ui.select = function(items, opts, on_choice)
  opts = opts or {}

  if #items == 0 then
    on_choice(nil, nil)
    return
  end

  local format_item = opts.format_item or tostring
  local lines = { opts.prompt or "Select one of:" }
  for i, item in ipairs(items) do
    table.insert(lines, string.format("%d: %s", i, format_item(item)))
  end

  table.insert(lines, "Select (1-" .. #items .. "): ")
  local prompt = table.concat(lines, "\n")

  local ok, input = pcall(vim.fn.input, prompt, "1")
  vim.cmd.redraw()

  if not ok or input == "" then
    on_choice(nil, nil)
    return
  end

  local choice = tonumber(input)
  if not choice or choice < 1 or choice > #items then
    on_choice(nil, nil)
  else
    on_choice(items[choice], choice)
  end
end
