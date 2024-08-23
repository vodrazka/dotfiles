local prefix = vim.fn.expand("~/.config")
local opt = vim.opt
-- basics
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "set formatoptions-=o" }) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "set formatoptions-=r" }) --do not add comments from normal mode (o,O) - bug https://github.com/nvim-lualine/lualine.nvim/issues/733
-- toot
vim.opt.backupcopy = 'yes'
-- intendation
opt.completeopt:remove "preview"
opt.wrap = false
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 0 -- inherit from tabstop
opt.softtabstop = -1 --inherit from shiftwidth
opt.listchars:append { tab = '<->' }
opt.listchars:append { space = '.' }
opt.listchars:append { nbsp = '␣' }
opt.listchars:append { trail = '-' }
opt.listchars:append { extends = '>' }
opt.listchars:append { precedes = '<' }
opt.listchars:append { eol = '$' }
opt.mouse = ''
opt.signcolumn = 'yes'
-- undo
opt.undodir = { prefix .. "/nvim/.undo//" }
opt.undofile = true
opt.directory = { prefix .. "/nvim/.swp//" }
-- terminal
opt.termguicolors = true
-- nu and gutter
opt.number = true
opt.numberwidth = 2
opt.relativenumber = false
opt.cursorline = true
-- fold
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true
-- functions
function get_visual_selection()
    -- Get the current buffer
    local buf = vim.api.nvim_get_current_buf()

    -- Get the start and end positions of the visual selection using getpos
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- Extract the line and column for start and end positions
    local start_line = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_line = end_pos[2] - 1
    local end_col = end_pos[3] - 1

    -- Adjust end_col if the selection is inclusive
    if start_line == end_line and start_col <= end_col then
        end_col = end_col + 1
    end

    -- Get the selected text
    local selected_text = vim.api.nvim_buf_get_text(buf, start_line, start_col, end_line, end_col, {})

    -- Join the selected text into a single string (optional)
    local result = table.concat(selected_text, '\n')

    print(result)
end
